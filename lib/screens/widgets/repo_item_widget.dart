import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:github_api_project/styling/styling.dart';

class RepoItemWidget extends StatelessWidget {
  final String name;
  final bool isFavorite;
  final VoidCallback onFavoriteButton;

  RepoItemWidget({required this.name, required this.isFavorite, required this.onFavoriteButton});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 16, right: 16, top: 4, bottom: 4),
      child: Container(
        height: 55,
        decoration: const BoxDecoration(
          color: CustomColors.layer,
          borderRadius: BorderRadius.all(
            Radius.circular(10),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                width: 200,
                child: Text(
                  name,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                  style: CustomTextSyles.body,
                ),
              ),
              IconButton(
                onPressed: onFavoriteButton,
                icon: SvgPicture.asset(
                  isFavorite ? 'assets/ic_filled_star.svg' : 'assets/ic_star.svg',
                  color: CustomColors.accentPrimary,
                  width: 24,
                  height: 24,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
