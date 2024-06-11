import 'package:flutter/material.dart';
import 'package:flutter_rpg/screens/home_screen/home.dart';
import 'package:flutter_rpg/screens/settings_screen/settings_screen.dart';

class NavigationBarBottom extends StatefulWidget {
  const NavigationBarBottom({super.key});

  @override
  State<NavigationBarBottom> createState() => _NavigationBarBottomState();
}

class _NavigationBarBottomState extends State<NavigationBarBottom> {
  int currentPageIndex = 0;

  @override
  Widget build(BuildContext context) {
    return NavigationBar(
      onDestinationSelected: (int index) {
        setState(() {
          currentPageIndex = index;
          if (index == 0) {
            Navigator.push(
                context, MaterialPageRoute(builder: (ctx) => const Home()));
          }
          if (index == 1) {}
          if (index == 2) {
            Navigator.push(context,
                MaterialPageRoute(builder: (ctx) => const SettingsScreen()));
          }
        });
      },
      indicatorColor: Colors.amber,
      selectedIndex: currentPageIndex,
      destinations: const <Widget>[
        NavigationDestination(
          selectedIcon: Icon(Icons.home),
          icon: Icon(Icons.home_outlined),
          label: 'Home',
        ),
        NavigationDestination(
          icon: Icon(Icons.map),
          label: 'Maps',
        ),
        NavigationDestination(
          icon: Badge(
            label: Text('2'),
            child: Icon(Icons.settings),
          ),
          label: 'Settings',
        ),
      ],
    );
  }
}
