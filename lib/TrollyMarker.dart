import 'package:flutter/material.dart';
import 'package:iotflutterapp/MapScreen.dart';

class TrollyMarker extends StatelessWidget {
//  int count;
//  int id;
  const TrollyMarker({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
//    id = count;
//    count++;
    return Container(
      child: IconButton(
        icon: Icon(Icons.shopping_cart),
        color: Colors.green,
        iconSize: 20.0,
        onPressed: () {
          print('clicked!');
//          trollyMarkers.removeAt(id);
        },
      ),
    );
  }
}
