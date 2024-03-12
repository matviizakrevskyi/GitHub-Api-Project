part of 'home_cubit.dart';

class HomeState {
  final List<Repo> items;
  final bool isFocused;
  final bool isLoading;
  final bool isHistory;

  HomeState(this.items, this.isFocused, this.isLoading, this.isHistory);

  HomeState copyWith({List<Repo>? items, bool? isFocused, bool? isLoading, bool? isHistory}) {
    return HomeState(items ?? this.items, isFocused ?? this.isFocused, isLoading ?? this.isLoading,
        isHistory ?? this.isHistory);
  }
}
