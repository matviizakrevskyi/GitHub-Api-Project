import 'package:github_api_project/datasources/hive_repos_datasource.dart';
import 'package:github_api_project/datasources/repos_datasource.dart';
import 'package:injectable/injectable.dart';

@injectable
class SearchReposUseCase {
  final HiveReposDatasource _reposDatasource;

  SearchReposUseCase(this._reposDatasource);

  Future<void> execute(String searchText) async {
    final repos = await ApiDataSource.getRepos(searchText);
    await _reposDatasource.saveRepos(repos);
  }
}
