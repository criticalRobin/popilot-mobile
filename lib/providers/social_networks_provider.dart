import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:popilot_mobile/models/facebook.dart';
import 'package:popilot_mobile/models/social_networks_response.dart';
import 'package:popilot_mobile/models/x.dart';

final socialNetworkProvider =
    StateNotifierProvider<SocialNetworksNotifier, SocialNetworksState>(
  (ref) => SocialNetworksNotifier(),
);

class SocialNetworksState {
  final bool isLoading;

  SocialNetworksState({required this.isLoading});
}

class SocialNetworksNotifier extends StateNotifier<SocialNetworksState> {
  final _dio = Dio();
  final _storage = FlutterSecureStorage();
  final baseUrl = 'http://10.0.2.2:8000/api/social-network';

  SocialNetworksNotifier() : super(SocialNetworksState(isLoading: false));

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

  Future<bool> createFacebookAccount(FacebookModel fb) async {
    try {
      state = SocialNetworksState(isLoading: true);
      _dio.options.headers['Authorization'] =
          'Bearer ${await _storage.read(key: 'token')}';
      final response = _dio.post(
        '$baseUrl/create/',
        data: {
          'social_network_type': fb.socialNetworkType,
          'name': fb.name,
          'page_id': fb.pageId,
          'page_access_token': fb.pageAccessToken,
        },
      );

      if ((await response).statusCode == 201) {
        return true;
      }

      state = SocialNetworksState(isLoading: false);
      return false;
    } catch (e) {
      state = SocialNetworksState(isLoading: false);
      return false;
    }
  }

  Future<bool> createXAccount(XModel x) async {
    try {
      state = SocialNetworksState(isLoading: true);
      _dio.options.headers['Authorization'] =
          'Bearer ${await _storage.read(key: 'token')}';
      final response = _dio.post(
        '$baseUrl/create/',
        data: {
          'social_network_type': x.socialNetworkType,
          'name': x.name,
          "access_key": x.accessKey,
          "access_secret": x.accessSecret,
          "consumer_key": x.consumerKey,
          "consumer_secret": x.consumerSecret,
          "bearer_token": x.bearerToken
        },
      );

      if ((await response).statusCode == 201) {
        return true;
      }

      state = SocialNetworksState(isLoading: false);
      return false;
    } catch (e) {
      state = SocialNetworksState(isLoading: false);
      return false;
    }
  }
}
