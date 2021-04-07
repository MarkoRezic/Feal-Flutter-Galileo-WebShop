import 'package:flutter/material.dart';

import 'package:feal_app/components/category_products_gridview.dart';

class CategoryProducts extends StatefulWidget {
  final String category_id;
  final String category_name;

  CategoryProducts({this.category_id, this.category_name});
  @override
  _CategoryProductsState createState() => _CategoryProductsState();
}

class _CategoryProductsState extends State<CategoryProducts> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        elevation: 0.1,
        backgroundColor: Colors.blueGrey,
        title: Text(this.widget.category_name,style: new TextStyle(color: Colors.white),),
        actions:<Widget> [
          new IconButton(icon: Icon(Icons.search,color: Colors.white,), onPressed:(){})
        ],
      ),


        body: new Column(
          children: <Widget>[
            ExpandedProductGrid(category_id: this.widget.category_id, category_name: this.widget.category_name,),
          ],

        ),
    );
  }
}
