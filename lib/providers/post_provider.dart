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

  Future<void> createPost(PostModel post) async {
    try {
      final token = await _storage.read(key: 'token');
      _dio.options.headers['Authorization'] = 'Bearer $token';

      final response = await _dio.post(
        '$_baseUrl/post/create/',
        data: post.toJson(),
      );

      final newPost = PostModel.fromJson(response.data);
      state = [...state, newPost];
    } catch (e) {
      // Handle error
      print('Error creating post: $e');
    }
  }
}
