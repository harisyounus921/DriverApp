import 'package:drive_app/Splash/splash_screen.dart';
import 'package:flutter/material.dart';

import '../Global/GlobalPage.dart';

class ProfileTabPage extends StatefulWidget {
  const ProfileTabPage({Key? key}) : super(key: key);

  @override
  _ProfileTabPageState createState() => _ProfileTabPageState();
}

class _ProfileTabPageState extends State<ProfileTabPage> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: ElevatedButton(
       child: Text('Sign out'),
      onPressed: (){
        fAuth.signOut();
        Navigator.push(context, MaterialPageRoute(builder: (_)=>MySplashScreen()));
      },),
    );
  }
}
