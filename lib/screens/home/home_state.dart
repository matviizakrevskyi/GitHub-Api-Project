part of 'home_cubit.dart';

class HomeState {
  final List<String> searchHistoryList;
  final bool isFocused;

  HomeState(this.searchHistoryList, this.isFocused);

  HomeState copyWith({List<String>? searchHistoryList, bool? isFocused}) {
    return HomeState(searchHistoryList ?? this.searchHistoryList, isFocused ?? this.isFocused);
  }
}
