import 'api_service.dart';
import '../models/post.dart';
import '../utils/constants.dart';
import 'package:dio/dio.dart';

class PostsService {
  final ApiService _apiService = ApiService();

  Future<List<Post>> fetchPosts() async {
    try {
      final Response response = await _apiService.get(ApiConstants.postsEndpoint);
      final List<dynamic> data = response.data;
      return data.map((json) => Post.fromJson(json)).toList();
    } catch (e) {
      throw Exception('Failed to load posts: $e');
    }
  }
}