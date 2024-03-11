import 'package:github_api_project/api/api.dart';
import 'package:github_api_project/domain/repo.dart';

class ApiDataSource {
  static Future<List<Repo>> getRepos(String searchText) async {
    final GithubApi api = GithubApi();

    return (await api.fetchRepositories(searchText)).map((e) => e.toDomainModel).toList();
  }
}
