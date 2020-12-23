import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:crypto_wallet_app/net/api_methods.dart';
import 'package:crypto_wallet_app/net/flutterfire.dart';
import 'package:crypto_wallet_app/screen/addscreen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  double bitcoin = 0.0;
  double ethereum = 0.0;
  double tether = 0.0;

  @override
  initState() {
    updateValues();
  }

  updateValues() async {
    bitcoin = await getPrice("bitcoin");
    ethereum = await getPrice("ethereum");
    tether = await getPrice("tether");
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {

    getValue(String id, double amount) {
      if (id.toLowerCase() == "bitcoin") {
        return (bitcoin * amount).toStringAsFixed(2);
      } else if (id.toLowerCase() == "ethereum") {
        return (ethereum * amount).toStringAsFixed(2);
      } else {
        return (tether * amount).toStringAsFixed(2);
      }
    }

    return Scaffold(
      backgroundColor: Colors.yellow,
      appBar: AppBar(
        automaticallyImplyLeading: false ,
        backgroundColor: Colors.yellow,
        title: Text("Wallet", style: TextStyle(color: Colors.black, fontSize: 26, fontWeight: FontWeight.bold))
      ),
      body: Center(
        child: StreamBuilder(
          stream: FirebaseFirestore.instance.collection('Users').doc(FirebaseAuth.instance.currentUser.uid).collection('Coins').snapshots(),
          builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if(!snapshot.hasData){
              return Center(child: CircularProgressIndicator());
            } else if(snapshot.data.docs.isEmpty) {
              return Center(child: Text("No crypto", style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)));
            } else {
              return ListView(
                children: snapshot.data.docs.map((document) {
                    return Row(
                      children: [
                        Expanded(
                          flex: 9,
                          child: Padding(
                            padding: const EdgeInsets.only(left: 20, right: 10, top: 15),
                            child: Container(
                              height: 50,
                              decoration: BoxDecoration(
                                color: Colors.black,
                                borderRadius: BorderRadius.circular(10)
                              ),
                              child: Row(
                                children: [
                                  Expanded(child: Padding(
                                    padding: const EdgeInsets.only(left: 10),
                                    child: Container(child: Text(document.id, style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold))),
                                  )),
                                  Padding(padding: EdgeInsets.symmetric(horizontal: 10)),
                                  Expanded(
                                    child: Padding(
                                    padding: const EdgeInsets.only(right: 10),
                                    child: Container(child: Text("${getValue(document.id, document.data()['Amount'])} \$", style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold), textAlign: TextAlign.end,)),
                                  )),
                                ]
                              )
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(right: 15, top: 10),
                          child: Expanded(
                            flex: 1,
                            child: IconButton(
                              icon: Icon(Icons.cancel, color: Colors.red, size: 35), 
                              onPressed: () async {
                                await removeCoin(document.id);
                              }
                            ),
                          ),
                        )
                      ]
                    );
                }).toList()
              );
            }
          },
        )
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.black,
        onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) => AddScreen())),
        child: Icon(Icons.add, color: Colors.yellow, size: 40),
      )
    );
  }
}