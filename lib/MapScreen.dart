import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong/latlong.dart';
import 'package:http/http.dart' as http;

class MapScreen extends StatefulWidget {
  @override
  _State createState() => _State();
}

class _State extends State<MapScreen> {
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
            zoom: 13.0,
          ),
          layers: [
            new TileLayerOptions(
                urlTemplate:
                    "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
                subdomains: ['a', 'b', 'c']),
            new MarkerLayerOptions(
              markers: [
                new Marker(
                  width: 80.0,
                  height: 80.0,
                  point: new LatLng(51.5, -0.09),
                  builder: (ctx) => new Container(
                    child: new FlutterLogo(),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
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
          ],
        ),
      ),
    );
  }
}
