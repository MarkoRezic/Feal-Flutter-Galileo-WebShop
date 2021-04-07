import 'package:feal_app/components/screen_navigation.dart';
import 'package:flutter/material.dart';

import 'package:feal_app/pages/category_products.dart';
import 'package:feal_app/pages/appare.dart';
import 'package:feal_app/components/screen_navigation.dart';

class HorizontalList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 80.0,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children:<Widget> [
          Category(
            image_location: 'images/cats/tools.png',
            image_caption: 'tools',
          ),

          Category(
            image_location: 'images/cats/apparel.png',
            image_caption: 'apparel',
          ),

          Category(
            image_location: 'images/cats/digital.png',
            image_caption: 'digital',
          ),

          Category(
            image_location: 'images/cats/digital.png',
            image_caption: 'digital',
          ),


        ],
      ),
    );
  }
}

class Category extends StatelessWidget {
  final String image_location;
  final String image_caption;

  Category({
    this.image_location,
    this.image_caption
});

  @override
  Widget build(BuildContext context) {
    return Padding(padding: const EdgeInsets.all(22.0),
    child: InkWell(onTap:() {

    },
    child: Container(
      width: 80.0,
      child: ListTile(
        title: Image.asset(image_location,
        width: 70.0,
        height: 70.0,
        ),
        subtitle: Container(
          alignment: Alignment.topCenter,
          child: Text(image_caption, style: new TextStyle(fontSize: 15.0),),
        ),
      ),
    ),
    ),
    );


  }
}
