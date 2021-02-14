import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';
import 'package:stationj_project/models/AppUser.dart';
import 'package:stationj_project/services/auth.dart';

class Profile extends StatefulWidget {
  Profile({Key key}) : super(key: key);

  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
   
  bool clicked = false;
  int i = null;
  bool loaded = false;
  List<bool> clickedArr;
  final GlobalKey<ScaffoldState> _globalKey = new GlobalKey<ScaffoldState>();
     final  AuthService _auth = AuthService();
    String point="2";
  @override
  Widget build(BuildContext context) {
            final user = Provider.of<AppUser>(context);
            print("!!!!!!user");
            print(user.email);
  CollectionReference stationUsers = FirebaseFirestore.instance.collection('stationUsers');
  print(stationUsers.doc(user.uid).get());
    return Scaffold(
           appBar: AppBar(
        title:Text('Profile'),
        backgroundColor: Colors.blue[400],
        elevation: 0.0,
        actions: <Widget>[
          FlatButton.icon(
            icon: Icon(Icons.person), 
            onPressed: () async {
              await _auth.signout();
            },
             label: Text('logout'),
            )
        ],
      ),
    body:
          Column(
            children: [
              Card(
                                        child: ListTile(
                                          title: Text("name"),
                                          subtitle: Text("asd"),
                                          isThreeLine: true,
                                          trailing: Column(
                                            children: [
                                              Text("Points: "),
                                              Text(point),
                                            ],
                                          ),
                                          
                                        ),
                                      ),
              Container(
                child: 
                StreamBuilder<QuerySnapshot>(
                  stream: FirebaseFirestore.instance.collection('events').snapshots(),
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
                              shrinkWrap: true,
                              itemCount: snapshot.data.docs.length,
                                  itemBuilder:(BuildContext context, int index){
                                      QueryDocumentSnapshot q = snapshot.data.docs[index];
                                      return 
                                      Card(
                                        child: ListTile(
                                          title: Text(q.data()['name'].toString()),
                                          subtitle: Text("asd"),
                                          isThreeLine: true,
                                          trailing: Text(""+q.data()['price'].toString()),
                                          
                                        ),
                                      );
                                  },

                               );
                  },
                ),
              ),
            ],
          ),
    );
  }
  Future<void> runFirebase() async {
  WidgetsFlutterBinding.ensureInitialized();
    await Firebase.initializeApp();

}
Future getUser(String id){
        
    }
}