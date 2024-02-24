import 'package:github_api_project/datasources/hive_history_datasource.dart';
import 'package:github_api_project/domain/repo.dart';
import 'package:injectable/injectable.dart';

@injectable
class SaveReposToHistoryUseCase {
  final HiveHistoryDatasource _historyDatasource;

  SaveReposToHistoryUseCase(this._historyDatasource);

  Future execute(List<Repo> repos) async {
    await _historyDatasource.saveRepos(repos);
  }
}
