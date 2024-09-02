import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:soul_sphere/domain/repository/post_repository.dart';
import 'package:soul_sphere/presentation/feature/post/bloc/post_bloc.dart';
import 'package:soul_sphere/presentation/feature/post/bloc/post_event.dart';
import 'package:soul_sphere/presentation/feature/post/bloc/post_state.dart';
import 'package:soul_sphere/presentation/widgets/custom_app_bar.dart';
import 'package:soul_sphere/presentation/widgets/post_item.dart';

class MomentScreen extends StatelessWidget {
  const MomentScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final postRepository = GetIt.instance<PostRepository>();

    return BlocProvider(
      create: (context) {
        final postBloc = PostBloc(postRepository);
        postBloc.add(LoadAllPostsEvent());
        return postBloc;
      },
      child: Scaffold(
        appBar: const CustomAppBar(title: 'Moments'),
        body: BlocBuilder<PostBloc, PostState>(
          builder: (context, state) {
            if (state is PostLoadingState) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is PostFailureState) {
              return Center(child: Text('Error: ${state.error}'));
            } else if (state is AllPostsLoadedState) {
              final posts = state.posts;
              if (posts.isEmpty) {
                return const Center(child: Text('No posts available'));
              }
              return ListView.builder(
                itemCount: posts.length,
                itemBuilder: (context, index) {
                  final post = posts[index];
                  return PostItem(post: post);
                },
              );
            }
            return const Center(child: Text('Something went wrong'));
          },
        ),
      ),
    );
  }
}
