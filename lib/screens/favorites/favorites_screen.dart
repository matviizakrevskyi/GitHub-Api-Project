import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:github_api_project/screens/favorites/favorites_cubit.dart';
import 'package:github_api_project/screens/favorites/favorites_state.dart';
import 'package:github_api_project/styling/styling.dart';

class FavoritesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final cubit = context.read<FavoritesCubit>();
    return BlocBuilder<FavoritesCubit, FavoritesState>(
      builder: (context, state) {
        return Scaffold(
          body: Column(
            children: [
              _AppBar(
                title: "Favorite repos list",
                onBack: () => cubit.back(),
              ),
              const Divider(
                thickness: 4,
                color: CustomColors.layer,
              ),
              state.items.isEmpty
                  ? const Expanded(
                      child: Center(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          child: Text(
                            "You have no favorites.\nClick on star while searching to add first favorite",
                            style: CustomTextSyles.placeholder,
                            maxLines: 2,
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                    )
                  : Container(),
              const SizedBox(
                height: 55,
              )
            ],
          ),
        );
      },
    );
  }
}

class _AppBar extends StatelessWidget {
  final String title;
  final VoidCallback onBack;

  _AppBar({required this.title, required this.onBack});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 16, right: 16, bottom: 12, top: 62),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          GestureDetector(
            onTap: onBack,
            child: Container(
                width: 44,
                height: 44,
                decoration: const BoxDecoration(
                    color: CustomColors.accentPrimary,
                    borderRadius: BorderRadius.all(Radius.circular(12))),
                child: SvgPicture.asset(
                  'assets/ic_back.svg',
                  fit: BoxFit.none,
                  color: CustomColors.main,
                )),
          ),
          Text(
            title,
            style: CustomTextSyles.main,
          ),
          const SizedBox(
            width: 44,
          ),
        ],
      ),
    );
  }
}
