import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:github_api_project/main.dart';
import 'package:github_api_project/screens/favorites/favorites_state.dart';
import 'package:injectable/injectable.dart';

@injectable
class FavoritesCubit extends Cubit<FavoritesState> {
  FavoritesCubit() : super(FavoritesState([], true));

  back() {
    navigatorKey.currentState?.pop();
  }
}
