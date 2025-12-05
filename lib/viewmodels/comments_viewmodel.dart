import 'package:flutter/material.dart';
import '../services/comments_service.dart';
import '../models/comment.dart';


enum CommentsStatus { initial, loading, loaded, error }

class CommentsViewModel extends ChangeNotifier {
  final CommentsService _commentsService = CommentsService();

  CommentsStatus _status = CommentsStatus.initial;
  String _errorMessage = '';
  List<Comment> _comments = [];

  String get errorMessage => _errorMessage;
  CommentsStatus get status => _status;
  List<Comment> get comments => _comments;

  Future<List<Comment>> fetchCommentsByPostId(int postId) async {
    _status = CommentsStatus.loading;
    notifyListeners();
    try {
      _comments = await _commentsService.fetchCommentsForPost(postId);
      _status = CommentsStatus.loaded;
      notifyListeners();
    } catch (e) {
      _errorMessage = e.toString();
      _status = CommentsStatus.error;
      notifyListeners();
    }
    return _comments;
  }
}