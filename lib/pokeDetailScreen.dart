import 'package:flutter/material.dart';
import 'package:pokedex_app/pokemon.dart';
import 'package:pokedex_app/typeBadge.dart';
import "constants.dart";

class PokeDetailScreen extends StatelessWidget {
  final Pokemon pokemon;

  PokeDetailScreen({Key key, this.pokemon}) : super(key: key);

  Color _getColorBasedOnType(String typeName) {
    Color typeColor = kColorTypes[typeName];

    return Color.fromARGB(170, typeColor.red, typeColor.green, typeColor.blue);
  }

  List<Widget> _buildTypeBadges(List<String> types) {
    return types.map((typeName) => TypeBadge(typeName: typeName)).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: <Widget>[
             Stack(
                children: [
                  Container(
                    height: MediaQuery.of(context).size.height / 2.0,
                    child: ClipPath(
                      clipper: MyClipper(),
                      child: Container(
                        height: 300.0,
                        decoration: BoxDecoration(color:_getColorBasedOnType(pokemon.type[0]), borderRadius: BorderRadius.only(bottomLeft: Radius.circular(20.0), bottomRight: Radius.circular(20.0),),),
                        child: Column(
                        children: <Widget>[
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              IconButton(icon: Icon(Icons.arrow_back, color: Colors.white,), onPressed: () {
                                Navigator.pop(context);
                              }),

                            ],
                          ),
                          Container(
                            padding: EdgeInsets.all(20.0),
                            child: Row(
                              children: <Widget>[
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Text("#${pokemon.num}", style: TextStyle(letterSpacing: 1.5)),
                                    Text(pokemon.name, style: TextStyle(fontSize: 32.0, color: Colors.white),),
                                  ],
                                ),
                                Spacer(),
                                ..._buildTypeBadges(pokemon.type),
                              ],
                            ),
                          ),
                        ],
                      ),
                      ),
                    ),
                  ),
                  Positioned(
                    top: 130.0,
                    left: MediaQuery.of(context).size.width * 0.5 / 2.0,
                    child: Hero(
                      tag: "poke-img-${pokemon.id}",
                      child: Image.network("https://assets.pokemon.com/assets/cms2/img/pokedex/full/${pokemon.num}.png",height: 240.0,),
                    ),
                  ),
                ],
              ),
            Spacer(),
          ],
        ),
      )
    );
  }
}

class MyClipper extends CustomClipper<Path>{
  @override
  Path getClip(Size size) {
    var path = Path();

    path.lineTo(0, size.height - 80.0);

    path.quadraticBezierTo(size.width/2, size.height, size.width, size.height - 80.0);

    path.lineTo(size.width, 0);

    path.close();

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return false;
  }

}