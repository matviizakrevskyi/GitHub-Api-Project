import 'package:injectable/injectable.dart';

@injectable
class SearchReposUseCase {
  SearchReposUseCase();

  List<String> execute() {
    print('Lol, this is Search Repos UseCase');
    return ["1", "2"];
  }
}
