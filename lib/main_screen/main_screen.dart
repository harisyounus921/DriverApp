import 'package:drive_app/tabPages/earningtab.dart';
import 'package:drive_app/tabPages/homePage.dart';
import 'package:drive_app/tabPages/profiletab.dart';
import 'package:drive_app/tabPages/ratingTab.dart';
import 'package:flutter/material.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);
  @override
  _MainScreenState createState() => _MainScreenState();
}
class _MainScreenState extends State<MainScreen> with SingleTickerProviderStateMixin{

  final List<Widget>_screens=const[
    HomeTabPage(),
    EarningTabPage(),
    RateingTabPage(),
    ProfileTabPage(),
  ];

  final Map <String,IconData> _icons=const{
    'Home':Icons.home,
    'Earning':Icons.credit_card,
    'Rateing':Icons.star,
    'Profile':Icons.person,
  };

  int _currentIndex=0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_currentIndex],
      bottomNavigationBar:BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.black ,

        items:_icons.map((title, icon) => MapEntry(
          title, BottomNavigationBarItem(
          icon: Icon(icon,size: 30,),
          label:title,
        ),
        ),
        ).values.toList(),

        currentIndex: _currentIndex,
        selectedFontSize: 11.0,
        unselectedFontSize: 11.0,
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.white54,
        selectedLabelStyle: const TextStyle(fontSize: 14),
        //showSelectedLabels: true,

        onTap: (index)=>setState(() {
          _currentIndex=index;
        }),
      ),
    );
  }
}
