part of 'home_cubit.dart';

class HomeState {
  final List<Repo> items;
  final bool isFocused;
  final bool isLoading;

  HomeState(this.items, this.isFocused, this.isLoading);

  HomeState copyWith({List<Repo>? items, bool? isFocused, bool? isLoading}) {
    return HomeState(items ?? this.items, isFocused ?? this.isFocused, isLoading ?? this.isLoading);
  }
}
