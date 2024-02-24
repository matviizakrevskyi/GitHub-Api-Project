import 'package:github_api_project/datasources/hive_history_datasource.dart';
import 'package:github_api_project/domain/repo.dart';
import 'package:injectable/injectable.dart';

@injectable
class GetReposToHistoryUseCase {
  final HiveHistoryDatasource _historyDatasource;

  GetReposToHistoryUseCase(this._historyDatasource);

  List<Repo> execute() {
    return _historyDatasource.allRepos;
  }
}
