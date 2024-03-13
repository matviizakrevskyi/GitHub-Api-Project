# GitHub API APP

#### This is a simple app that uses the GitHub API. In this app, you can search for repositories by their names and add them to your favorites list.

There are two screens in the app:

* **HomeScreen** - the screen from which the app starts, it has a text input field to find repositories by their names. After the request, up to 15 repositories with the same or similar name appear on the screen. You can make a repository object a favorite by clicking on the star button next to it, after which the repository will be added to your favorites, and to remove it from your favorites, you just need to click on the star button again. There is also a button on this screen to go to the FavoritesScreen.

* **FavoritesScreen** - this screen displays all the repositories that have been added to your favorites. You can also remove a repository from your favorites on this screen.

The repositories that were found last are saved, so if you re-enter the app, the main screen will not be empty, but the last found repositories will be displayed as history. Similarly, all your favorite repositories are also saved. This all works with Hive DB, all repositories are stored in this local database.

For state management, I used the BLoC library, namely Cubit. I also used such design patterns in the project as: Dependency Injection, Singleton, Repository.

### All libraries and tools used:

* BLoC,
* Injector,
* GetIt
* Injectable,
* Dio,
* Hive,
* Hive Generator,
* RX Dart,
* Json Serializable

## How to Use

### Step 1

Here is the link to clone the repository:

```
    https://github.com/matviizakrevskyi/GitHub-Api-Project.git
```

### Step 2

Install dependencies:

```sh
    flutter pub get
```

### Step 3

Run code generation:

```sh
    flutter packages pub run build_runner build --delete-conflicting-outputs
```

### Step 4

Launch the app:

```sh
    flutter run
```