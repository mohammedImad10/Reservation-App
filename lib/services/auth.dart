import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:stationj_project/models/AppUser.dart';

class AuthService{

    final FirebaseAuth _auth = FirebaseAuth.instance;
         CollectionReference stationUsers = FirebaseFirestore.instance.collection('stationUsers');
    Future updateUserData(String id){

    }
    //creqat user object basewd on firebase user

    AppUser _userFromFirebaseuser(User user){
      
          return user != null ? AppUser(uid: user.uid) : null;
    }

    Stream<AppUser> get user {
      return _auth.authStateChanges()
      //.map((FirebaseUser user) => userFromFirebaseuser(user));
      .map(_userFromFirebaseuser);
    }
    Future signInAnon() async {
      try{
        var result = await _auth.signInAnonymously();
        User user = result.user;
        return _userFromFirebaseuser(user);
      }catch(e){
        print(e.toString());
        return null;
      } 
    }

    Future signout() async { 
      try{
        return _auth.signOut();
      }catch(e){
        print(e.toString());
        return null;
      }
    }

    Future registerWithEmail(String email,String password) async{
      try{
        var result = await _auth.createUserWithEmailAndPassword(email: email, password: password);
        User user= result.user;
        AppUser appUser = _userFromFirebaseuser(user);
        await stationUsers.doc(appUser.uid).set(
          {'id':appUser.uid,
          'email':email
          }
        );
    //    await stationUsers.add({
    //       "email":email,
    //       "id":user
    //     }).then((value) => print("Time Added"))
    // .catchError((error) => print("Failed to add Time: $error"));;
        return appUser;
      }catch(e){
        print("---**--"+e.toString());
        return null;
      }
    }

    Future signInWithEmail(String email,String password) async{
      try{
        var result = await _auth.signInWithEmailAndPassword(email: email, password: password);
        User user= result.user;
        print(result);
        print(user);
        return _userFromFirebaseuser(user);
      }catch(e){
        print(e.toString());
        return null;
      }
    }
}