import 'package:pagination/data/api/dio_consumer.dart';
import 'package:pagination/data/model/posts.dart';

// HomeRepoImp
class HomeRepository implements HomeRepo {
  final DioConsumer dioConsumer;
  HomeRepository({this.dioConsumer});

  @override
  Future<List<Posts>> getAllPostes() async {
    List<Posts> levelList;

    final response =
        await dioConsumer.get("https://jsonplaceholder.typicode.com/posts");

    print(response);
    Iterable iterable = response;
    levelList = iterable.map((model) => Posts.fromJson(model)).toList();
    return levelList;
  }
}

abstract class HomeRepo {
  Future<List<Posts>> getAllPostes();
}
