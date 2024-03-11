import 'package:github_api_project/datasources/hive_repos_datasource.dart';
import 'package:github_api_project/domain/repo.dart';
import 'package:injectable/injectable.dart';

@injectable
class PutOrDeleteFavoriteRepoUseCase {
  final HiveReposDatasource _reposDatasource;

  PutOrDeleteFavoriteRepoUseCase(this._reposDatasource);

  execute(Repo repo, List<Repo> allRepos) {
    _reposDatasource.likeRepo(repo);
  }
}
