import 'package:dio/dio.dart' as Dio;
import 'package:feal_app/pages/login.dart';
import 'package:feal_app/pages/register.dart';
import 'package:feal_app/providers/wishlist_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:carousel_pro/carousel_pro.dart';
import 'package:feal_app/components/search_delegate.dart';

//my Own imports
import 'package:feal_app/components/products.dart.';
import 'package:feal_app/pages/cart.dart';
import 'package:feal_app/pages/wishlist.dart';
import 'package:feal_app/pages/categories.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart' as DotEnv;
import 'package:provider/provider.dart';

Future main() async {
  await DotEnv.load();
  runApp(GalileoApp());
}

class GalileoApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<WishlistProvider>.value(
            value: WishlistProvider()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: HomePage(),
      ),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List all_products = [];
  Future<List> getAllProducts() async {
    var dio = Dio.Dio();
    String APIUrl =
        'http://shop.galileo.ba/api/products?limit=250&fields=name%2C%20price%2C%20short_description%2C%20full_description%2C%20id%2C%20images';
    dio.options.headers["Authorization"] =
        'Bearer ' + DotEnv.env['AUTHORIZATION_TOKEN'].toString();
    final response = await dio.get(APIUrl);
    all_products = response.data["products"];
    return response.data["products"];
  }

  @override
  void initState() {
    getAllProducts();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final WishlistProvider wishlistProvider =
        Provider.of<WishlistProvider>(context);

    Widget image_carousel = new Container(
      height: 200.0,
      child: new Carousel(
        boxFit: BoxFit.cover,
        images: [
          AssetImage('images/z1.jpeg'),
          AssetImage('images/z2.jpeg'),
          AssetImage('images/z3.jpeg'),
        ],
        autoplay: true,
        //animationCurve: Curves.fastOutSlowIn,
        //animationDuration: Duration(milliseconds: 1000),
        dotSize: 4.0,
        indicatorBgPadding: 2.0,
        dotBgColor: Colors.transparent,
      ),
    );

    return FutureBuilder(
      future: getAllProducts(),
      builder: (context, snapshot) {
        return Scaffold(
          appBar: new AppBar(
            elevation: 20,
            backgroundColor: Colors.blueGrey,
            title: Padding(
              padding: const EdgeInsets.all(4.0),
              child: Row(
                children: [
                  Expanded(
                    child: Image.asset(
                      'images/Logo2.png',
                    ),
                  ),
                ],
              ),
            ),
            actions: <Widget>[
              new IconButton(
                  icon: Icon(
                    Icons.person,
                    color: Colors.white,
                  ),
                  onPressed: () {
                    showDialog(
                        context: context,
                        builder: (context) {
                          // =================== LOG IN ================
                          return new AlertDialog(
                            title: Container(
                              child: new Text(
                                "Register or Log In \n if you already have account.",
                                style: TextStyle(
                                    color: Colors.white70,
                                    fontSize: 20.0,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                            actions: [
                              Container(
                                child: Column(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(0),
                                      child: Container(
                                        child: FlatButton(
                                            splashColor: Colors.blueGrey,
                                            onPressed: () {
                                              Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          new Register()));
                                            },
                                            child: Text(
                                              'Register',
                                              style: TextStyle(
                                                  fontSize: 20,
                                                  fontWeight: FontWeight.w600,
                                                  color: Colors.black45),
                                            )),
                                        decoration: BoxDecoration(
                                            gradient: LinearGradient(
                                                colors: <Color>[
                                              Colors.grey,
                                              Colors.blueGrey
                                            ])),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(5.0),
                                      child: Container(
                                        child: FlatButton(
                                            splashColor: Colors.blueGrey,
                                            onPressed: () {
                                              Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          new LoginPage()));
                                            },
                                            child: Text(
                                              'Log In',
                                              style: TextStyle(
                                                fontSize: 20,
                                                fontWeight: FontWeight.w600,
                                                color: Colors.black45,
                                              ),
                                            )),
                                        decoration: BoxDecoration(
                                            gradient: LinearGradient(
                                                colors: <Color>[
                                              Colors.grey,
                                              Colors.blueGrey
                                            ])),
                                      ),
                                    ),
                                  ],
                                ),
                              )
                            ],
                            elevation: 20.0,
                            backgroundColor: Colors.blueGrey,
                            shape: RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(25.0))),
                          );
                        });
                  }),
              new IconButton(
                  icon: Icon(
                    Icons.favorite_border,
                    color: Colors.white,
                  ),
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => new Wishlist(
                                  product_ids: wishlistProvider.productList,
                                )));
                  }),
              new IconButton(
                  icon: Icon(
                    Icons.shopping_cart_outlined,
                    color: Colors.white,
                  ),
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => new Cart()));
                  }),
              new IconButton(
                  icon: Icon(
                    Icons.search,
                    color: Colors.white,
                  ),
                  onPressed: () {
                    showSearch(context: context, delegate: ProductSearch(allProducts: all_products, recentProducts: []));
                  }),
            ],
          ),
          drawer: new Drawer(
            child: new ListView(
              children: <Widget>[
                DrawerHeader(
                  decoration: BoxDecoration(
                      gradient: LinearGradient(
                          colors: <Color>[Colors.grey, Colors.blueGrey])),
                  child: Container(
                    child: Column(
                      children: <Widget>[
                        Material(
                            borderRadius:
                                BorderRadius.all(Radius.circular(50.0)),
                            elevation: 20,
                            child: Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Image.asset(
                                'images/Logo2.png',
                                width: 80.0,
                                height: 80.0,
                              ),
                            )),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            'Galileo',
                            style:
                                TextStyle(color: Colors.white, fontSize: 21.0),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                //header
                /*new UserAccountsDrawerHeader(
              accountName: Text('Antonia Pinjuh'),
              accountEmail: Text('antonia.pinjuh@gmail.com'),
              currentAccountPicture: GestureDetector(
                child: new CircleAvatar(
                  backgroundColor: Colors.black,
                  child: Icon(Icons.person, color: Colors.white),
                ),
              ),
              decoration: new BoxDecoration(color: Colors.blueGrey),
            ),*/

                //body

                Container(
                  decoration: BoxDecoration(
                      border: Border(
                          bottom: BorderSide(color: Colors.grey.shade400))),
                  child: InkWell(
                    splashColor: Colors.blueGrey,
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => new HomePage()));
                    },
                    child: ListTile(
                      title: Text('Home Page'),
                      leading: Icon(
                        Icons.home,
                        color: Colors.black,
                      ),
                    ),
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                      border: Border(
                          bottom: BorderSide(color: Colors.grey.shade400))),
                  child: InkWell(
                    splashColor: Colors.blueGrey,
                    onTap: () {},
                    child: ListTile(
                      title: Text('My Account'),
                      leading: Icon(Icons.person, color: Colors.black),
                    ),
                  ),
                ),

                Container(
                  decoration: BoxDecoration(
                      border: Border(
                          bottom: BorderSide(color: Colors.grey.shade400))),
                  child: InkWell(
                    splashColor: Colors.blueGrey,
                    onTap: () {},
                    child: ListTile(
                      title: Text('My Orders'),
                      leading: Icon(Icons.shopping_basket, color: Colors.black),
                    ),
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                      border: Border(
                          bottom: BorderSide(color: Colors.grey.shade400))),
                  child: InkWell(
                    splashColor: Colors.blueGrey,
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => new Categories()));
                    },
                    child: ListTile(
                      title: Text('Category'),
                      leading: Icon(Icons.category, color: Colors.black),
                    ),
                  ),
                ),

                Container(
                  decoration: BoxDecoration(
                      border: Border(
                          bottom: BorderSide(color: Colors.grey.shade400))),
                  child: InkWell(
                    splashColor: Colors.blueGrey,
                    onTap: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => new Cart()));
                    },
                    child: ListTile(
                      title: Text('Shopping cart'),
                      leading: Icon(Icons.shopping_cart, color: Colors.black),
                    ),
                  ),
                ),
                Container(
                  child: InkWell(
                    splashColor: Colors.blueGrey,
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => new Wishlist(
                            product_ids: wishlistProvider.productList,
                          ),
                        ),
                      );
                    },
                    child: ListTile(
                      title: Text('Favourite'),
                      leading: Icon(Icons.favorite, color: Colors.black),
                    ),
                  ),
                ),

                Divider(),

                Container(
                  decoration: BoxDecoration(
                      border: Border(
                          bottom: BorderSide(color: Colors.grey.shade400))),
                  child: InkWell(
                    splashColor: Colors.blueGrey,
                    onTap: () {},
                    child: ListTile(
                      title: Text('Settings'),
                      leading: Icon(
                        Icons.settings,
                        color: Colors.grey,
                      ),
                    ),
                  ),
                ),

                Container(
                  child: InkWell(
                    splashColor: Colors.blueGrey,
                    onTap: () {},
                    child: ListTile(
                      title: Text('About'),
                      leading: Icon(
                        Icons.help,
                        color: Colors.blue,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),

          // =========== BODY =======
          body: new Column(
            children: snapshot.hasData
                ? <Widget>[
                    SizedBox(height: 5),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        decoration: BoxDecoration(
                            color: Colors.white,
                            boxShadow: [
                              BoxShadow(
                                  color: Colors.grey[300],
                                  offset: Offset(1, 1),
                                  blurRadius: 4)
                            ]),
                      ),
                    ),

                    //===================image carousel begin here=================
                    image_carousel,

                    //padding widget
                    /*new Padding(
            padding: const EdgeInsets.all(10.0),
            child: Container(
              alignment: Alignment.centerLeft,
              child: new Text(
                'Category',
                style: new TextStyle(
                  fontSize: 20.0,
                ),
              ),
            ),
          ),*/

                    /* ===========moja horizontalna lista =======
          Container(
            height: 100,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: 7,
              itemBuilder: (_ ,index){
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children:<Widget> [
                      Container(
                          decoration: BoxDecoration(
                              color: Colors.white,
                              boxShadow: [
                                BoxShadow(
                                    color: Colors.grey[400],
                                    offset: Offset(4,6),
                                    blurRadius: 20
                                )
                              ]
                          ),
                          child: Padding(padding: EdgeInsets.all(4),
                            child: Image.asset("images/cats/tools.png",width: 50,),


                          ),


                      ),
                      SizedBox(height: 5,),
                      new Text("Tools",style: new TextStyle(fontSize: 15, fontWeight: FontWeight.bold),)

                    ],
                  ),
                );
              },
            ),
          ),*/

                    //========Horizontal list view begins here==========
                    //     HorizontalList(),
//padding widget
                    Padding(
                      padding: const EdgeInsets.all(3.0),
                      child: Container(
                        decoration: BoxDecoration(
                            color: Colors.blueGrey,
                            borderRadius: BorderRadius.circular(10.0)),
                        child: Row(
                          children: <Widget>[
                            new Padding(
                              padding: const EdgeInsets.all(14.0),
                              child: Container(
                                alignment: Alignment.center,
                                child: new Text(
                                  'Recent products',
                                  style: new TextStyle(
                                    color: Colors.white,
                                    fontSize: 22.0,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  //textAlign: TextAlign.center,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),

//grid view
                    Flexible(child: Products()),
                  ]
                : snapshot.hasError
                    ? [
                        Text("An error has occurred"),
                      ]
                    : [
                        Container(
                            height: 300,
                            alignment: Alignment.center,
                            child: CircularProgressIndicator()),
                      ],
          ),
        );
      },
    );
  }
}
