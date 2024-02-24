import 'package:github_api_project/datasources/hive_history_datasource.dart';
import 'package:github_api_project/datasources/repos_datasource.dart';
import 'package:github_api_project/domain/repo.dart';
import 'package:injectable/injectable.dart';

@injectable
class SearchReposUseCase {
  final HiveHistoryDatasource _historyDatasource;

  SearchReposUseCase(this._historyDatasource);

  Future<List<Repo>> execute(String searchText) async {
    final DataSource dataSource = DataSource();

    final repos = await dataSource.getRepos(searchText);
    await _historyDatasource.saveRepos(repos);

    return repos;
  }
}
