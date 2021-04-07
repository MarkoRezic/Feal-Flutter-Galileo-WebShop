import 'package:dio/dio.dart' as Dio;
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart' as DotEnv;

class ExpandedProductGrid extends StatefulWidget {
  @override
  final String category_id;
  final String category_name;
  ExpandedProductGrid({this.category_id, this.category_name});
  _ExpandedProductGridState createState() => _ExpandedProductGridState();
}

class _ExpandedProductGridState extends State<ExpandedProductGrid> {
  List<Widget> productWidgets = [];
  Future<String> getProducts() async {
    var dio = Dio.Dio();
    String APIUrl = 'http://shop.galileo.ba/api/products?categoryId=' +
        this.widget.category_id.toString() +
        '&fields=name%2C%20price%2C%20localized_names%2C%20images%2C%20id%2C%20categoryId%2C%20short_description%2C%20full_description';
    dio.options.headers["Authorization"] = 'Bearer ' + DotEnv.env['AUTHORIZATION_TOKEN'].toString();
    final response = await dio.get(APIUrl);
    productWidgets =
        getProductWidgets(response.data["products"], this.widget.category_name);
    return response.data.toString();
  }

  List getProductWidgets(value, String category_name) {
    List<Widget> newProductWidgets = [];
    for (var i = 0; i < value.length; i++) {
      newProductWidgets.add(ProductTile(
        image_location: 'images/categories/' +
            category_name.toLowerCase() +
            '/' +
            value[i]["images"][0]["id"].toString() +
            '.jpg',
        //image_location: 'images/categories/1.png',
        image_caption: value[i]["name"].toString(),
        product_id: value[i]["id"].toString(),
        category_name: this.widget.category_name,
        price: value[i]["price"].toString(),
        short_description: value[i]["short_description"] != null ? value[i]["short_description"].toString() : '',
        full_description: value[i]["full_description"] != null ? value[i]["full_description"].toString() : '',
      ));
    }
    return newProductWidgets;
  }

  @override
  void initState() {
    getProducts();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: getProducts(),
      builder: (context, snapshot) {
        if (snapshot.hasData)
          return Expanded(
            child: Container(
                alignment: Alignment.center,
                child: productWidgets.length > 0
                    ? GridView.count(
                        crossAxisCount: 3,
                        scrollDirection: Axis.vertical,
                        children: productWidgets,
                      )
                    : Text(
                        'No products found',
                        style: new TextStyle(fontSize: 20.0),
                      )),
          );
        else if (snapshot.hasError)
          return Text('An error has occurred');
        else
          return Expanded(
              child: Container(
                  alignment: Alignment.center,
                  child: CircularProgressIndicator()));
      },
    );
  }
}

class ProductTile extends StatelessWidget {
  final String image_location;
  final String image_caption;
  final String product_id;
  final String category_name;
  final String price;
  final String short_description;
  final String full_description;

  ProductTile(
      {this.image_location,
      this.image_caption,
      this.product_id,
      this.category_name,
      this.price,
      this.short_description,
      this.full_description});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: InkWell(
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => new ProductDetails(
                        image_location: this.image_location,
                        product_name: this.image_caption,
                        product_id: this.product_id,
                        category_name: this.category_name,
                        price: this.price,
                        short_description: this.short_description,
                        full_description: this.full_description,
                      )));
        },
        child: Container(
          width: 90,
          child: ListTile(
            title: Image.asset(
              image_location,
              width: 50.0,
              height: 60.0,
            ),
            subtitle: Container(
              alignment: Alignment.topCenter,
              child: Text(
                image_caption,
                overflow: TextOverflow.ellipsis,
                maxLines: 3,
                style: new TextStyle(fontSize: 15.0),
                textAlign: TextAlign.center,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class ProductDetails extends StatelessWidget {
  final String image_location;
  final String product_name;
  final String product_id;
  final String category_name;
  final String price;
  final String short_description;
  final String full_description;

  ProductDetails(
      {this.image_location,
      this.product_name,
      this.product_id,
      this.category_name,
      this.price,
      this.short_description,
      this.full_description});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        elevation: 0.1,
        backgroundColor: Colors.blueGrey,
        title: Text(
          this.category_name,
          style: new TextStyle(color: Colors.white),
        ),
        actions: <Widget>[
          new IconButton(
              icon: Icon(
                Icons.favorite_border,
                color: Colors.white,
              ),
              onPressed: () {})
        ],
      ),
      body: new Column(children: [
        Container(
            padding: EdgeInsets.all(10.0),
            height: 200,
            child: Image.asset(image_location, fit: BoxFit.fill)),
        Container(
            padding: EdgeInsets.all(15.0),
            child: ExpandableText(
              text: product_name,
              textStyle: new TextStyle(fontSize: 30.0),
              maxLines: 1,
            )),
        Container(
            padding: EdgeInsets.all(15.0),
            child: ExpandableText(
              text: price + ' KM',
              textStyle: new TextStyle(fontSize: 30.0, fontWeight: FontWeight.bold),
              maxLines: 1,
            )),
        Container(
            padding: EdgeInsets.all(15.0),
            child: ExpandableText(
              text: short_description,
              textStyle: new TextStyle(fontSize: 20.0),
              maxLines: 1,
            )),
        Expanded(
            child: Container(
                child: ListView(scrollDirection: Axis.vertical, children: [
          Container(
              padding: EdgeInsets.all(15.0),
              child: Html(
                data: """ """+ full_description +""" """,

              ))
        ])))
      ]),
    );
  }
}

class ExpandableText extends StatefulWidget {
  final String text;
  final TextStyle textStyle;
  final int maxLines;

  const ExpandableText({Key key, this.maxLines, this.text, this.textStyle})
      : super(key: key);

  @override
  _ExpandableTextState createState() => _ExpandableTextState();
}

class _ExpandableTextState extends State<ExpandableText> {
  bool _isExpanded = false;

  @override
  Widget build(BuildContext context) => InkWell(
        onTap: () {
          setState(() {
            _isExpanded = !_isExpanded;
          });
        },
        child: Text(
          widget.text,
          style: widget.textStyle,
          overflow: TextOverflow.ellipsis,
          maxLines: _isExpanded ? 20 : widget.maxLines,
        ),
      );
}
