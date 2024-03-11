import 'package:github_api_project/datasources/hive_repos_datasource.dart';
import 'package:github_api_project/domain/repo.dart';
import 'package:injectable/injectable.dart';

@injectable
class DeleteFromFavoritesUseCase {
  final HiveReposDatasource _reposDatasource;

  DeleteFromFavoritesUseCase(this._reposDatasource);

  execute(Repo repo) {
    _reposDatasource.delete(repo);
  }
}
