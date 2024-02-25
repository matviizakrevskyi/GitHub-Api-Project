import 'package:github_api_project/datasources/hive_favorites_datasource.dart';
import 'package:github_api_project/datasources/hive_history_datasource.dart';
import 'package:github_api_project/domain/repo.dart';
import 'package:injectable/injectable.dart';

@injectable
class PutOrDeleteFavoriteRepoUseCase {
  final HiveFavoritesDatasource _favoritesDatasource;
  final HiveHistoryDatasource _historyDatasource;

  PutOrDeleteFavoriteRepoUseCase(this._favoritesDatasource, this._historyDatasource);

  List<Repo> execute(Repo repo, List<Repo> allRepos) {
    final isAdded = _favoritesDatasource.putOrDeleteRepo(repo);

    final index = allRepos.indexWhere((element) => element.name == repo.name);
    allRepos.removeAt(index);
    allRepos.insert(index, repo.copyWith(isFavorite: isAdded));

    _historyDatasource.saveRepos(allRepos);
    return allRepos;
  }
}
