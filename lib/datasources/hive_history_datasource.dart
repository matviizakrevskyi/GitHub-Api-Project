import 'package:github_api_project/domain/hive_constants.dart';
import 'package:github_api_project/domain/hive_repo.dart';
import 'package:github_api_project/domain/repo.dart';
import 'package:hive/hive.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class HiveHistoryDatasource {
  final Box<RepoEntity> _historyBox;

  HiveHistoryDatasource(@Named(historyBoxKey) this._historyBox);

  saveRepos(List<Repo> repos) async {
    await _historyBox.clear();
    final reposToSave = repos.map((e) => e.toEntityModel).toList();
    for (var repo in reposToSave) {
      _historyBox.put(repo.name, repo);
    }
  }

  List<Repo> get allRepos {
    return _historyBox.values.map((e) => e.toDomainModel).toList();
  }
}
