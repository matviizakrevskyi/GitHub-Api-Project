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
              _AppBar(title: "Github repos list", onFavorites: () => cubit.onFavorite()),
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
              const Padding(
                padding: EdgeInsets.only(top: 4, left: 16, bottom: 4),
                child: Text(
                  "Search History",
                  style: CustomTextSyles.mainWithPrimaryColor,
                  textAlign: TextAlign.start,
                ),
              ),
              Expanded(
                child: state.currentItems.isNotEmpty
                    ? ListView.builder(itemCount: state.currentItems.length ,itemBuilder: (context, index) {
                        final item = state.currentItems[index];
                        return RepoItemWidget(
                            name: item.name,
                            isFavorite: item.isFavorite,
                            onFavoriteButton: () => cubit.makeFavorite(item));
                      })
                    : Container(),
              )
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
