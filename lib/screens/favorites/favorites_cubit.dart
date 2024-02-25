import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:github_api_project/domain/repo.dart';
import 'package:github_api_project/main.dart';
import 'package:github_api_project/screens/favorites/favorites_state.dart';
import 'package:github_api_project/usecases/delete_from_favorites.dart';
import 'package:github_api_project/usecases/get_favorites_stream.dart';
import 'package:injectable/injectable.dart';

@injectable
class FavoritesCubit extends Cubit<FavoritesState> {
  final GetFavoritesStreamUseCase _getFavoritesStreamUseCase;
  final DeleteFromFavoritesUseCase _deleteFromFavoritesUseCase;

  late StreamSubscription _subscription;

  FavoritesCubit(this._getFavoritesStreamUseCase, this._deleteFromFavoritesUseCase)
      : super(FavoritesState([], true)) {
    _subscription = _getFavoritesStreamUseCase.execute().listen((event) {
      emit(state.copyWith(items: event, isLoading: false));
    });
  }

  deleteFromFavorites(Repo item) {
    _deleteFromFavoritesUseCase.execute(item);
  }

  back() {
    navigatorKey.currentState?.pop();
  }

  @override
  Future<void> close() {
    _subscription.cancel();
    return super.close();
  }
}
