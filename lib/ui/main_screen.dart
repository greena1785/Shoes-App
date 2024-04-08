import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';

import 'package:provider/provider.dart';
import 'package:shoes_app/controllers/mainscreen_provider.dart';
import 'package:shoes_app/shared/botton_nav.dart';
import 'package:shoes_app/ui/cartpage.dart';
import 'package:shoes_app/ui/favorites.dart';
import 'package:shoes_app/ui/homepage.dart';
import 'package:shoes_app/ui/profile/profile.dart';
import 'package:shoes_app/ui/serach.dart';

class MainScreen extends StatelessWidget {
  final String userId;
  final List<Widget> pageList;

  MainScreen({Key? key, required this.userId})
      : pageList = [
    const HomePage(),
    const SearchPage(),
    FavoritePage(),
    CartPage(),
    ProfilePage(userId: userId),
  ];

  @override
  Widget build(BuildContext context) {
    return Consumer<MainScreenNotifier>(
      builder: (context, mainScreenNotifier, child) {
        return Scaffold(
          backgroundColor: const Color(0xFFE2E2E2),

          body: pageList[mainScreenNotifier!.pageIndex],
          bottomNavigationBar: const BottomNavBar(),
        );
      },
    );
  }
}
