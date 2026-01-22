import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';

class MainWrapper extends StatelessWidget {
  final StatefulNavigationShell navigationShell;

  const MainWrapper({super.key, required this.navigationShell});

  void _goToBranch(int index) {
    navigationShell.goBranch(
      index,
      initialLocation: index == navigationShell.currentIndex,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: navigationShell,
      bottomNavigationBar: BottomNavigationBar(

        currentIndex: navigationShell.currentIndex,
        onTap: _goToBranch,
        selectedItemColor: Theme.of(context).colorScheme.primary,
        items: [
          BottomNavigationBarItem(
              icon: SvgPicture.asset(
                'assets/icons/ic_home.svg',
                width: 28,
                colorFilter: const ColorFilter.mode(Colors.grey, BlendMode.srcIn),
              ),
              activeIcon: SvgPicture.asset(
                'assets/icons/ic_home.svg',
                width: 28,
                colorFilter: ColorFilter.mode(Theme.of(context).colorScheme.primary, BlendMode.srcIn),
              ),
              label: 'HOME'
          ),
          BottomNavigationBarItem(
              icon: SvgPicture.asset(
                'assets/icons/ic_book.svg',
                width: 24,
                colorFilter: const ColorFilter.mode(Colors.grey, BlendMode.srcIn),
              ),
              activeIcon: SvgPicture.asset(
                'assets/icons/ic_book.svg',
                width: 24,
                colorFilter: ColorFilter.mode(Theme.of(context).colorScheme.primary, BlendMode.srcIn),
              ),
              label: 'LIBRARY'
          ),
          BottomNavigationBarItem(
              icon: SvgPicture.asset(
                'assets/icons/ic_person.svg',
                width: 24,
                colorFilter: const ColorFilter.mode(Colors.grey, BlendMode.srcIn),
              ),
              activeIcon: SvgPicture.asset(
                'assets/icons/ic_person.svg',
                width: 24,
                colorFilter: ColorFilter.mode(Theme.of(context).colorScheme.primary, BlendMode.srcIn),
              ),
              label: 'PROFILE'
          ),
        ],
      ),
    );
  }
}
