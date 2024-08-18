import 'package:app1/home/cubit/home_cubit.dart';
import 'package:app1/profile/profile.dart';

import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_snake_navigationbar/flutter_snake_navigationbar.dart';

class HomeView extends StatelessWidget {
  HomeView({super.key});

  final screen = [
    ProfilePage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BlocBuilder<HomeCubit, HomeState>(
        builder: (context, state) => SnakeNavigationBar.color(
          snakeViewColor: Color(0xFFFF693A),
          unselectedItemColor: Color(0xFFFFFFFF),
          currentIndex: context.read<HomeCubit>().state.page,
          onTap: (value) {
            context.read<HomeCubit>().pageChanged(value);
          },
          backgroundColor: Color(0xFF262626),
          items: [
            BottomNavigationBarItem(
              icon: Icon(
                Icons.home_rounded,
              ),
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.history_rounded,
              ),
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.chat_rounded,
              ),
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.account_circle_rounded,
              ),
            ),
          ],
        ),
      ),
      body: BlocBuilder<HomeCubit, HomeState>(
        builder: (context, state) => screen[state.page],
      ),
    );
  }
}
