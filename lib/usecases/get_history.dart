import 'package:github_api_project/datasources/hive_repos_datasource.dart';
import 'package:github_api_project/domain/repo.dart';
import 'package:injectable/injectable.dart';

@injectable
class GetReposToHistoryUseCase {
  final HiveReposDatasource _reposDatasource;

  GetReposToHistoryUseCase(this._reposDatasource);

  List<Repo> execute() {
    return _reposDatasource.historyRepos;
  }
}
