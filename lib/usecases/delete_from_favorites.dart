import 'package:github_api_project/datasources/hive_favorites_datasource.dart';
import 'package:github_api_project/domain/repo.dart';
import 'package:injectable/injectable.dart';

@injectable
class DeleteFromFavoritesUseCase {
  final HiveFavoritesDatasource _favoritesDatasource;

  DeleteFromFavoritesUseCase(this._favoritesDatasource);

  execute(Repo repo) {
    _favoritesDatasource.delete(repo);
  }
}
