import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pagination/data/model/posts.dart';
import 'package:pagination/data/repositories/home_repository.dart';
part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  final HomeRepository homeRepository;
  HomeCubit({this.homeRepository}) : super(HomeInitial());

  bool isLoading = false;
  List<Posts> apiPostes = [];
  List<Posts> myPostsList = [];

  Future<void> getAllPostes() async {
    apiPostes = await homeRepository.getAllPostes();
    myPostsList = apiPostes;
    emit(FetchPostesSuccessState(apiPostes));
    loadMore();
  }

  void loadMore() {
    emit(LoadingMoreState());
    Future.delayed(Duration(microseconds: 1000), () {
      _getRangeOfList(pageRange: myPostsList.length);
    });
    emit(LoadedMoreState(myPostsList));
  }

  void _getRangeOfList({int pageRange}) {
    final temItems = apiPostes.getRange(pageRange, pageRange + 10);
    myPostsList.addAll(temItems);
  }

  void changeLoadingView() {
    isLoading = !isLoading;
    emit(HomeLoadingState(isLoading));
  }
}
