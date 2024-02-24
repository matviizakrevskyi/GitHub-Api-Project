part of 'home_cubit.dart';

class HomeState {
  final List<String> searchHistoryList;

  HomeState(this.searchHistoryList);

  HomeState copyWith(List<String>? searchHistoryList) {
    return HomeState(searchHistoryList ?? this.searchHistoryList);
  }
}
