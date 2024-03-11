import 'package:github_api_project/datasources/hive_repos_datasource.dart';
import 'package:github_api_project/domain/repo.dart';
import 'package:injectable/injectable.dart';

@injectable
class GetHistoryStreamUseCase {
  final HiveReposDatasource _reposDatasource;

  GetHistoryStreamUseCase(this._reposDatasource);

  Stream<List<Repo>> execute() {
    return _reposDatasource.historyStream;
  }
}
