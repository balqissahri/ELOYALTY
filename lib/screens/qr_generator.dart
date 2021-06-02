import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'dart:ui';
import 'package:flutter/rendering.dart';

class GeneratePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => GeneratePageState();
}

class GeneratePageState extends State<GeneratePage> {
  String qrData =
      "https://github.com/neon97";  // already generated qr code when the page opens

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('QR Code Generator'),
        actions: <Widget>[],
      ),
      body: Container(
        padding: EdgeInsets.all(20.0),
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              QrImage(
                //plce where the QR Image will be shown
                data: qrData,
              ),
              SizedBox(
                height: 40.0,
              ),
              Text(
                "New QR Card Generator",
                style: TextStyle(fontSize: 20.0),
              ),
              TextField(
                controller: qrdataFeed,
                decoration: InputDecoration(
                  hintText: "Input card number here",
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    margin: EdgeInsets.only(bottom: 50),
                    height: 70,
                    width: 150,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(100)),
                        color: Colors.orangeAccent
                    ),
                    child: FlatButton(
                      child: Text("CREATE QR", style: TextStyle(
                          color: Colors.white
                      ),),
                      onPressed: () async {

                        if (qrdataFeed.text.isEmpty) {        //a little validation for the textfield
                          setState(() {
                            qrData = "";
                          });
                        } else {
                          setState(() {
                            qrData = qrdataFeed.text;
                          });
                        }

                      },

                    ),
                  ),


                  SizedBox(
                    width: 15,
                  ),
                  Container(
                    margin: EdgeInsets.only(bottom: 50),
                    height: 70,
                    width: 150,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(100)),
                        color: Colors.blueAccent
                    ),
                    child: FlatButton(
                      child: Text("SAVE QR", style: TextStyle(
                          color: Colors.white
                      ),),
                      onPressed: (){

                      },
                    ),
                  )

                ],
              ),
            ]
        ),
      ),
    );
  }

  final qrdataFeed = TextEditingController();
}