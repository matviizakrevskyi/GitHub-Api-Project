import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:github_api_project/usecases/search_repos.dart';
import 'package:injectable/injectable.dart';

part 'home_state.dart';

@injectable
class HomeCubit extends Cubit<HomeState> {
  final SearchReposUseCase _searchReposUseCase;

  HomeCubit(this._searchReposUseCase) : super(HomeState([]));

  onFavorite() {
    _searchReposUseCase.execute();
  }

  search() {
    _searchReposUseCase.execute();
  }
}
