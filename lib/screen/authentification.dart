import 'package:crypto_wallet/net/flutterfire.dart';
import 'package:crypto_wallet/screen/homescreen.dart';
import 'package:flutter/material.dart';

class Authentification extends StatefulWidget {
  @override
  _AuthentificationState createState() => _AuthentificationState();
}

class _AuthentificationState extends State<Authentification> {

  TextEditingController _emailField = TextEditingController();
  TextEditingController _passwordField = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.yellow,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40),
              child: TextFormField(
                controller: _emailField,
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                cursorColor: Colors.black,
                decoration: InputDecoration(
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.black,
                      width: 2
                    )
                  ),
                  border: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.black,
                      width: 2
                    ),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  labelText: "Email",
                  labelStyle: TextStyle(color: Colors.black, fontSize: 15, fontWeight: FontWeight.bold),
                  hintText: "something@mail.com"
                )
              )
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 40),
              child: TextFormField(
                controller: _passwordField,
                obscureText: true,
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                cursorColor: Colors.black,
                decoration: InputDecoration(
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.black,
                      width: 2
                    )
                  ),
                  border: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.black,
                      width: 2
                    ),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  labelText: "Password",
                  labelStyle: TextStyle(color: Colors.black, fontSize: 15, fontWeight: FontWeight.bold),
                  hintText: "**********"
                )
              )
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 40),
              child: Container(
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  color: Colors.black,
                  borderRadius: BorderRadius.circular(15)
                ),
                child: FlatButton(
                  onPressed: () async {
                    bool shouldNavigate = await register(_emailField.text, _passwordField.text);
                    if(shouldNavigate){
                      Navigator.push(context, MaterialPageRoute(builder: (context) => HomeScreen()));
                    }
                  }, 
                  child: Text("Register", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 18))
                )
              )
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40),
              child: Container(
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  color: Colors.black,
                  borderRadius: BorderRadius.circular(15)
                ),
                child: FlatButton(
                  onPressed: () async {
                    bool shouldNavigate = await signIn(_emailField.text, _passwordField.text);
                    if(shouldNavigate){
                      Navigator.push(context, MaterialPageRoute(builder: (context) => HomeScreen()));
                    }
                  }, 
                  child: Text("Login", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 18))
                )
              )
            )
          ]
        )
      )
    );
  }
}