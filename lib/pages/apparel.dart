import 'package:flutter/material.dart';

class Apparel extends StatefulWidget {
  @override
  _ApparelState createState() => _ApparelState();
}

class _ApparelState extends State<Apparel> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        elevation: 0.1,
        backgroundColor: Colors.blueGrey,
        title: Text('Apparel',style: new TextStyle(color: Colors.white),),
        actions:<Widget> [
          new IconButton(icon: Icon(Icons.search,color: Colors.white,), onPressed:(){})
        ],
      ),
    );
  }
}
