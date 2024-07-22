import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:github_api_project/domain/repo.dart';
import 'package:github_api_project/screens/home/home_cubit.dart';
import 'package:github_api_project/screens/home/home_screen.dart';
import 'package:github_api_project/screens/widgets/custom_text_field.dart';
import 'package:github_api_project/screens/widgets/repo_item_widget.dart';
import 'package:mocktail/mocktail.dart';

class MockHomeCubit extends MockCubit<HomeState> implements HomeCubit {
  @override
  late TextEditingController textController;

  MockHomeCubit() {
    textController = TextEditingController();
  }
}

void main() {
  group('Home Screen', () {
    late MockHomeCubit mockHomeCubit;
    const HomeState defaultState = HomeState([], false, false, true);
    final Repo defaultRepo = Repo("id", "name", 10);

    setUp(() {
      mockHomeCubit = MockHomeCubit();
    });

    Widget createWidgetUnderTest() {
      return BlocProvider<HomeCubit>(
        create: (context) => mockHomeCubit,
        child: MaterialApp(
          home: HomeScreen(),
        ),
      );
    }

    testWidgets("screen displays correctly when loading", (WidgetTester tester) async {
      // Arrange
      when(() => mockHomeCubit.state).thenReturn(defaultState);

      // Act
      await tester.pumpWidget(createWidgetUnderTest());

      // Assert
      expect(find.byType(CircularProgressIndicator), findsNothing);
      expect(find.byType(RepoItemWidget), findsNothing);
    });

    testWidgets('HomeScreen displays empty history message', (WidgetTester tester) async {
      // Arrange
      when(() => mockHomeCubit.state).thenReturn(defaultState);

      // Act
      await tester.pumpWidget(createWidgetUnderTest());

      // Assert
      expect(
          find.text("You have empty history.\nClick on search to start journey!"), findsOneWidget);
      expect(find.byType(RepoItemWidget), findsNothing);
    });

    testWidgets('HomeScreen displays list of repositories', (WidgetTester tester) async {
      // Arrange
      when(() => mockHomeCubit.state).thenReturn(HomeState([defaultRepo], false, false, true));

      // Act
      await tester.pumpWidget(createWidgetUnderTest());

      // Assert
      expect(find.byType(RepoItemWidget), findsOneWidget);
    });

    testWidgets('HomeScreen triggers search when search button is tapped',
        (WidgetTester tester) async {
      // Arrange
      when(() => mockHomeCubit.state).thenReturn(defaultState);
      when(() => mockHomeCubit.search()).thenAnswer((_) async {});

      // Act
      await tester.pumpWidget(createWidgetUnderTest());
      await tester.enterText(find.byType(CustomTextField), 'flutter');
      await tester.tap(find.byKey(const Key("SearchButtonKey")));
      await tester.pump();

      // Assert
      verify(() => mockHomeCubit.search()).called(1);
    });

    testWidgets('Favorites button triggers navigation', (WidgetTester tester) async {
      // Arrange
      when(() => mockHomeCubit.state).thenReturn(defaultState);
      when(() => mockHomeCubit.toFavorites()).thenAnswer((_) {});

      // Act
      await tester.pumpWidget(createWidgetUnderTest());
      await tester.tap(find.byType(InkResponse));
      await tester.pump();

      // Assert
      verify(() => mockHomeCubit.toFavorites()).called(1);
    });
  });
}
