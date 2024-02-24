import 'package:github_api_project/datasources/repos_datasource.dart';
import 'package:github_api_project/domain/repo.dart';
import 'package:injectable/injectable.dart';

@injectable
class SearchReposUseCase {
  SearchReposUseCase();

  Future<List<Repo>> execute(String searchText) async {
    final DataSource dataSource = DataSource();

    return dataSource.getRepos(searchText);
  }
}
