
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:stationj_project/models/AppUser.dart';
import 'package:stationj_project/services/auth.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:date_time_picker/date_time_picker.dart';

class Reservation extends StatefulWidget {
  @override
  _ReservationState createState() => _ReservationState();
}
enum RoomType { twenyFive, ten }

class _ReservationState extends State<Reservation> {
   bool clicked = false;

  int i = null;

  bool loaded = false;

  List<bool> clickedArr;
  var usedId;
  var fromTime;var toTime;
  var reservtionDate = DateTime.now().toString();
  final GlobalKey<ScaffoldState> _globalKey = new GlobalKey<ScaffoldState>();

     final  AuthService _auth = AuthService();

  bool _checkbox = true;
  RoomType _character = RoomType.ten;
  List<TimeRegion> regions = <TimeRegion>[];
  List<TimeRegion> regions2 = <TimeRegion>[];

  List<TimeRegion> toAddRegions = <TimeRegion>[];
  List<TimeRegion> toAddRegions2 = <TimeRegion>[];
  CollectionReference stationUsers = FirebaseFirestore.instance.collection('stationUsers');
  CollectionReference deskReservations = FirebaseFirestore.instance.collection('deskReservations');

  @override
  Widget build(BuildContext context) {
        final user = Provider.of<AppUser>(context);
        print("-------------------&&&&&&&&&&&&&&&&&&&");
        print(user.uid);
        var date = new DateTime.utc(2021,2,9,10,30);

    // regions.add(TimeRegion(
    //     startTime: date,
    //     endTime: date.add(Duration(hours: 1)),
    //     enablePointerInteraction: false,
    //     color: Colors.grey.withOpacity(0.9),
    //     text: 'Reserved'));
    return MaterialApp(
      home: DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            bottom: TabBar(
              tabs: [
                // Tab( text: "Desk",),
                Tab( text: "Room",),
                Tab( text: "Desk",),

                // Tab(icon: Icon(Icons.directions_car)),
                // Tab(icon: Icon(Icons.directions_transit)),
                // Tab(icon: Icon(Icons.directions_bike)),
              ],
            ),
            title: Center(child: Text('Reservations')),
          ),
          body: TabBarView(
            children: [
               Column(
      children: <Widget>[
        Container(
          color: Colors.cyan[100],
          child: Row(
            children: [
                  
          Expanded(
                    child: ListTile(
              title: const Text('10 Seats'),
              leading: Radio(
                value: RoomType.ten,
                groupValue: _character,
                onChanged: (RoomType value) {
                  setState(() {
                    _character = value;
                  });
                },
              ),
            ),
          ),
          Expanded(
                    child: ListTile(
              title: const Text('25 Seats'),
              leading: Radio(
                value: RoomType.twenyFive,
                groupValue: _character,
                onChanged: (RoomType value) {
                  setState(() {
                    _character = value;
                  });
                },
              ),
            ),
          ),
            ],
          ),
        ),
        
          Container(
            height: 400,
            child: 
            StreamBuilder<QuerySnapshot>(
              
              stream:_character == RoomType.twenyFive? FirebaseFirestore.instance.collection('stRoom').snapshots():FirebaseFirestore.instance.collection('secondRoom').snapshots(),
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
                        print("***@@@");
                        for (var i = 0; i < snapshot.data.docs.length; i++) {
                          QueryDocumentSnapshot q = snapshot.data.docs[i];
                        
                        var endTime = new  DateTime.utc(q.data()['endYear'],q.data()['endMonth'],q.data()['endDay'],q.data()['endHour'],q.data()['endMinit']);
                        var startTime = new  DateTime.utc(q.data()['startYear'],q.data()['startMonth'],q.data()['startDay'],q.data()['startHour'],q.data()['startMinit']);
                        if(_character == RoomType.twenyFive){
regions.add(TimeRegion(
        startTime: startTime,
        endTime: endTime,
        enablePointerInteraction: false,
        color: Colors.red.withOpacity(0.9),
        text: ''));
                        }else{
                          regions2.add(TimeRegion(
        startTime: startTime,
        endTime: endTime,
        enablePointerInteraction: false,
        color: Colors.red.withOpacity(0.9),
        text: ''));
                        }
        //                 regions.add(TimeRegion(
        // startTime: startTime,
        // endTime: endTime,
        // enablePointerInteraction: false,
        // color: Colors.red.withOpacity(0.9),
        // text: 'Reserved'));
                        }
       
                        return 
                       Container(
     child: Padding(
       padding: const EdgeInsets.all(8.0),
       child: SfCalendar(
         onTap:( details) {
           
              var dates = details;
               print(dates.date);
              // print(regions.length);
              // print(regions[0].startTime);
              TimeRegion timeRegion = new TimeRegion(
                startTime: dates.date,
          endTime: dates.date.add(Duration(minutes: 30)),
          enablePointerInteraction: false,
          color: Colors.grey.withOpacity(0.9),
          text: 'To Reserve'
              );
              if(_character == RoomType.twenyFive){
              toAddRegions.add(timeRegion);
 regions.add(timeRegion);
           }else{
              toAddRegions2.add(timeRegion);
 regions2.add(timeRegion);
           }
          
          setState(() {
            
          });
          },
         
         specialRegions: _character == RoomType.twenyFive?regions:regions2,
         view: CalendarView.workWeek,
         timeSlotViewSettings: TimeSlotViewSettings(
             startHour: 10,
             endHour: 23,
             nonWorkingDays: <int>[
               DateTime.saturday,
              //  DateTime.sunday,
               DateTime.friday
             ],
             timeInterval: Duration(minutes: 30),
             timeIntervalHeight: 80,
             timeFormat: 'h:mm',
             dateFormat: 'd',
             dayFormat: 'EEE',
             timeRulerSize: 70,
             ),
       ),
     ),
   );
              },
            ),
          ),
          SizedBox(
                        height: 10,
                      ),
                      RaisedButton(
                        shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(18.0),
                                side: BorderSide(color: Colors.red)
                                ),
                        child: Text("Register"),
                        color: Colors.cyan,
                        onPressed: (){
                          print( "==========");
                          if(_character == RoomType.twenyFive){
CollectionReference stRoom = FirebaseFirestore.instance.collection('stRoom');
                          for (var i = 0; i < toAddRegions.length; i++) {
                            print(toAddRegions[i].startTime.hour);
                          
                          
                         
  stRoom
    .add({
      'endYear': toAddRegions[i].startTime.year,
      'endMonth': toAddRegions[i].startTime.month,
      'endDay':toAddRegions[i].startTime.day,
      'endHour':toAddRegions[i].startTime.hour,
      'endMinit':toAddRegions[i].startTime.minute,

      'startYear': toAddRegions[i].endTime.year,
      'startMonth': toAddRegions[i].endTime.month,
      'startDay':toAddRegions[i].endTime.day,
      'startHour':toAddRegions[i].endTime.hour,
      'startMinit':toAddRegions[i].endTime.minute,
          "userId": user.uid

    })
    .then((value) => print("Time Added"))
    .catchError((error) => print("Failed to add Time: $error"));
                          }
                          }else{
                            CollectionReference secondRoom = FirebaseFirestore.instance.collection('secondRoom');
                          for (var i = 0; i < toAddRegions2.length; i++) {
                            print(toAddRegions2[i].startTime.hour);
                          
                          
                         
  secondRoom
    .add({
      'endYear': toAddRegions2[i].startTime.year,
      'endMonth': toAddRegions2[i].startTime.month,
      'endDay':toAddRegions2[i].startTime.day,
      'endHour':toAddRegions2[i].startTime.hour,
      'endMinit':toAddRegions2[i].startTime.minute,

      'startYear': toAddRegions2[i].endTime.year,
      'startMonth': toAddRegions2[i].endTime.month,
      'startDay':toAddRegions2[i].endTime.day,
      'startHour':toAddRegions2[i].endTime.hour,
      'startMinit':toAddRegions2[i].endTime.minute,
                "userId": user.uid


    })
    .then((value) => print("Time Added"))
    .catchError((error) => print("Failed to add Time: $error"));
                          }
                          }
                          Fluttertoast.showToast(
        msg: "Your reservation Done successfully",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.grey[600],
        textColor: Colors.white,
        fontSize: 16.0
    );
                          
                        },
                      ),
      
      ],
    ),
              // Text("Desk"),
              // Icon(Icons.directions_car),
              // Icon(Icons.directions_transit),
              Container(
            child: 
   Column(
     children: [
  
 Container(
   width: MediaQuery. of(context). size. width*0.9,
   child: DateTimePicker(
    type: DateTimePickerType.date,
    dateMask: 'd MMM, yyyy',
    initialValue: DateTime.now().toString(),
    firstDate: DateTime(2000),
    lastDate: DateTime(2100),
    icon: Icon(Icons.event),
    dateLabelText: 'Date',
    timeLabelText: "Hour",
    // selectableDayPredicate: (date) {
    //       // Disable weekend days to select from the calendar
    //       if (date.weekday == 6 || date.weekday == 7) {
    //         return false;
    //       }

    //       return true;
    // },
    onChanged: (val) {
      print(val);
      reservtionDate = val;
      },
    validator: (val) {
          print(val);
          return null;
    },
    onSaved: (val) => print(val),
),
 ),
 SizedBox(height: 30,),
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: Row(
            children: [
              Container(
                width: MediaQuery. of(context). size. width*0.4,
                child: DateTimePicker(
                            type: DateTimePickerType.time,
    
                            // initialValue:TimeOfDay.now().toString() ,
    
                            icon: Icon(Icons.access_time),
    
                            timeLabelText: "From Time",
    
                            //use24HourFormat: false,
    
                            //locale: Locale('en', 'US'),
    
                            onChanged: (val) => setState(() {  
                              print(val);
                              fromTime = val;
                            
                            }),
    
                            validator: (val) {
    
                              print(val);
    
                              return null;
    
                            },
    
                            onSaved: (val) => setState(() => print(val)),
    
                          ),
              ),
              Container(
  width: MediaQuery. of(context). size. width*0.4,
  child:   DateTimePicker(
  
      
  
                        type: DateTimePickerType.time,
  
      
  
                        // initialValue:TimeOfDay.now().toString() ,
  
      
  
                        icon: Icon(Icons.access_time),
  
      
  
                        timeLabelText: "To Time",
  
      
  
                        //use24HourFormat: false,
  
      
  
                        //locale: Locale('en', 'US'),
  
      
  
                        onChanged: (val) => setState(() {
                          print(val);
                          toTime = val;
                        }  ),
  
      
  
                        validator: (val) {
  
      
  
                          print(val);
  
      
  
                          return null;
  
      
  
                        },
  
      
  
                        onSaved: (val) => setState(() => print(val)),
  
      
  
                      ),
),
            ],
          ),
        ),
              SizedBox(height: 250),
              RaisedButton(
                shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(18.0),
                                side: BorderSide(color: Colors.red)
                                ),
                        child: Text("Register"),
                        color: Colors.cyan,
                onPressed: (){
                    print("99999-------------------00000000000000000");
                    print(toTime);
                    print(fromTime);
                    print(reservtionDate);
                        deskReservations.add({
          "toTime":toTime,
          "fromTime":fromTime,
          "date":reservtionDate,
          "userId": user.uid
        }).then((value) => print("Desk Added"))
    .catchError((error) => print("Failed to add Time: $error"));;
    Fluttertoast.showToast(
        msg: "Your reservation Done successfully",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.grey[600],
        textColor: Colors.white,
        fontSize: 16.0
    );
                }),
              

     ],
   ),
              ),
              // Icon(Icons.directions_bike),
            ],
          ),
        ),
      ),
    );
  }

  List<TimeRegion> _getTimeRegions(startTime,endTime) {
    print("------------%%%%%");
    var date = new DateTime.utc(2021,2,9,10,30);
    print(startTime);
    final List<TimeRegion> regions1 = <TimeRegion>[];
    regions.add(TimeRegion(
        startTime: startTime,
        endTime: endTime,
        // date.add(Duration(hours: 1)),
        enablePointerInteraction: false,
        color: Colors.grey.withOpacity(0.9),
        text: 'Reserved'));

    return regions;
  }
}