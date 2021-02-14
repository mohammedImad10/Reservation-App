import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:stationj_project/models/AppUser.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:stationj_project/services/auth.dart';

class Feeds extends StatefulWidget {
  Feeds({Key key}) : super(key: key);

  @override
  _FeedsState createState() => _FeedsState();
}

class _FeedsState extends State<Feeds> {

  List<TimeRegion> regions = <TimeRegion>[];
  TimeRegion time = new TimeRegion();
   bool clicked = false;
  int i = null;
  bool loaded = false;
  List<bool> clickedArr;
  final GlobalKey<ScaffoldState> _globalKey = new GlobalKey<ScaffoldState>();
     final  AuthService _auth = AuthService();

  @override
  Widget build(BuildContext context) {
        
           return Scaffold(
           appBar: AppBar(
        title:Text('Feeds'),
        backgroundColor: Colors.blue[400],
        elevation: 0.0,
        actions: <Widget>[
          
        ],
      ),
    body:
    Center(
          child: Container(
            child: 
            StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance.collection('feeds').snapshots(),
              builder: (context, snapshot){
                        if(snapshot.hasError){
                          print("---");
                          print(snapshot.error);
                          return Text("Something went rong");
                        }
                        if(snapshot.connectionState == ConnectionState.waiting){
                          return CircularProgressIndicator();
                        }
                        if(!loaded && snapshot.data.docs.length >0)
                               clickedArr = List.filled(snapshot.data.docs.length, false);
                        return ListView.builder(
                          itemCount: snapshot.data.docs.length,
                              itemBuilder:(BuildContext context, int index){
                                  QueryDocumentSnapshot q = snapshot.data.docs[index];
                                  return 
                                  Card(
                                    child: ListTile(
                                      leading: Text(q.data()['name'].toString(),style: TextStyle(color: Colors.blueGrey[500]),),
                                      title: Text(q.data()['description'].toString()),
                                      // isThreeLine: true,
                                      
                                    ),
                                  );
                              },

                           );
              },
            ),
          ),
    ),
    );
    
  }

  
}