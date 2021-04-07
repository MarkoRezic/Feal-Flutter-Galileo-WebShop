import 'package:feal_app/pages/login.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import '../main.dart';

class Register extends StatefulWidget {
  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.only(bottom: 30),
        child: Column(
          children:<Widget> [
            Container(
              height: MediaQuery.of(context).size.height*0.3,
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: <Color>[Colors.grey, Colors.blueGrey],
                    end: Alignment.bottomCenter,
                    begin:Alignment.topCenter,
                  ),
                  borderRadius:
                  BorderRadius.only(bottomLeft: Radius.circular(90))
              ),
              child: Center(
                  child:InkWell(
                    onTap: (){
                      Navigator.push(context,MaterialPageRoute(builder: (context)=>HomePage()));
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset('images/Logo2.png',width: 200,height: 100,),
                      ],
                    ),
                  )
              ),

            ),
            Expanded(
              child: Container(
                margin: EdgeInsets.only(left: 20,right: 20,top: 30),
                child: Column(
                  children: [
                    _textInput(hint: "Fullname",icon: Icons.person),
                    _textInput(hint: "Email",icon: Icons.email),
                    _textInput(hint: "Phone Number",icon: Icons.call),
                    _textInput(hint: "Password",icon: Icons.vpn_key),
                    Expanded(
                      child: Center(
                        child: InkWell(
                          onTap: (){
                            Navigator.push(context,MaterialPageRoute(builder: (context)=>LoginPage()));
                          },
                          child: Container(
                            width: double.infinity,
                            height: 50,
                            decoration: BoxDecoration(
                                gradient: LinearGradient(
                                  colors: <Color>[Colors.grey, Colors.blueGrey],
                                  end: Alignment.centerLeft,
                                  begin:Alignment.centerRight,
                                ),
                                borderRadius:
                                BorderRadius.all(Radius.circular(100))
                            ),
                            alignment: Alignment.center,
                            child: Text("REGISTER",style: TextStyle(fontSize: 20,color: Colors.white,fontWeight: FontWeight.bold),),
                          ),
                        ),
                      ),
                    )

                  ],
                ),
              ),
            ),
            RichText(
                text: TextSpan(
                    children:[
                      TextSpan(text: "Already a member?",style: TextStyle(color: Colors.black)),
                      TextSpan(text: "  Login",style: TextStyle(color: Colors.blueGrey ),
                      recognizer: TapGestureRecognizer()..onTap=(){
                        Navigator.push(context,MaterialPageRoute(builder: (context)=>LoginPage()
                        )
                        );
                      }
                      ),
                    ]))
          ],
        ),
      ),
    );


  }
  Widget  _textInput({controller,hint,icon})
  {
    return Container(
      margin: EdgeInsets.only(top: 10),
      decoration: BoxDecoration(
        borderRadius:BorderRadius.all(Radius.circular(20)),
        color:Colors.white,
      ),
      padding: EdgeInsets.only(left:10 ),
      child: TextFormField(
        controller: controller,
        decoration: InputDecoration(
          border:InputBorder.none ,
          hintText: hint,
          prefixIcon: Icon(icon),

        ),
      ),
    );
  }
}
