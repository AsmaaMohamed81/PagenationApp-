import 'package:pagination/data/api/dio_consumer.dart';
import 'package:pagination/data/model/posts.dart';

abstract class HomeRepository {
  Future<List<Posts>> getAllPostes();
}

class HomeRepositoryImp implements HomeRepository {
  final DioConsumer dioConsumer;
  HomeRepositoryImp({this.dioConsumer});

  @override
  Future<List<Posts>> getAllPostes() async {
    String postUrl = "https://jsonplaceholder.typicode.com/posts";
    List<Posts> postsList;

    final response = await dioConsumer.get(postUrl);

    Iterable iterable = response;
    postsList = iterable.map((model) => Posts.fromJson(model)).toList();
    return postsList;
  }
}
