// import 'package:flutter/material.dart';
// import 'package:stationj_project/services/auth.dart';

// class Register extends StatefulWidget {
//   final Function toggleView;
//   Register({this.toggleView});

//   @override
//   _RegisterState createState() => _RegisterState();
// }

// class _RegisterState extends State<Register> {
//   final AuthService _authService = AuthService();
//   final _formKey = GlobalKey<FormState>();
//   String email='';
//   String password='' ;
//   String error = '' ;
//   @override
//   Widget build(BuildContext context) {
    
//      return Scaffold(
//       backgroundColor: Colors.brown[100],
//       appBar: AppBar(
//         backgroundColor: Colors.brown[400],
//         elevation: 0.0,
//         title: Text("Sign Up"),
//         actions: <Widget>[
//           FlatButton.icon(
//             onPressed: (){
//               widget.toggleView();
//             },
//             icon:Icon(Icons.person),
//             label: Text('Sign In'))
//         ],
//       ),
//       body: Container(
//         padding: EdgeInsets.symmetric(vertical: 20,horizontal: 50),
//         child: Form(
//           key: _formKey,
//           child: Column(
//             children:<Widget> [
//               SizedBox(
//                 height: 20,
//               ),
//               TextFormField(
//                 validator: (val) => val.isEmpty? "Enter an Email":null ,
//                 onChanged: (val){
//                   setState(() => {
//                     email = val
//                   });
//                 },
//               ),
//               SizedBox(
//                 height: 20,
//               ),
//               TextFormField(
//                 obscureText: true,
//                 validator: (val) => val.length < 6 ? "Enter a password of 6+ length":null ,
//                 onChanged: (val){
//                   setState(() => {
//                     password = val
//                   });
//                 },
//               ),
//               SizedBox(
//                 height: 20,
//               ),
//               RaisedButton(
//                 color: Colors.pink[400],
//                 child: Text(
//                   'Sign Up',
//                   style:TextStyle(color: Colors.white) ,
//                 ),
//                 onPressed: () async {
//                 if (_formKey.currentState.validate()){
//                   print("***++> "+ email);
//                     dynamic result = await _authService.registerWithEmail(email.trim(), password.trim());  
//                     if(result == null){
//                       setState(() {
//                         error = 'please supply a valid email';
//                         print(error);

//                       });
//                     }
//                 }
                  

//                 },
//               ),

//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }