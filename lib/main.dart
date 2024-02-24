import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:github_api_project/di/injection.dart';
import 'package:github_api_project/screens/favorites/favorites_cubit.dart';
import 'package:github_api_project/screens/favorites/favorites_screen.dart';
import 'package:github_api_project/screens/home/home_cubit.dart';
import 'package:github_api_project/screens/home/home_screen.dart';
import 'package:github_api_project/styling/styling.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await configureDependencies();
  runApp(MyApp(
    navigatorKey: navigatorKey,
  ));
}

class MyApp extends StatelessWidget {
  final GlobalKey<NavigatorState> navigatorKey;

  const MyApp({super.key, required this.navigatorKey});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(colorScheme: CustomColors.colorSheme),
      navigatorKey: navigatorKey,
      routes: {
        '/': (context) => BlocProvider<HomeCubit>(
              create: (BuildContext context) => getIt.get(),
              child: HomeScreen(),
            ),
        '/favorites': (context) => BlocProvider<FavoritesCubit>(
              create: (BuildContext context) => getIt.get(),
              child: FavoritesScreen(),
            )
      },
    );
  }
}
