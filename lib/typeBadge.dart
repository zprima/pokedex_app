import 'package:flutter/material.dart';
import "constants.dart";

class TypeBadge extends StatelessWidget {
  final String typeName;

  TypeBadge({Key key, this.typeName}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.all(5.0),
        margin: EdgeInsets.only(right: 5.0),
        decoration: BoxDecoration(
          color: kColorTypes[typeName],
          borderRadius: BorderRadius.circular(5.0),
        ),
        child: Text(
          typeName,
          style: TextStyle(fontSize: 12.0, color: Colors.white),
        ));
  }
}