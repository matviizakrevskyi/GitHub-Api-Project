class FavoritesState {
  final List<String> items;
  final bool isLoading;

  FavoritesState(this.items, this.isLoading);

  FavoritesState copyWith({List<String>? items, bool? isLoading}) =>
      FavoritesState(items ?? this.items, isLoading ?? this.isLoading);
}
