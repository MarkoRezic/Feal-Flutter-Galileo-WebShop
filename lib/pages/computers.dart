import 'package:flutter/material.dart';

class Computers extends StatefulWidget {
  @override
  _ComputersState createState() => _ComputersState();
}

class _ComputersState extends State<Computers> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        elevation: 0.1,
        backgroundColor: Colors.blueGrey,
        title: Text('Computers',style: new TextStyle(color: Colors.white),),
        actions:<Widget> [
          new IconButton(icon: Icon(Icons.search,color: Colors.white,), onPressed:(){})
        ],
      ),
    );
  }
}
