import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:iotflutterapp/TrollyMarker.dart';
import 'package:latlong/latlong.dart';

class Trolly {
  TrollyMarker trollyMarker;
  double _width;
  double _height;
  Marker marker;
  double _lat;
  double _lng;
  int id;
  Color _color = Colors.green;

  Color getColor() {
    return _color;
  }

  void updateColor() {
    _color = Colors.red;
  }

  double getLat() {
    return _lat;
  }

  double getLng() {
    return _lng;
  }

  Trolly() {
    trollyMarker = TrollyMarker();
    marker = Marker(
        width: _width,
        height: _height,
        point: LatLng(_lat, _lng),
        builder: (ctx) => trollyMarker);
  }
}
