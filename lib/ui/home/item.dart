import 'package:flutter/material.dart';

import 'package:pagination/data/model/posts.dart';

class CharacterListItem extends StatelessWidget {
  final Posts post;
  const CharacterListItem({
    Key key,
    this.post,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Text(post.title),
    );
  }
}
