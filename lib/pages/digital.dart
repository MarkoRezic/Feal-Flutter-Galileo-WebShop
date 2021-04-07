import 'package:flutter/material.dart';

class Digital extends StatefulWidget {
  @override
  _DigitalState createState() => _DigitalState();
}

class _DigitalState extends State<Digital> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        elevation: 0.1,
        backgroundColor: Colors.blueGrey,
        title: Text('Digital downloads',style: new TextStyle(color: Colors.white),),
        actions:<Widget> [
          new IconButton(icon: Icon(Icons.search,color: Colors.white,), onPressed:(){})
        ],
      ),
    );
  }
}
