import 'package:github_api_project/domain/hive_constants.dart';
import 'package:github_api_project/domain/hive_repo.dart';
import 'package:github_api_project/domain/repo.dart';
import 'package:hive/hive.dart';
import 'package:injectable/injectable.dart';
import 'package:rxdart/rxdart.dart';

@LazySingleton()
class HiveReposDatasource {
  final Box<RepoEntity> _reposBox;

  HiveReposDatasource(@Named(reposBoxKey) this._reposBox);

  saveRepos(List<Repo> repos) async {
    clearNotLiked();
    clearHistory();
    for (var repo in repos) {
      final savedRepo = _reposBox.get(repo.id);
      if (savedRepo == null) {
        _reposBox.put(repo.id, repo.toEntityModel);
      } else {
        savedRepo.update(
            repo.copyWith(isFavorite: savedRepo.isFavorite, isFromHistory: true).toEntityModel);
        savedRepo.save();
      }
    }
  }

  clearNotLiked() {
    for (RepoEntity repo in _reposBox.values) {
      if (!repo.isFavorite) {
        _reposBox.delete(repo.id);
      }
    }
  }

  clearHistory() {
    for (RepoEntity repo in _reposBox.values) {
      repo.update(repo.copyWith(isFromHistory: false));
      repo.save();
    }
  }

  bool likeRepo(Repo repo) {
    final savedRepo = _reposBox.get(repo.id);
    if (savedRepo != null) {
      savedRepo.update(repo.copyWith(isFavorite: !repo.isFavorite).toEntityModel);
      savedRepo.save();
      return !repo.isFavorite;
    }
    return false;
  }

  delete(Repo repo) {
    if (_reposBox.get(repo.id) != null) {
      _reposBox.delete(repo.id);
    }
  }

  //history
  List<Repo> get historyRepos {
    final list =
        _reposBox.values.where((e) => e.isFromHistory).map((e) => e.toDomainModel).toList();
    list.sort((a, b) => a.dateOfAdding.compareTo(b.dateOfAdding));
    return list;
  }

  Stream<List<Repo>> get historyStream {
    return _reposBox
        .watch()
        .debounceTime(const Duration(milliseconds: 500))
        .map((event) {
          final list =
              _reposBox.values.where((e) => e.isFromHistory).map((e) => e.toDomainModel).toList();
          list.sort((a, b) => a.dateOfAdding.compareTo(b.dateOfAdding));
          return list;
        })
        .startWith(historyRepos)
        .distinct();
  }

  //favorites
  List<Repo> get favoriteRepos {
    return _reposBox.values.where((e) => e.isFavorite).map((e) => e.toDomainModel).toList();
  }

  Stream<List<Repo>> get favoritesStream {
    return _reposBox
        .watch()
        .debounceTime(const Duration(milliseconds: 500))
        .map((event) =>
            _reposBox.values.where((e) => e.isFavorite).map((e) => e.toDomainModel).toList())
        .startWith(favoriteRepos)
        .distinct();
  }
}
