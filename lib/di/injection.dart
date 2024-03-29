import "package:get_it/get_it.dart";
import "package:github_api_project/domain/hive_constants.dart";
import "package:github_api_project/domain/hive_repo.dart";
import "package:hive/hive.dart";
import "package:injectable/injectable.dart";
import "package:path_provider/path_provider.dart";

import "injection.config.dart";

final getIt = GetIt.instance;

@InjectableInit()
Future configureDependencies() async {
  await _initHive();

  getIt.init();
}

Future _initHive() async {
  final appDocumentDir = await getApplicationDocumentsDirectory();
  Hive.init(appDocumentDir.path);

  Hive.registerAdapter(RepoEntityAdapter());

  if (!getIt.isRegistered<Box<RepoEntity>>(instanceName: reposBoxKey)) {
    final box = await Hive.openBox<RepoEntity>(reposBoxKey);
    getIt.registerSingleton<Box<RepoEntity>>(box, instanceName: reposBoxKey);
  }
}
