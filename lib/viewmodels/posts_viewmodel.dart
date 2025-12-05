import 'package:flutter/material.dart';
import '../services/posts_service.dart';
import '../models/post.dart';

enum PostsStatus { initial, loading, loaded, error }

class PostsViewModel extends ChangeNotifier {
  // ViewModel code here
  final PostsService _postsService = PostsService();

  PostsStatus _status = PostsStatus.initial;
  String _errorMessage = '';
  List<Post> _posts = [];
  Post? _post =null;

  String get errorMessage => _errorMessage;
  PostsStatus get status => _status;
  List<Post> get posts => _posts;
  Post? get post => _post;


  Future<List<Post>> fetchPosts() async {
    _status = PostsStatus.loading;
    try {
      _posts = await _postsService.fetchPosts();
      _status = PostsStatus.loaded;
      notifyListeners();
    } catch (e) {
      _errorMessage = e.toString();
      _status = PostsStatus.error;
      notifyListeners();
    }
    return _posts;
  }

  Future<Post?> fetchPostById(int postId) async {
    _status = PostsStatus.loading;
    try {
      _post = await _postsService.fetchPostById(postId);
      _status = PostsStatus.loaded;
      notifyListeners();
    } catch (e) {
      _errorMessage = e.toString();
      _status = PostsStatus.error;
      notifyListeners();
    }
    return _post;
  }
}