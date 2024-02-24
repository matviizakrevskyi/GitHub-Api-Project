import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:github_api_project/screens/home/home_cubit.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<HomeCubit, HomeState>(
        builder: (context, state) {
          return Column(
            children: [
              _AppBar(
                  title: "Github repos list",
                  onFavorites: () => context.read<HomeCubit>().onFavorite()),
              const Divider(
                height: 4,
                color: Colors.grey,
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
      padding: const EdgeInsets.only(left: 16, right: 16, bottom: 12),
      child: Row(
        children: [
          const SizedBox(
            width: 44,
          ),
          Text(
            title,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: Colors.black),
          ),
          GestureDetector(
            onTap: onFavorites,
            child: Container(
                width: 44,
                height: 44,
                decoration: const BoxDecoration(
                    color: Colors.blue, borderRadius: BorderRadius.all(Radius.circular(6))),
                child: SizedBox(
                    width: 20, height: 20, child: SvgPicture.asset('assets/icons/image.svg'))),
          )
        ],
      ),
    );
  }
}
