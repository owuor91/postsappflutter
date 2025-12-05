import 'api_service.dart';
import '../models/comment.dart';
import '../utils/constants.dart';
import 'package:dio/dio.dart';


class CommentsService {
  final ApiService _apiService = ApiService();

  Future<List<Comment>> fetchCommentsForPost(int postId) async {
    try {
      final Response response = await _apiService.get(ApiConstants.commentsEndpoint(postId));
      final List<dynamic> data = response.data;
      return data.map((json) => Comment.fromJson(json)).toList();
    } catch (e) {
      throw Exception('Failed to load comments for post $postId: $e');
    }
  }
}