import 'package:flutter/material.dart';
import 'package:stationj_project/screens/authenticate/signIn.dart';
import 'package:stationj_project/screens/authenticate/registeration.dart';

class Authenticate extends StatefulWidget {
  @override
  _AuthenticateState createState() => _AuthenticateState();
}

class _AuthenticateState extends State<Authenticate> {
  bool showSignIn = true;
  void toggleView(){
    setState(() {
      showSignIn = !showSignIn;
    });
  }

  @override
  Widget build(BuildContext context) {
    if(showSignIn){
      return SignIn(
        toggleView:toggleView
    );
    }else{
      return Register( 
        toggleView:toggleView
    );
    }
    
  }
}