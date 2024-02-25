import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:github_api_project/domain/repo.dart';
import 'package:github_api_project/main.dart';
import 'package:github_api_project/usecases/get_history.dart';
import 'package:github_api_project/usecases/put_delete_favorites.dart';
import 'package:github_api_project/usecases/search_repos.dart';
import 'package:injectable/injectable.dart';

part 'home_state.dart';

@injectable
class HomeCubit extends Cubit<HomeState> {
  final SearchReposUseCase _searchReposUseCase;
  final GetReposToHistoryUseCase _getReposToHistoryUseCase;
  final PutOrDeleteFavoriteRepoUseCase _putOrDeleteFavoriteRepoUseCase;

  TextEditingController textController = TextEditingController();

  HomeCubit(this._searchReposUseCase, this._getReposToHistoryUseCase,
      this._putOrDeleteFavoriteRepoUseCase)
      : super(HomeState([], [], false, false)) {
    final reposFromHistory = _getReposToHistoryUseCase.execute();
    emit(state.copyWith(historyItems: reposFromHistory));
  }

  toFavorites() {
    navigatorKey.currentState?.pushNamed('/favorites');
  }

  search() async {
    if (textController.text.isNotEmpty) {
      emit(state.copyWith(isLoading: true));
      final data = await _searchReposUseCase.execute(textController.text);
      emit(state.copyWith(currentItems: [...data], isLoading: false));
    }
  }

  onFavorite(Repo item) {
    final List<Repo> items = _putOrDeleteFavoriteRepoUseCase.execute(
        item, state.currentItems.isEmpty ? [...state.historyItems] : [...state.currentItems]);
    emit(state.copyWith(
        currentItems: state.currentItems.isEmpty ? [] : items,
        historyItems: state.currentItems.isEmpty ? items : []));
  }

  changeFocus(bool isFocused) {
    emit(state.copyWith(isFocused: isFocused));
  }
}
