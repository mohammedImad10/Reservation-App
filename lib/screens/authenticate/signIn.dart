import 'package:flutter/material.dart';
import 'package:stationj_project/services/auth.dart';
import 'package:stationj_project/shared/loading.dart';
class SignIn extends StatefulWidget {
  final Function toggleView;
  SignIn({this.toggleView});

  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final AuthService _authService = AuthService();
  final _formKey = GlobalKey<FormState>();
 
  String email='';
  String password='' ;
  String password2='' ;
  String error = '' ;
  bool _obscureText = true;
  bool _validate = false;
  bool loading =false;
  @override
  Widget build(BuildContext context) {
    
     return loading?Loading(): Scaffold(
      backgroundColor: Colors.yellow[12],
      appBar: AppBar(
        backgroundColor: Colors.blue[400],
        elevation: 0.0,
        title: Text("Sign In"),
        actions: <Widget>[
          FlatButton.icon(
            onPressed: (){
              widget.toggleView();
            },
            icon:Icon(Icons.person),
            label: Text('Sign Up'))
        ],
      ),
      body:
      //  Container(
      //   padding: EdgeInsets.symmetric(vertical: 20,horizontal: 50),
      //   child:
         Form(
          key: _formKey,
          child: 
          SingleChildScrollView(
      child: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              width: double.infinity,
              height: 300,
              child: Stack(
                children: [
                  Expanded(child: Image.asset("images/stationJ.jpg",width: double.maxFinite,)),
                  // Image.network(
                  //     "https://miro.medium.com/max/1000/1*ilC2Aqp5sZd1wi0CopD1Hw.png"),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsets.all(10),
                      //   child: Container(
                      //     width: 100,
                      //     child:
                      //                       Image.asset("images/stationJ.jpg"),

                      // //     Image.network(
                      // // "https://miro.medium.com/max/1000/1*ilC2Aqp5sZd1wi0CopD1Hw.png"),
                      //   ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(20),
                        child: Text(
                          '',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 30,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(40),
                        child: Text(
                          ' ',
                          style: TextStyle(color: Colors.black, fontSize: 20),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      )
                    ],
                  )
                ],
              ),
            ),
            Container(
              child: Column(
                children: [
                  Container(
                    height: 70,
                    width: double.infinity,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(width: 50),
                        Expanded(
                              
                          child: TextFormField(
                            validator: (val) =>validatEmile(val),
                            
                                         // val.isEmpty? "Enter an Email":null ,
                                         onChanged: (val){
                                              setState(() => 
                                              {
                                              email = val
                                              });
                                              },
                            decoration: InputDecoration(
                               errorText: _validate ? 'Enter a valid Email' : null,
                              labelText: "E-mail",
                              border: OutlineInputBorder(),
                              suffixIcon: Icon(Icons.person),
                            ),
                          ),
                        ),
                        Opacity(
                          opacity: 0,
                          child: Container(
                            width: 50,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Container(
                    height: 70,
                    width: double.infinity,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(width: 50),
                        Expanded(                     
                          child: TextFormField(
                            
                            obscureText: _obscureText,
                            validator: (val) => val.length < 6 ? "Enter a password of 6+ length":null ,
                onChanged: (val){
                  setState(() => {
                    password = val
                  });
                },
                            decoration: InputDecoration(
                                labelText: "Password",
                                hintText: 'Type at least 6 complex chars ',
                                //  helperText: 'passwrod must be 6 chars',
                                // errorText:
                                //     _validate ? 'Value Can\'t Be Empty' : null,
                                border: OutlineInputBorder(),
                                prefixIcon: Icon(Icons.lock),
                                suffixIcon: IconButton(
                                  icon: Icon(_obscureText
                                      ? Icons.visibility_off
                                      : Icons.visibility),
                                  onPressed: () {
                                    setState(() {
                                      _obscureText = !_obscureText;
                                    });
                                  },
                                )),
                          ),
                        ),
                        Opacity(
                          opacity: 0,
                          child: Container(
                            width: 50,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  
                  SizedBox(
                    height: 5,
                  ),
                  GestureDetector(
                             onTap: () async {
                if (_formKey.currentState.validate()){
                  setState(() {
                    loading = true;
                  });
                  print("***++> "+ email);
                    dynamic result = await _authService.signInWithEmail(email.toString().trim(), password.toString().trim()); 
                    if(result == null){
                      setState(() {
                        error = 'could not sign in with those credentioals';
                        loading = false;
                        print(error); 
                        _validate=true;

                      });
                    }
                }
                  

                },
                 
                   
                    child: Container(
                      width: 300,
                      height: 50,
                      decoration: BoxDecoration(
                          color: Colors.cyan,
                          border:
                              Border.all(color: Colors.orangeAccent, width: 2),
                          borderRadius: BorderRadius.all(Radius.circular(10))),
                      child: Center(
                        child: Text(
                          'SIGN IN',
                          style: TextStyle(
                              color: Colors.white, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Container(
                    height: 70,
                    width: double.infinity,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text('Don’t have an account? '),
                        GestureDetector(
                
                              onTap:(){
                                widget.toggleView();
                              },
                              child: Text('SIGN UP',
                              style: TextStyle(
                                  color: Colors.cyan,
                                  fontWeight: FontWeight.bold)),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    )
        
        ),
    );
  }
 
  String validatEmile(val){
    if(val.isEmpty)
        return "Enter an Email";
    else{
      if(!validmail())
        return " You have to enter a valide email!";
      else
      return null;
    }
  }
   bool validmail() {
    var email1 = email.trim();
    bool emailValid = RegExp(
            r"[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'*+/=?^_`{|}~-]+)*@(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?")
        .hasMatch(email1);
    return emailValid;
  }
}
