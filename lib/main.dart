import 'package:feal_app/pages/login.dart';
import 'package:feal_app/pages/register.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:carousel_pro/carousel_pro.dart';

//my Own imports
import 'package:feal_app/components/products.dart.';
import 'package:feal_app/pages/cart.dart';
import 'package:feal_app/pages/wishlist.dart';
import 'package:feal_app/pages/categories.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart' as DotEnv;

Future main() async {
  await DotEnv.load();
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: HomePage(),
  ));
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
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

    return Scaffold(
      appBar: new AppBar(
        elevation: 0.1,
        backgroundColor: Colors.blueGrey,
        title: Padding(
          padding: const EdgeInsets.all(4.0),
          child: Row(
            children: [
              Image.asset(
                'images/Logo2.png',
                width: 130,
                height: 70,
              )
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
                            style:
                                TextStyle(color: Colors.white70, fontSize: 20.0,fontWeight: FontWeight.bold),
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
                                          Navigator.push(context,
                                              MaterialPageRoute(builder: (context) => new Register()));
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
                                          Navigator.push(context,
                                              MaterialPageRoute(builder: (context) => new LoginPage()));
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
                            borderRadius: BorderRadius.all(Radius.circular(25.0))
                        ),



                      );
                    });
              }),
          new IconButton(
              icon: Icon(
                Icons.favorite_border,
                color: Colors.white,
              ),
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => new Wishlist()));
              }),
          new IconButton(
              icon: Icon(
                Icons.shopping_cart,
                color: Colors.white,
              ),
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => new Cart()));
              })
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
                        borderRadius: BorderRadius.all(Radius.circular(50.0)),
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
                        style: TextStyle(color: Colors.white, fontSize: 21.0),
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
                  border:
                      Border(bottom: BorderSide(color: Colors.grey.shade400))),
              child: InkWell(
                splashColor: Colors.blueGrey,
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => new HomePage()));
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
                  border:
                      Border(bottom: BorderSide(color: Colors.grey.shade400))),
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
                  border:
                      Border(bottom: BorderSide(color: Colors.grey.shade400))),
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
                  border:
                      Border(bottom: BorderSide(color: Colors.grey.shade400))),
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
                  border:
                      Border(bottom: BorderSide(color: Colors.grey.shade400))),
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
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => new Wishlist()));
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
                  border:
                      Border(bottom: BorderSide(color: Colors.grey.shade400))),
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
        children: <Widget>[
          SizedBox(height: 5),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              decoration: BoxDecoration(color: Colors.white, boxShadow: [
                BoxShadow(
                    color: Colors.grey[300],
                    offset: Offset(1, 1),
                    blurRadius: 4)
              ]),
              child: ListTile(
                leading: Icon(
                  Icons.search,
                  color: Colors.black,
                ),
                title: TextField(
                  decoration: InputDecoration(
                      hintText: "Search Store", border: InputBorder.none),
                ),
                trailing: Icon(
                  Icons.filter_list,
                  color: Colors.black,
                ),
              ),
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
                      child: new Text('Recent products',
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
        ],
      ),
    );
  }
}
