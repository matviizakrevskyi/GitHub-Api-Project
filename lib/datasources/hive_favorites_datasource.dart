import 'package:github_api_project/domain/hive_constants.dart';
import 'package:github_api_project/domain/hive_repo.dart';
import 'package:github_api_project/domain/repo.dart';
import 'package:hive/hive.dart';
import 'package:injectable/injectable.dart';
import 'package:rxdart/rxdart.dart';

@lazySingleton
class HiveFavoritesDatasource {
  final Box<RepoEntity> _favoritesBox;

  HiveFavoritesDatasource(@Named(favoritesBoxKey) this._favoritesBox);

  bool putOrDeleteRepo(Repo repo) {
    final savedRepo = _favoritesBox.get(repo.name);
    if (savedRepo != null) {
      _favoritesBox.delete(repo.name);
      return false;
    } else {
      _favoritesBox.put(repo.name, repo.copyWith(isFavorite: true).toEntityModel);
      return true;
    }
  }

  delete(Repo repo) {
    if (_favoritesBox.get(repo.name) != null) {
      _favoritesBox.delete(repo.name);
    }
  }

  List<Repo> get favoriteRepos {
    return _favoritesBox.values.map((e) => e.toDomainModel).toList();
  }

  Stream<List<Repo>> get favoritesStream {
    return _favoritesBox
        .watch()
        .debounceTime(const Duration(milliseconds: 500))
        .map((event) => _favoritesBox.values.map((e) => e.toDomainModel).toList())
        .startWith(favoriteRepos)
        .distinct();
  }
}
