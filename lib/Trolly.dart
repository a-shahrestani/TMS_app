import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:iotflutterapp/TrollyMarker.dart';
import 'package:latlong/latlong.dart';

//class Trolly extends StatelessWidget {
//  final double width;
//  final double height;
//  final int id;
//  final double lat;
//  final double lng;
//  final Color color;
//
//  const Trolly({this.width,this.height,this.id,this.lat,this.lng,this.color});
//
//  @override
//  Widget build(BuildContext context) {
//    // TODO: implement build
//    throw UnimplementedError();
//  }
//}

class Trolly extends Marker {
  final LatLng point;
  final WidgetBuilder builder;
  final double width;
  final double height;
  final Anchor anchor;
  final int id;
//  final Function(Trolly) onPressTrolly;

  int getID() {
    return id;
  }

  LatLng getPoint() {
    return point;
  }

  Trolly({
    this.point,
    this.builder,
    this.width = 30.0,
    this.height = 30.0,
    this.id,
//    this.onPressTrolly,
    AnchorPos anchorPos,
  }) : anchor = Anchor.forPos(anchorPos, width, height);

  @override
  String toString() {
    // TODO: implement toString
    String s = '';
    s = this.height.toString() +
        ' ' +
        this.height.toString() +
        ' ' +
        this.width.toString() +
        ' ' +
        this.id.toString() +
        ' ' +
        this.point.toString();
    return s;
  }
}
