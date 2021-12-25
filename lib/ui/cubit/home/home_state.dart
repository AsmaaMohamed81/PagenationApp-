part of 'home_cubit.dart';

abstract class HomeState {}

class HomeInitial extends HomeState {}

class HomeLoadingState extends HomeState {
  final bool isLoading;
  HomeLoadingState(this.isLoading);
}

class FetchPostesSuccessState extends HomeState {
  final List<Posts> posts;

  FetchPostesSuccessState(
    this.posts,
  );
}

class LoadingMoreState extends HomeState {}

class LoadedMoreState extends HomeState {
  final List<Posts> loadedMorePosts;

  LoadedMoreState(this.loadedMorePosts);
}

class StudentDashboardFailure extends HomeState {
  final String message;
  StudentDashboardFailure({this.message});
}
