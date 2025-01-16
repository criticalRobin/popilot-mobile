import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:popilot_mobile/models/post.dart';

final postProvider =
    StateNotifierProvider<PostNotifier, List<PostModel>>((ref) {
  return PostNotifier();
});

class PostNotifier extends StateNotifier<List<PostModel>> {
  final _dio = Dio();
  final _storage = FlutterSecureStorage();
  final _baseUrl = 'http://10.0.2.2:8000/api';

  PostNotifier() : super([]);

  Future<void> fetchPosts() async {
    try {
      final token = await _storage.read(key: 'token');
      _dio.options.headers['Authorization'] = 'Bearer $token';

      final response = await _dio.get('$_baseUrl/post/list/');
      final posts = (response.data as List)
          .map((postData) => PostModel.fromJson(postData))
          .toList();

      state = posts;
    } catch (e) {
      // Handle error
      print('Error fetching posts: $e');
    }
  }

  Future<void> fetchScheduledPosts() async {
    try {
      final token = await _storage.read(key: 'token');
      _dio.options.headers['Authorization'] = 'Bearer $token';

      final response = await _dio.get('$_baseUrl/post/list/scheduled/');
      final posts = (response.data as List)
          .map((postData) => PostModel.fromJson(postData))
          .toList();

      state = posts;
    } catch (e) {
      // Handle error
      print('Error fetching scheduled posts: $e');
    }
  }

  Future createPost(Map formData) async {
    try {
      final token = await _storage.read(key: 'token');
      _dio.options.headers['Authorization'] = 'Bearer $token';

      // Crear un nuevo FormData
      final dioFormData = FormData();

      // Añadir campos de texto
      dioFormData.fields.addAll([
        MapEntry('title', formData['title'] as String),
        MapEntry('description', formData['description'] as String),
        // Convertir IDs de redes sociales a strings
        ...((formData['social_networks'] as List)
            .map((id) => MapEntry('social_networks', id.toString()))),
      ]);

      // Añadir imagen si existe
      if (formData['image'] != null) {
        dioFormData.files.add(MapEntry(
            'image',
            await MultipartFile.fromFile((formData['image'] as File).path,
                filename: (formData['image'] as File).path.split('/').last)));
      }

      // Si hay fecha programada, añadirla
      if (formData['scheduledAt'] != null) {
        dioFormData.fields
            .add(MapEntry('scheduled_at', formData['scheduledAt'].toString()));
      }

      final response = await _dio.post(
        '$_baseUrl/post/create/',
        data: dioFormData,
        options: Options(
          headers: {
            'Content-Type': 'multipart/form-data',
          },
        ),
      );

      // Solo intenta crear un nuevo post si la respuesta no está vacía
      if (response.data != null) {
        final newPost = PostModel.fromJson(response.data);
        state = [...state, newPost];
      }
    } on DioException catch (e) {
      // Manejo más detallado de errores de Dio
      print('Error creating post - Response: ${e.response?.data}');
      print('Error creating post - Status Code: ${e.response?.statusCode}');
      rethrow;
    } catch (e) {
      print('Error creating post: $e');
      rethrow;
    }
  }
}
