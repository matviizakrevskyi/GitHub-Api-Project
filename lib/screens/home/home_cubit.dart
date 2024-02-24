import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:github_api_project/domain/repo.dart';
import 'package:github_api_project/main.dart';
import 'package:github_api_project/usecases/search_repos.dart';
import 'package:injectable/injectable.dart';

part 'home_state.dart';

@injectable
class HomeCubit extends Cubit<HomeState> {
  final SearchReposUseCase _searchReposUseCase;

  TextEditingController textController = TextEditingController();

  HomeCubit(this._searchReposUseCase) : super(HomeState([], [], false, false));

  onFavorite() {
    navigatorKey.currentState?.pushNamed('/favorites');
  }

  search() async {
    if (textController.text.isNotEmpty) {
      emit(state.copyWith(isLoading: true));
      final data = await _searchReposUseCase.execute(textController.text);
      emit(state.copyWith(currentItems: [...data], isLoading: false));
    }
  }

  makeFavorite(Repo item) {
    
  }

  changeFocus(bool isFocused) {
    emit(state.copyWith(isFocused: isFocused));
  }
}
