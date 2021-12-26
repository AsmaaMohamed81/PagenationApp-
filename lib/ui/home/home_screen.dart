import 'package:flutter/material.dart';
import 'package:pagination/ui/cubit/home/home_cubit.dart';
import 'package:pagination/ui/home/widgets/posts_screen.dart';
import 'package:pandabar/pandabar.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String page = 'posts';

  @override
  void initState() {
    super.initState();
    BlocProvider.of<HomeCubit>(context).getAllPosts();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      appBar: AppBar(title: const Text("Posts")),
      bottomNavigationBar: _pandBar(),
      body: Builder(
        builder: (context) {
          switch (page) {
            case 'profile':
              return Center(
                  child: _screenBar(
                      "assets/images/profile.gif", "Profile Screen"));
            case 'search':
              return Center(
                  child:
                      _screenBar("assets/images/search.gif", "Search Screen"));
            case 'document':
              return Center(
                  child: _screenBar(
                      "assets/images/document.gif", "Document Screen"));
            case 'delete':
              return Center(
                  child:
                      _screenBar("assets/images/delete.gif", "Delete Screen"));
            case 'posts':
              return const PostsScreen();
            default:
              return const PostsScreen();
          }
        },
      ),
    );
  }

  PandaBar _pandBar() {
    return PandaBar(
      buttonSelectedColor: page == 'posts' ? Colors.grey : Colors.blue,
      backgroundColor: Colors.white38,
      fabIcon: const Icon(
        Icons.home,
        color: Colors.white,
      ),
      buttonData: [
        PandaBarButtonData(
            id: 'profile',
            icon: Icons.person_outline_outlined,
            title: 'profile'),
        PandaBarButtonData(id: 'search', icon: Icons.search, title: 'search'),
        PandaBarButtonData(
            id: 'document',
            icon: Icons.document_scanner_sharp,
            title: 'document'),
        PandaBarButtonData(
            id: 'delete', icon: Icons.delete_outlined, title: 'delete'),
      ],
      onChange: (id) {
        setState(() => page = id);
      },
      onFabButtonPressed: () => setState(() => page = 'posts'),
    );
  }

  Widget _screenBar(String image, String title) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset(
          image,
          height: 200.0,
          width: 200.0,
        ),
        Text(
          title,
          style: const TextStyle(fontSize: 25),
        ),
      ],
    );
  }
}
