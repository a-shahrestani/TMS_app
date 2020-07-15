import 'package:flutter/material.dart';
import 'package:iotflutterapp/MapScreen_Customer.dart';
import 'package:iotflutterapp/Trolly.dart';

class TrollyMarker extends StatelessWidget {
//  int count;
  final int id;
  final Function(int, double, double) onPressTrollyMarker;

  const TrollyMarker({
    Key key,
    this.id,
    this.onPressTrollyMarker,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
//    id = count;
//    count++;
    return Container(
        child: FlatButton(
      child: Icon(Icons.shopping_cart),
      onPressed: () {
        for (Trolly t in trollyMarkers) {
          if (t.id == this.id) {
            onPressTrollyMarker(t.id, t.point.latitude, t.point.longitude);
            print('clicked');
            break;
          }
        }
      },
    ));
  }
}

//IconButton(
//icon: Icon(Icons.location_on),
//color: Colors.green,
//iconSize: 50.0,
//onPressed: () {
//for (Trolly t in trollyMarkers) {
//if (t.id == this.id) {
//onPressTrollyMarker(t.id, t.point.latitude, t.point.longitude);
//print('clicked');
//break;
//}
//}
//},
//),
