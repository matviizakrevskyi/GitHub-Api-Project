import 'package:github_api_project/domain/repo.dart';

class FavoritesState {
  final List<Repo> items;
  final bool isLoading;

  FavoritesState(this.items, this.isLoading);

  FavoritesState copyWith({List<Repo>? items, bool? isLoading}) =>
      FavoritesState(items ?? this.items, isLoading ?? this.isLoading);
}
