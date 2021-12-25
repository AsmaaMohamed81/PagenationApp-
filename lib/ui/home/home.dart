import 'package:flutter/material.dart';
import 'package:pagination/data/model/posts.dart';
import 'package:pagination/ui/cubit/home/home_cubit.dart';
import 'package:pagination/ui/home/item.dart';
import 'package:pagination/ui/home/loading_more_components.dart';
import 'package:pagination/utils/app_colors.dart';
import 'package:pandabar/pandabar.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String page = 'Grey';
  static const _pageSize = 2;
  List<Posts> post = [];

  final PagingController<int, Posts> _pagingController =
      PagingController(firstPageKey: 0);

  @override
  void initState() {
    super.initState();
    BlocProvider.of<HomeCubit>(context).getAllPostes();
  }

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<HomeCubit>();
    return Scaffold(
      extendBody: true,
      appBar: AppBar(
        title: const Text("Postes"),
      ),
      bottomNavigationBar: PandaBar(
        fabIcon: Icon(Icons.home),
        buttonData: [
          PandaBarButtonData(id: 'Grey', icon: Icons.dashboard, title: 'Grey'),
          PandaBarButtonData(id: 'Blue', icon: Icons.book, title: 'Blue'),
          PandaBarButtonData(
              id: 'Red', icon: Icons.account_balance_wallet, title: 'Red'),
          PandaBarButtonData(
              id: 'Yellow', icon: Icons.notifications, title: 'Yellow'),
        ],
        onChange: (id) {
          setState(() {
            page = id;
          });
        },
        onFabButtonPressed: () {},
      ),
      body: Builder(
        builder: (context) {
          switch (page) {
            case 'Grey':
              return Container(color: Colors.grey.shade900);
            case 'Blue':
              return Container(color: Colors.blue.shade900);
            case 'Red':
              return Container(color: Colors.red.shade900);
            case 'Yellow':
              return BlocBuilder<HomeCubit, HomeState>(
                builder: (context, state) {
                  if (state is HomeLoadingState) {
                    return Center(
                      child: CircularProgressIndicator(color: mainAppColor),
                    );
                  } else if (state is FetchPostesSuccessState) {
                    return LoadMore(
                        isFinish: state.posts.length == 100,
                        onLoadMore: () async {
                          cubit.loadMore();
                          if (state is LoadedMoreState) {
                            post = state.posts;
                            return false;
                          }
                          return true;
                        },
                        child: ListView.builder(
                          itemCount: post.length,
                          itemBuilder: (context, index) {
                            return CharacterListItem(
                              post: post[index],
                            );
                          },
                        ));

                    // RefreshIndicator(
                    //   onRefresh: () => Future.sync(
                    //     () => _pagingController.refresh(),
                    //   ),
                    //   child: PagedListView<int, Posts>(
                    //     pagingController: _pagingController,
                    //     padding: EdgeInsets.only(
                    //       bottom: MediaQuery.of(context).padding.bottom + 150,
                    //     ),
                    //     builderDelegate: PagedChildBuilderDelegate<Posts>(
                    //       animateTransitions: true,
                    //       itemBuilder: (context, item, index) =>
                    //           CharacterListItem(
                    //         post: item,
                    //       ),
                    //     ),
                    //   ),
                    // );

                  } else if (state is StudentDashboardFailure) {
                    return Center(child: Text(state.message));
                  }
                  return Center(child: Text("$state"));
                },
              );

            default:
              return Container(
                child: Text(
                  "Ada",
                  style: TextStyle(color: Colors.white, fontSize: 50),
                ),
              );
          }
        },
      ),
    );
  }
}
