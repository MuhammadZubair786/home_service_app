// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:home_services_app/fragments/account_fragment.dart';
import 'package:home_services_app/fragments/bookings_fragment.dart';
import 'package:home_services_app/fragments/home_fragment.dart';
import 'package:home_services_app/fragments/search_fragment.dart';

class DashBoardScreen extends StatefulWidget {
  const DashBoardScreen({Key? key}) : super(key: key);

  @override
  State<DashBoardScreen> createState() => _DashBoardScreenState();
}

class _DashBoardScreenState extends State<DashBoardScreen> {
  DateTime? _currentBackPressTime;

  final _pageItem = [
    HomeFragment(),
    SearchFragment(),
    BookingsFragment(fromProfile: false),
    AccountFragment(),
  ];
  int _selectedItem = 0;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () {
          DateTime now = DateTime.now();

          if (_currentBackPressTime == null || now.difference(_currentBackPressTime!) > Duration(seconds: 2)) {
            _currentBackPressTime = now;
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('Press back again to exit'),
              ),
            );

            return Future.value(false);
          }
          return Future.value(true);
        },
        child: Scaffold(
          body: _pageItem[_selectedItem],
          bottomNavigationBar: BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            selectedIconTheme: IconThemeData(size: 30, opacity: 1),
            unselectedIconTheme: IconThemeData(size: 28, opacity: 0.5),
            selectedLabelStyle: TextStyle(fontSize: 14),
            unselectedLabelStyle: TextStyle(fontSize: 14),
            showUnselectedLabels: true,
            selectedItemColor: Colors.blue,
            unselectedItemColor: Color.fromARGB(137, 22, 0, 0),
            
            elevation: 40,
            selectedFontSize: 23,
            // ignore: prefer_const_literals_to_create_immutables
            items: [
              BottomNavigationBarItem(
                icon: Icon(Icons.home_outlined, size: 25),
                activeIcon: Icon(Icons.home_rounded, size: 25),
                label: "Home",
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.account_balance_wallet_outlined, size: 25),
                activeIcon: Icon(Icons.account_balance_wallet, size: 25),
                label: "Search",
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.calendar_month_outlined, size: 25),
                activeIcon: Icon(Icons.calendar_month_outlined, size: 25),
                label: "Bookings",
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.person_outline, size: 25),
                activeIcon: Icon(Icons.person, size: 25),
                label: "Account",
              ),
            ],
            currentIndex: _selectedItem,
            onTap: (setValue) {
              _selectedItem = setValue;
              setState(() {});
            },
          ),
        ));
  }
}
