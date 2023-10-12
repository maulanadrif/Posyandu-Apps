import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:posyandu_apps/config/constant/app_constant.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  int currentPageIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: NavigationBar(
        onDestinationSelected: (int index) {
          setState(() {
            currentPageIndex = index;
          });
        },
        selectedIndex: currentPageIndex,
        destinations: AppConstant.navbar.map((e) {
          return NavigationDestination(
            icon: Icon(e['iconOff']),
            selectedIcon: Icon(e['iconOn']),
            label: e['title'],
          );
        }).toList(),
      ),
      body: AppConstant.navbar[currentPageIndex]['page'],
    );
  }
}
