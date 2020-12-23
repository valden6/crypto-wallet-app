import 'package:crypto_wallet_app/net/flutterfire.dart';
import 'package:flutter/material.dart';

class AddScreen extends StatefulWidget {
  @override
  _AddScreenState createState() => _AddScreenState();
}

class _AddScreenState extends State<AddScreen> {

  List<String> coins = [
    "Bitcoin",
    "Tether",
    "Ethereum",
  ];
  String dropdownValue = "Bitcoin";
  TextEditingController _amountController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false ,
        backgroundColor: Colors.yellow,
        title: Text("Add a crypto", style: TextStyle(color: Colors.black, fontSize: 26, fontWeight: FontWeight.bold))
      ),
      body: Container(
        color: Colors.yellow,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),              child: Container(
                width: MediaQuery.of(context).size.width,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: DropdownButton(
                    style: TextStyle(color: Colors.black, fontSize: 18, fontWeight: FontWeight.bold),
                    dropdownColor: Colors.yellow,
                    value: dropdownValue, 
                    onChanged: (value) {
                      setState(() {
                        dropdownValue = value;
                      });
                    },
                    items: coins.map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList()
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              child: TextFormField(
                controller: _amountController,
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
                  labelText: "Amount",
                  labelStyle: TextStyle(color: Colors.black, fontSize: 15, fontWeight: FontWeight.bold)
                )
              ),
            ),
            Container(
              decoration: BoxDecoration(
                color: Colors.green,
                borderRadius: BorderRadius.circular(15)
              ),
            )
          ]
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await addCoin(dropdownValue, _amountController.text);
          Navigator.of(context).pop();
        },
        backgroundColor: Colors.black,
        focusColor: Colors.red,
        child: Text("Add", style: TextStyle(color: Colors.white, fontSize: 18)),
      )
    );
  }
}