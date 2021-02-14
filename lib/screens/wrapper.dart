import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:stationj_project/models/AppUser.dart';
import 'package:stationj_project/screens/authenticate/authenticate.dart';

import 'home/home.dart';

class Wrapper extends StatelessWidget {
  const Wrapper({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    final user = Provider.of<AppUser>(context);
    print(user);
    if(user == null){
      return Authenticate();
    } else {  
      
      return Home();
    }

  }
}