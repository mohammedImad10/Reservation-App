import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:stationj_project/widgets/eventCard.dart';
class Events extends StatefulWidget {
  Events({Key key}) : super(key: key);

  @override
  _EventsState createState() => _EventsState();
}

class _EventsState extends State<Events> {
  bool clicked = false;
  int i = null;
  bool loaded = false;
  List<bool> clickedArr;
  final GlobalKey<ScaffoldState> _globalKey = new GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
     return Scaffold(
         backgroundColor: Colors.grey,        
        appBar:AppBar(
        title:Text('Events'),
        backgroundColor: Colors.blue[400],
        elevation: 0.0,
        actions: <Widget>[
          
        ],
      ), 
      body:
       
                   Column(
                     children: [
                      //  Container(height:MediaQuery. of(context). size.height*0.2,width: MediaQuery. of(context). size.width,child: Image.asset("images/stationJ.jpg",width: double.maxFinite,)),
                       Padding(
                         padding: const EdgeInsets.all(8.0),
                         child: Center(
                            child: Container(
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
                                                    // Card(
                                                    //   child: ListTile(
                                                    //     title: Text(q.data()['name'].toString()),
                                                    //     subtitle: Text("asd"),
                                                    //     isThreeLine: true,
                                                    //     trailing: Text(""+q.data()['price'].toString()),
                                                        
                                                    //   ),
                                                    // );
                                                    PopularEventTile(
                                              desc: q.data()['name'].toString(),
                                              imgeAssetPath:q.data()['image'].toString(),
                                              date: q.data()['Time'].toString(),
                                              address: q.data()['address'].toString(),
                                            );
                                                },

                                             );
                                },
                              ),
                            ),
    
             ),
                       ),
                     ],
                   ),
           
      //  Container(
      //   child: Stack(
      //     children: <Widget>[
      //       Container(
      //         decoration: BoxDecoration(
      //          color: Color(0xff102733)
      //         ),
      //       ),
      //       SingleChildScrollView(
      //         child: Container(
      //           padding: EdgeInsets.symmetric(vertical: 60,horizontal: 30),
      //           child: Column(
      //             crossAxisAlignment: CrossAxisAlignment.start,
      //             children: <Widget>[
                 
      //               Container(
      //                 child: ListView.builder(
      //                   itemCount: 2,
      //                     shrinkWrap: true,
      //                     itemBuilder: (context, index){
      //                     return 
      //                     EventCard();
      //                     // PopularEventTile(
      //                     //   desc: "Title",
      //                     //   imgeAssetPath:"images/flutter-react.jpg",
      //                     //   date: "14 SUN",
      //                     //   address: "ONline",
      //                     // );

      //                     }),
      //               )
      //             ],
      //           ),
      //         ),
      //       ),

      //     ],
      //   ),
      // ),
    );
    // return Container(
    //    child: Text("events"),
    // );
  }
}
class EventTile extends StatelessWidget {

  String imgAssetPath;
  String eventType;
  EventTile({this.imgAssetPath, this.eventType});

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      padding: EdgeInsets.symmetric(horizontal: 30),
      margin: EdgeInsets.only(right: 16),
      decoration: BoxDecoration(
        color: Color(0xff29404E),
        borderRadius: BorderRadius.circular(12)
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Image.asset(imgAssetPath, height: 27,),
          SizedBox(height: 12,),
          Text(eventType, style: TextStyle(
            color: Colors.white
          ),)
        ],
      ),
    );
  }
}
class DateTile extends StatelessWidget {

  String weekDay;
  String date;
  bool isSelected;
  DateTile({this.weekDay, this.date, this.isSelected});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(right: 10),
      padding: EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(
        color: isSelected ? Color(0xffFCCD00) : Colors.transparent,
        borderRadius: BorderRadius.circular(10)
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(date, style: TextStyle(
            color: isSelected ? Colors.black : Colors.white,
            fontWeight: FontWeight.w600
          ),),
          SizedBox(height: 10,),
          Text(weekDay, style: TextStyle(
              color: isSelected ? Colors.black : Colors.white,
              fontWeight: FontWeight.w600
          ),)
        ],
      ),
    );
  }
}
class PopularEventTile extends StatelessWidget {

  String desc;
  String date;
  String address;
  String imgeAssetPath;/// later can be changed with imgUrl
  PopularEventTile({this.address,this.date,this.imgeAssetPath,this.desc});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      margin: EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: (Colors.blue[800]),
        borderRadius: BorderRadius.circular(8)
      ),
      child: Row(
        children: <Widget>[
          Expanded(
            child: Container(
              padding: EdgeInsets.only(left: 16),
              width: MediaQuery.of(context).size.width - 100,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(desc, style: TextStyle(
                      color: Colors.white,
                    fontSize: 18
                  ),),
                  SizedBox(height: 8,),
                  Row(
                    children: <Widget>[
                      // Image.asset("images/flutter-react.jpg", height: 12,),
                      // SizedBox(width: 8,),
                      Icon(Icons.calendar_today, color: Colors.white,),
                      Text(date, style: TextStyle(
                          color: Colors.white,
                          fontSize: 10
                      ),)
                    ],
                  ),
                  SizedBox(height: 4,),
                  Row(
                    children: <Widget>[
                      // Image.asset(imgeAssetPath, height: 12,),
                      // SizedBox(width: 8,),
                      Icon(Icons.location_on,color: Colors.white,),
                      Text(address, style: TextStyle(
                        color: Colors.white,
                        fontSize: 10
                      ),)
                    ],
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ClipRRect(
                borderRadius: BorderRadius.only(topRight: Radius.circular(8), bottomRight: Radius.circular(8)),
                child: Image.asset(imgeAssetPath, height: 100,width: 120, fit: BoxFit.cover,)),
          ),
        ],
      ),
    );
  }
}