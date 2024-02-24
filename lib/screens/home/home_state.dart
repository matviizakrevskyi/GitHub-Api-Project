part of 'home_cubit.dart';

class HomeState {
  final List<Repo> historyItems;
  final List<Repo> currentItems;
  final bool isFocused;
  final bool isLoading;

  HomeState(this.historyItems, this.currentItems, this.isFocused, this.isLoading);

  HomeState copyWith(
      {List<Repo>? historyItems, List<Repo>? currentItems, bool? isFocused, bool? isLoading}) {
    return HomeState(historyItems ?? this.historyItems, currentItems ?? this.currentItems,
        isFocused ?? this.isFocused, isLoading ?? this.isLoading);
  }
}
