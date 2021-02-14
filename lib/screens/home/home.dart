
import 'package:fluid_bottom_nav_bar/fluid_bottom_nav_bar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:stationj_project/models/AppUser.dart';
import 'package:stationj_project/screens/home/events.dart';
import 'package:stationj_project/screens/home/resetvation.dart';
import 'package:stationj_project/screens/home/profile.dart';
import 'package:stationj_project/screens/home/feeds.dart';
import 'package:stationj_project/services/auth.dart';




class Home extends StatefulWidget {
  @override
  State createState() {
    return HomeState();
  }
}

class HomeState extends State {
  Widget _child;

  @override
  void initState() {
    _child = Reservation();
    super.initState();
  }
   final  AuthService _auth = AuthService();

  @override
  Widget build(context) {
        final user = Provider.of<AppUser>(context);
        print("--");
        print(user);
    // Build a simple container that switches content based of off the selected navigation item
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.grey,        
      //   appBar:_child == Reservation() ? null: AppBar(
      //   title:Text('Home Page'),
      //   backgroundColor: Colors.blue[400],
      //   elevation: 0.0,
      //   actions: <Widget>[
      //     FlatButton.icon(
      //       icon: Icon(Icons.person), 
      //       onPressed: () async {
      //         await _auth.signout();
      //       },
      //        label: Text('logout'),
      //       )
      //   ],
      // ), 
        extendBody: true,
        body: _child,
        bottomNavigationBar: FluidNavBar(
          icons: [
            FluidNavBarIcon(
                icon: Icons.person,
                backgroundColor: Color(0xFF4285F4),
                extras: {"label": "profile"}),
            FluidNavBarIcon(
                icon: Icons.bookmark_border,
                backgroundColor: Color(0xFFEC4134),
                extras: {"label": "reservation"}),
            FluidNavBarIcon(
                icon: Icons.apps,
                backgroundColor: Color(0xFFFCBA02),
                extras: {"label": "events"}),
            FluidNavBarIcon(
                 icon: Icons.new_releases,
                backgroundColor: Color(0xFF34A950),
                extras: {"label": "feeds"}),
          ],
          onChange: _handleNavigationChange,
          style: FluidNavBarStyle(iconUnselectedForegroundColor: Colors.white,
          barBackgroundColor: Colors.cyan),
          scaleFactor: 1.5,
          defaultIndex: 1,
          itemBuilder: (icon, item) => Semantics(
            label: icon.extras["label"],
            child: item,
          ),
        ),
      ),
    );
  }

  void _handleNavigationChange(int index) {
    setState(() {
      switch (index) {
        case 0:
          _child = Profile();
          break;
        case 1:
          _child = Reservation();
          break;
        case 2:
          _child = Events();
          break;
          case 3:
          _child = Feeds();
          break;
      }
      _child = AnimatedSwitcher(
        switchInCurve: Curves.easeOut,
        switchOutCurve: Curves.easeIn,
        duration: Duration(milliseconds: 200),
        child: _child,
      );
    });
  }
}