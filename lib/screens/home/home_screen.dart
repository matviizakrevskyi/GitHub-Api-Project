import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:github_api_project/screens/home/home_cubit.dart';
import 'package:github_api_project/screens/widgets/custom_text_field.dart';
import 'package:github_api_project/screens/widgets/repo_item_widget.dart';
import 'package:github_api_project/styling/styling.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final cubit = context.read<HomeCubit>();
    return Scaffold(
      body: BlocBuilder<HomeCubit, HomeState>(
        builder: (context, state) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _AppBar(title: "Github repos list", onFavorites: () => cubit.toFavorites()),
              const Divider(
                thickness: 4,
                color: CustomColors.layer,
              ),
              Padding(
                padding: const EdgeInsets.only(top: 24, bottom: 0),
                child: CustomTextField(
                  controller: cubit.textController,
                  onSearch: () => cubit.search(),
                  isFocused: state.isFocused,
                  changeFocus: (bool isFocused) => cubit.changeFocus(isFocused),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 8, left: 24, bottom: 4),
                child: Text(
                  state.isHistory ? "Search History" : "What we have found",
                  style: CustomTextSyles.mainWithPrimaryColor,
                  textAlign: TextAlign.start,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              state.isLoading
                  ? const Expanded(
                      child: Center(
                          child: CircularProgressIndicator(
                      color: CustomColors.accentPrimary,
                    )))
                  : Expanded(
                      child: state.items.isEmpty
                          ? const Center(
                              child: Padding(
                                padding: EdgeInsets.only(left: 16, right: 16, bottom: 80),
                                child: Text(
                                  "You have empty history.\nClick on search to start journey!",
                                  style: CustomTextSyles.placeholder,
                                  maxLines: 2,
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            )
                          : ListView.builder(
                              padding: const EdgeInsets.only(bottom: 16),
                              itemCount: state.items.length,
                              itemBuilder: (context, index) {
                                final item = state.items[index];
                                return RepoItemWidget(
                                    name: item.name,
                                    isFavorite: item.isFavorite,
                                    onFavoriteButton: () => cubit.onFavorite(item));
                              })),
            ],
          );
        },
      ),
    );
  }
}

class _AppBar extends StatelessWidget {
  final String title;
  final VoidCallback onFavorites;

  _AppBar({required this.title, required this.onFavorites});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 16, right: 16, bottom: 12, top: 62),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const SizedBox(
            width: 44,
          ),
          Text(
            title,
            style: CustomTextSyles.main,
          ),
          GestureDetector(
            onTap: onFavorites,
            child: Container(
                width: 44,
                height: 44,
                decoration: const BoxDecoration(
                    color: CustomColors.accentPrimary,
                    borderRadius: BorderRadius.all(Radius.circular(12))),
                child: SvgPicture.asset(
                  'assets/ic_filled_star.svg',
                  fit: BoxFit.none,
                )),
          )
        ],
      ),
    );
  }
}
