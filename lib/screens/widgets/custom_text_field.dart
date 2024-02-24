import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:github_api_project/styling/styling.dart';

class CustomTextField extends StatelessWidget {
  final VoidCallback onSearch;
  final Function(bool) changeFocus;
  final TextEditingController controller;
  final bool isFocused;

  CustomTextField(
      {required this.onSearch,
      required this.controller,
      required this.isFocused,
      required this.changeFocus});

  @override
  Widget build(BuildContext context) {
    return Focus(
      onFocusChange: (hasFocus) {
        changeFocus(hasFocus);
      },
      child: Container(
        height: 56,
        margin: const EdgeInsets.symmetric(horizontal: 16),
        decoration: BoxDecoration(
          color: isFocused ? CustomColors.accentSecondary : CustomColors.layer,
          borderRadius: BorderRadius.circular(28),
          border: isFocused
              ? Border.all(color: CustomColors.accentPrimary, width: 2)
              : Border.all(color: CustomColors.main, width: 2),
        ),
        child: TextField(
          style: CustomTextSyles.body,
          controller: controller,
          decoration: InputDecoration(
            hintText: 'Search',
            hintStyle: CustomTextSyles.placeholder,
            prefixIcon: SizedBox(
              height: 2,
              width: 2,
              child: IconButton(
                onPressed: onSearch,
                icon: SvgPicture.asset(
                  'assets/ic_search.svg',
                  color: CustomColors.accentPrimary,
                  height: 24,
                  width: 24,
                ),
              ),
            ),
            suffixIcon: isFocused
                ? IconButton(
                    onPressed: () {
                      controller.clear();
                    },
                    icon: SvgPicture.asset(
                      'assets/ic_close.svg',
                      color: CustomColors.accentPrimary,
                      height: 24,
                      width: 24,
                    ),
                  )
                : null,
            border: InputBorder.none,
          ),
          onChanged: (value) {},
        ),
      ),
    );
  }
}
