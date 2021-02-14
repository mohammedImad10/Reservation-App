import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
class Loading extends StatelessWidget {
  const Loading({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.yellow[100],
      child: Center(
        child: SpinKitChasingDots(
          color: Colors.yellowAccent,
          size: 50.0,
        ),
      ),
    );
  }
}