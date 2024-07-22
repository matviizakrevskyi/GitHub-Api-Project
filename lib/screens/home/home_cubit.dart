import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:github_api_project/domain/repo.dart';
import 'package:github_api_project/main.dart';
import 'package:github_api_project/usecases/get_history_stream.dart';
import 'package:github_api_project/usecases/put_delete_favorites.dart';
import 'package:github_api_project/usecases/search_repos.dart';
import 'package:injectable/injectable.dart';

part 'home_state.dart';

@injectable
class HomeCubit extends Cubit<HomeState> {
  final SearchReposUseCase _searchReposUseCase;
  final PutOrDeleteFavoriteRepoUseCase _putOrDeleteFavoriteRepoUseCase;
  final GetHistoryStreamUseCase _getHistoryStreamUseCase;

  late StreamSubscription _subscription;

  TextEditingController textController = TextEditingController();

  HomeCubit(
      this._searchReposUseCase, this._putOrDeleteFavoriteRepoUseCase, this._getHistoryStreamUseCase)
      : super(const HomeState([], false, false, true)) {
    initializeHistoryStream();
  }

  initializeHistoryStream() {
    _subscription = _getHistoryStreamUseCase.execute().listen((event) {
      emit(state.copyWith(items: event));
    });
  }

  toFavorites() {
    navigatorKey.currentState?.pushNamed('/favorites');
  }

  search() async {
    if (textController.text.isNotEmpty) {
      emit(state.copyWith(isLoading: true));
      await _searchReposUseCase.execute(textController.text);
      emit(state.copyWith(isLoading: false, isHistory: false));
    }
  }

  onFavorite(Repo item) {
    _putOrDeleteFavoriteRepoUseCase.execute(item, state.items);
  }

  changeFocus(bool isFocused) {
    emit(state.copyWith(isFocused: isFocused));
  }

  @override
  Future<void> close() {
    _subscription.cancel();
    return super.close();
  }
}
