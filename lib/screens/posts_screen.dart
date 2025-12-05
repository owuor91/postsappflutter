import 'package:flutter/material.dart';
import '../viewmodels/posts_viewmodel.dart';
import 'package:provider/provider.dart';
import 'package:flutter/services.dart';

class PostsScreen extends StatelessWidget{
  const PostsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_)=> PostsViewModel(),
      child: const _PostsScreenState(),
    );
  }
}

class _PostsScreenState extends StatefulWidget {
  const _PostsScreenState();

  @override
  State<_PostsScreenState> createState() => _PostsScreenContent();
}

class _PostsScreenContent extends State<_PostsScreenState> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<PostsViewModel>(context, listen: false).fetchPosts();
    });
  }

  @override
  Widget build(BuildContext context) {
    final postsViewModel = Provider.of<PostsViewModel>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Posts'),
      ),
      body: _buildBody(postsViewModel),
    );
  }

  Widget _buildBody(PostsViewModel viewModel) {
    switch (viewModel.status) {
      case PostsStatus.loading:
        return const Center(child: CircularProgressIndicator());
      case PostsStatus.loaded:
        return ListView.builder(
          itemCount: viewModel.posts.length,
          itemBuilder: (context, index) {
            final post = viewModel.posts[index];
            return Card(
              margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: ListTile(
                title: Text(post.title, style: const TextStyle(fontWeight: FontWeight.bold)),
                subtitle: Text(post.body),
              ),
            );
          },
        );
      case PostsStatus.error:
        return Center(child: Text('Error: ${viewModel.errorMessage}'));
      default:
        return const SizedBox.shrink();
    }
  }
}