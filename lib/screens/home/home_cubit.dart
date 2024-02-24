import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:github_api_project/main.dart';
import 'package:github_api_project/usecases/search_repos.dart';
import 'package:injectable/injectable.dart';

part 'home_state.dart';

@injectable
class HomeCubit extends Cubit<HomeState> {
  final SearchReposUseCase _searchReposUseCase;

  TextEditingController textController = TextEditingController();

  HomeCubit(this._searchReposUseCase) : super(HomeState([], false));

  onFavorite() {
    navigatorKey.currentState?.pushNamed('/favorites');
  }

  search() {
    _searchReposUseCase.execute();
  }

  changeFocus(bool isFocused) {
    emit(state.copyWith(isFocused: isFocused));
  }
}
