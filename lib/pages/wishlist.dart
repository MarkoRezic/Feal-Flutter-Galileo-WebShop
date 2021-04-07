import 'package:flutter/material.dart';

import 'package:feal_app/components/wishlist_products.dart';

class Wishlist extends StatefulWidget {
  @override
  _WishlistState createState() => _WishlistState();
}

class _WishlistState extends State<Wishlist> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        elevation: 0.1,
        backgroundColor: Colors.blueGrey,
        title: Text('Wishlist',style: new TextStyle(color: Colors.white),),
      ),

      body: new Wishlist_products(),



    );
  }
}
