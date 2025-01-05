import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:popilot_mobile/models/social_networks_response.dart';

final socialNetworkProvider =
    StateNotifierProvider<SocialNetworksNotifier, SocialNetworksState>(
  (ref) => SocialNetworksNotifier(),
);

class SocialNetworksState {
  SocialNetworksState();
}

class SocialNetworksNotifier extends StateNotifier<SocialNetworksState> {
  final _dio = Dio();
  final _storage = FlutterSecureStorage();
  final baseUrl = 'http://10.0.2.2:8000/api/social-network';

  SocialNetworksNotifier() : super(SocialNetworksState());

  Future<SocialNetworksResponseModel?> getSocialNetworks() async {
    try {
      _dio.options.headers['Authorization'] =
          'Bearer ${await _storage.read(key: 'token')}';
      final response = await _dio.get('$baseUrl/list');

      if (response.statusCode == 200) {
        final socialNetworks =
            SocialNetworksResponseModel.fromJson(response.data);

        if (socialNetworks.facebookAccounts.isEmpty &&
            socialNetworks.xAccounts.isEmpty) {
          return null;
        }

        return socialNetworks;
      }

      return null;
    } catch (e) {
      throw Exception('Error al cargar las redes sociales');
    }
  }
}
