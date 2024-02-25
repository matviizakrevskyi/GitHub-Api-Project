import 'package:github_api_project/datasources/hive_favorites_datasource.dart';
import 'package:github_api_project/domain/repo.dart';
import 'package:injectable/injectable.dart';

@injectable
class GetFavoritesStreamUseCase {
  final HiveFavoritesDatasource _favoritesDatasource;

  GetFavoritesStreamUseCase(this._favoritesDatasource);

  Stream<List<Repo>> execute() {
    return _favoritesDatasource.favoritesStream;
  }
}
