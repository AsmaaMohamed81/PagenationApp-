import 'package:flutter/material.dart';
import 'package:pagination/ui/cubit/home/home_cubit.dart';
import 'package:loadmore/loadmore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pagination/ui/home/widgets/post_item.dart';

class PostsScreen extends StatefulWidget {
  const PostsScreen({Key key}) : super(key: key);

  @override
  State<PostsScreen> createState() => _PostsScreenState();
}

class _PostsScreenState extends State<PostsScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeCubit, HomeState>(
      builder: (context, state) {
        if (state is PostsLoadingState) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (state is FetchPostesSuccessState) {
          return Padding(
            padding: const EdgeInsets.only(bottom: 70),
            child: LoadMore(
              isFinish: state.posts.length >= 100,
              onLoadMore: _loadMore,
              child: ListView.builder(
                padding: EdgeInsets.zero,
                itemCount: state.posts.length,
                itemBuilder: (context, index) {
                  return PostItem(
                    post: state.posts[index],
                    index: index,
                  );
                },
              ),
              whenEmptyLoad: false,
              delegate: const DefaultLoadMoreDelegate(),
              textBuilder: DefaultLoadMoreTextBuilder.english,
            ),
          );
        } else if (state is FailurePostesState) {
          return Center(child: Text(state.message));
        }
        return Center(child: Text("$state"));
      },
    );
  }

  Future<bool> _loadMore() async {
    await Future.delayed(const Duration(seconds: 0, milliseconds: 2000));
    context.read<HomeCubit>().loadMore();
    return true;
  }
}
