import 'dart:async';
import 'dart:async';
import 'dart:async';
import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong/latlong.dart';
import 'dart:math';
import 'package:http/http.dart' as http;
import 'package:sliding_up_panel/sliding_up_panel.dart';

import 'Trolly.dart';
import 'TrollyMarker.dart';
import 'main.dart';

List<Trolly> trollyMarkers = [];

class MapScreenCustomer extends StatefulWidget {
  @override
  _State createState() => _State();
}

class _State extends State<MapScreenCustomer> {
  Color buttonColor = Colors.green[500];
  int chosenTrollyCustomerID = 0;
  double chosenTrollyCustomerLat = 0.0;
  double chosenTrollyCustomerLng = 0.0;
  String fetchFreeTrolliesAPI =
      'http://185.205.209.236:8000/trolly/availables/';
  String trollySelectionAPI = 'http://185.205.209.236:8000/trolly/occupy/';
  String releaseTrollyAPI = 'http://185.205.209.236:8000/trolly/free/';

  // a state that indicates that customer has chosen a trolly and should now release it
  int _innerState = 0;
  String trollyButtonText = 'Choose Trolly';

  onPressTrolly(int id, double lat, double lng) {
    setState(() {
      chosenTrollyCustomerID = id;
      chosenTrollyCustomerLat = lat;
      chosenTrollyCustomerLng = lng;
    });
    print(chosenTrollyCustomerID);
    p1.open();
  }

//  List<Marker, Trolly> trollies;
//  static List<Marker> trollyMarkers = [];
  var rng = new Random();
  Timer _everySecond;
  PanelController p1 = PanelController();

//  double chosenTrollyLat;
//  double chosenTrollyLng;
//  int chosenTrollyID;

  List<Trolly> addTrollyMarker(
      List<Trolly> tempTrollies, int id, double lat, double lng) {
    tempTrollies.add(Trolly(
        width: 10.0,
        height: 10.0,
        id: id,
        point: LatLng(lat, lng),
        builder: (ctx) => TrollyMarker(
              id: id,
              onPressTrollyMarker: onPressTrolly,
            )));
    return tempTrollies;
  }

  Future<Map<String, dynamic>> getTrolliesData(String user) async {
    Response response;
    Dio dio = Dio();
    // get trollies form somewhere
    Map<String, dynamic> authData = {"username": user};
    FormData formData = new FormData.fromMap(authData);
    response = await dio.post(fetchFreeTrolliesAPI, data: formData);
    print(response.data);
    return response.data;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _everySecond = Timer.periodic(Duration(seconds: 10), (Timer t) async {
      var temp = await getTrolliesData(LoginPage.user);
      print(temp.length);

      List<Trolly> tempTrollies = [];
      for (int i = 0; i < temp.length; i++) {
        if (temp[i.toString()] != null) {
          tempTrollies = addTrollyMarker(tempTrollies, temp[i.toString()]['id'],
              temp[i.toString()]['x'], temp[i.toString()]['y']);
        } else
          tempTrollies = addTrollyMarker(
              tempTrollies, temp[i]['id'], temp[i]['x'], temp[i]['y']);
//        print(temp[i.toString()]['id'].runtimeType);
//        print(temp[i.toString()]['x'].runtimeType);
//        print(temp[i.toString()]['y'].runtimeType);
      }
//      for (int j = 0; j < trollyMarkers.length; j++) {
//        print(trollyMarkers[j].toString());
//      }
      setState(() {
        trollyMarkers = tempTrollies;
      });
//      for (int j = 0; j < trollyMarkers.length; j++) {
//        print(trollyMarkers[j]);
//      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text('Trolly Management System')),
      ),
      body: SlidingUpPanel(
        collapsed: Center(child: Text('Select a trolly')),
        minHeight: 20.0,
        controller: p1,
        borderRadius: BorderRadius.only(
            topLeft: const Radius.circular(25.0),
            topRight: const Radius.circular(25.0)),
        maxHeight: 130.0,
        backdropOpacity: 0.5,
        panel: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              SizedBox(
                height: 10.0,
              ),
              Center(
                child: Text('$chosenTrollyCustomerID'),
              ),
              Row(
                children: <Widget>[
                  Expanded(
                      child: Center(child: Text('$chosenTrollyCustomerLat'))),
                  Expanded(
                      child: Center(child: Text('$chosenTrollyCustomerLng'))),
                ],
              ),
              FlatButton(
                color: buttonColor,
                child: Center(child: Text('$trollyButtonText')),
                onPressed: () async {
                  if (_innerState == 0) {
                    var temp = await selectTrolly(
                        LoginPage.user, chosenTrollyCustomerID);
                    if (temp['status'] == 'ok')
                      setState(() {
                        trollyButtonText = 'Release Trolly';
                        buttonColor = Colors.red[500];
                        _innerState = 1;
                      });
                  } else {
                    var temp = await releaseTrolly(chosenTrollyCustomerID);
                    if (temp['status'] == 'ok')
                      setState(() {
                        trollyButtonText = 'Choose Trolly';
                        buttonColor = Colors.green[500];
                        _innerState = 0;
                      });
                  }
                },
              ),
            ],
          ),
        ),
        body: Center(
          child: FlutterMap(
            options: new MapOptions(
                center: new LatLng(36.312833, 59.516944),
                zoom: 18.0,
                maxZoom: 18.5),
            layers: [
              new TileLayerOptions(
                  urlTemplate:
//                    "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
                      "http://46.101.204.164/tile/{z}/{x}/{y}.png",
                  subdomains: ['a', 'b', 'c']),
              new MarkerLayerOptions(
                markers: trollyMarkers,
              ),
            ],
          ),
        ),
      ),
//      floatingActionButton: FloatingActionButton(
//        onPressed: () {
//          setState(() {
////            double a = rng.nextDouble() * 2 + 50.0;
////            double b = rng.nextDouble() * 1.0;
////            addTrollyMarker(rng.nextInt(100), a, b);
//            addTrollyMarker(1, 36.312833, 59.516944);
//          });
//        },
//      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              child: Text('test'),
              decoration: BoxDecoration(color: Colors.amber),
            ),
            ListTile(
              title: Text('t1'),
              //Put onTap here
            ),
            ListTile(
              title: Text('t2'),
              //Put onTap here
            ),
            Align(
              alignment: Alignment.bottomLeft,
              child: ListTile(
                onTap: () {
//                  Navigator.pushReplacementNamed(context, '/SignOut');
                  Navigator.of(context).pushNamedAndRemoveUntil(
                      '/LoginPage', (Route<dynamic> route) => false);
                },
                title: Text('Log Out'),
                trailing: Icon(Icons.close),
                //Put onTap here
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<Map<String, dynamic>> selectTrolly(String user, int id) async {
    Response response;
    Dio dio = Dio();
    final Map<String, dynamic> authData = {"username": user, "trolly_id": id};
    FormData formData = new FormData.fromMap(authData);
    response = await dio.post(trollySelectionAPI, data: formData);
    print(response.data);
    return response.data;
  }

  Future<Map<String, dynamic>> releaseTrolly(int id) async {
    Response response;
    Dio dio = Dio();
    final Map<String, dynamic> authData = {"trolly_id": id};
    FormData formData = new FormData.fromMap(authData);
    response = await dio.post(releaseTrollyAPI, data: formData);
    print(response.data);
    return response.data;
  }

//
//  }
}
