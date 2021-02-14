import 'package:cloud_firestore/cloud_firestore.dart';

class DataBaseService{
  final String uid;

  DataBaseService({this.uid});

  final CollectionReference stationUsers = FirebaseFirestore.instance.collection('stationUsers');

  Future updateUserData(String email,){

  }

}