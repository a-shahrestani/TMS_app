import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong/latlong.dart';
import 'dart:math';
import 'package:http/http.dart' as http;

import 'Trolly.dart';
import 'TrollyMarker.dart';

List<Marker> trollyMarkers = [];

class MapScreen extends StatefulWidget {
  @override
  _State createState() => _State();
}

class _State extends State<MapScreen> {
//  List<Marker, Trolly> trollies;
//  static List<Marker> trollyMarkers = [];
  var rng = new Random();

  void addTrollyMarker(double lat, double lng) {
    trollyMarkers.add(Marker(
        width: 10.0,
        height: 10.0,
        point: LatLng(lat, lng),
        builder: (ctx) => TrollyMarker()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text('سامانه مدیریت چرخ دستی')),
      ),
      body: Center(
        child: FlutterMap(
          options: new MapOptions(
            center: new LatLng(51.5, -0.09),
            zoom: 10.0,
          ),
          layers: [
            new TileLayerOptions(
                urlTemplate:
                    "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
                subdomains: ['a', 'b', 'c']),
            new MarkerLayerOptions(
              markers: trollyMarkers,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            double a = rng.nextDouble() * 2 + 50.0;
            double b = rng.nextDouble() * -1.0;
            addTrollyMarker(a, b);
          });
        },
      ),
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
                  Navigator.pushReplacementNamed(context, '/SignOut');
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

//  void chooseTrolly(){
//
//  }
}
