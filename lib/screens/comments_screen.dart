import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter/services.dart';
import '../viewmodels/comments_viewmodel.dart';
import '../models/post.dart';

class CommentsScreen extends StatelessWidget {
  final Post post;

  const CommentsScreen({super.key, required this.post});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => CommentsViewModel(),
      child: _CommentsScreenState(post: post),
    );
  }
}

class _CommentsScreenState extends StatefulWidget {
  final Post post;

  const _CommentsScreenState({required this.post});

  @override
  State<_CommentsScreenState> createState() => _CommentsScreenContent();
}

class _CommentsScreenContent extends State<_CommentsScreenState> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<CommentsViewModel>(
        context,
        listen: false,
      ).fetchCommentsByPostId(widget.post.id);
    });
  }

  @override
  Widget build(BuildContext context) {
    final commentsViewModel = Provider.of<CommentsViewModel>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Comments',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
        ),
      ),
      body: _buildBody(commentsViewModel),
    );
  }

  Widget _buildBody(CommentsViewModel viewModel) {
    switch (viewModel.status) {
      case CommentsStatus.loading:
        return const Center(child: CircularProgressIndicator());
      case CommentsStatus.loaded:
        return ListView(
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.post.title,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(widget.post.body),
                ],
              ),
            ),

            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
              child: Text(
                'Comments',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
            ),
            ...viewModel.comments.map(
              (comment) => Card(
                margin:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: ListTile(
                  title: Text(comment.name,style: const TextStyle(fontWeight: FontWeight.bold)),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(comment.email,
                          style: const TextStyle(
                              fontStyle: FontStyle.italic, fontSize: 12)),
                      const SizedBox(height: 4),
                      Text(comment.body),
                    ],
                  ),
                ),
              ),
            )
          ]
        );
      case CommentsStatus.error:
        return Center(child: Text('Error: ${viewModel.errorMessage}'));
      default:
        return const SizedBox.shrink();
    }
  }
}
