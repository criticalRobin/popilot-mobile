import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:dio/dio.dart';
import 'package:popilot_mobile/models/user.dart';

final authProvider = StateNotifierProvider<AuthNotifier, AuthState>(
  (ref) => AuthNotifier(),
);

class AuthState {
  final bool isLoggedIn;
  final UserModel? user;
  final bool? isPremiumUser;
  final bool isLoading;

  AuthState(
      {required this.isLoggedIn,
      this.user,
      this.isPremiumUser,
      this.isLoading = false});
}

class AuthNotifier extends StateNotifier<AuthState> {
  final _dio = Dio();
  final storage = FlutterSecureStorage();
  final String baseUrl = 'http://10.0.2.2:8000/api';

  AuthNotifier() : super(AuthState(isLoggedIn: false));

  Future<bool> signIn(String username, String password) async {
    try {
      state = AuthState(isLoggedIn: false, isLoading: true);
      await storage.delete(key: 'token');

      final response = await _dio.post('$baseUrl/token/', data: {
        'username': username,
        'password': password,
      });

      final token = response.data['access'];

      if (token != null) {
        await storage.write(key: 'token', value: token);
        await getLoggedUser(token);
        return true;
      }
      return false;
    } catch (e) {
      state = AuthState(isLoggedIn: false, isLoading: false);
      return false;
    }
  }

  Future<bool> register(String username, String email, String password) async {
    try {
      state = AuthState(isLoggedIn: false, isLoading: true);
      final response = await _dio.post('$baseUrl/auth/create-user/', data: {
        'username': username,
        'email': email,
        'password': password,
      });

      if (response.statusCode == 201) {
        state = AuthState(isLoggedIn: false, isLoading: false);
        return true;
      }

      return false;
    } catch (e) {
      state = AuthState(isLoggedIn: false, isLoading: false);
      return false;
    }
  }

  Future<void> getLoggedUser(String token) async {
    try {
      _dio.options.headers['Authorization'] = 'Bearer $token';
      final response = await _dio.get('$baseUrl/auth/logged-user/');
      final user = UserModel.fromJson(response.data);
      storage.write(key: 'user', value: user.toJson().toString());
      state = AuthState(
          isLoggedIn: true,
          user: user,
          isPremiumUser: user.isPremiumUser,
          isLoading: false);
    } catch (e) {
      state = AuthState(isLoggedIn: false, isLoading: false);
    }
  }
}
