import 'dart:async';
import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:pokedex_app/pokeDetailScreen.dart';
import 'package:pokedex_app/pokemon.dart';
import 'package:pokedex_app/typeBadge.dart';

import 'constants.dart';


Future<List<Pokemon>> fetchPokemon(http.Client client) async {
  final response = await client.get(kPokedexUrl);
  //  return compute(parsePokemon, response.body);
  return parsePokemon(response.body);
}

List<Pokemon> parsePokemon(String responseBody) {
  var pokemonJsonList = jsonDecode(responseBody)["pokemon"] as List;

  List<Pokemon> listOfPokemon =
      pokemonJsonList.map((json) => Pokemon.fromJson(json)).toList();
  return listOfPokemon;
}

void main() {
  runApp(PokedexApp());
}

class PokedexApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Pokedex App',
        home: Scaffold(
          body: PokeListScreen(),
        ));
  }
}

class PokeListScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
          padding: EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Container(
                  child: Text(
                "Pokedex",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 32.0),
              )),
              Container(
                child: Text(
                  "Generation 1",
                  style: TextStyle(color: Colors.grey.shade600, fontSize: 18.0),
                ),
              ),
              Expanded(
                child: Container(
                    padding: EdgeInsets.only(top: 20.0),
                    child: FutureBuilder<List<Pokemon>>(
                      future: fetchPokemon(http.Client()),
                      builder: (context, snapshot) {
                        if (snapshot.hasError) {
                          print("Error is:");
                          print(snapshot.error);
                        }

                        return snapshot.hasData
                            ? PokeList(pokemon: snapshot.data)
                            : Center(child: CircularProgressIndicator());
                      },
                    )),
              ),
            ],
          )),
    );
  }
}

class PokeList extends StatelessWidget {
  final List<Pokemon> pokemon;

  PokeList({Key key, this.pokemon}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: pokemon.length,
        itemBuilder: (_, index) {
          return PokeListItem(pokemon: pokemon[index]);
        });
  }
}

class PokeListItem extends StatelessWidget {
  final Pokemon pokemon;

  PokeListItem({Key key, this.pokemon}) : super(key: key);

  Color _getColorBasedOnType(String typeName) {
    Color typeColor = kColorTypes[typeName];

    return Color.fromARGB(170, typeColor.red, typeColor.green, typeColor.blue);
  }

  List<Widget> _buildTypeBadges(List<String> types) {
    return types.map((typeName) => TypeBadge(typeName: typeName)).toList();
  }

  Widget _buildImage() {
    return Positioned(
      bottom: 10,
      right: 20,
      child: Hero(
        tag: "poke-img-${pokemon.id}",
        child: Image.network(
            "https://assets.pokemon.com/assets/cms2/img/pokedex/full/${pokemon.num}.png",
            height: 130.0),
      ),
    );
  }

  Widget _buildContent() {
    return Column(
      children: <Widget>[
        Spacer(),
        Container(
          margin: EdgeInsets.only(bottom: 10.0),
          padding: EdgeInsets.all(10.0),
          decoration: BoxDecoration(
            color: _getColorBasedOnType(pokemon.type[0]),
            borderRadius: BorderRadius.circular(10.0),
          ),
          child: Row(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(left: 10.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(bottom: 5.0),
                      child: Text("#${pokemon.num}",
                          style: TextStyle(letterSpacing: 1.5)),
                    ),
                    Text(
                      pokemon.name,
                      style: TextStyle(
                          fontSize: 20.0,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 1.0),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 5.0),
                      child: Row(children: _buildTypeBadges(pokemon.type)),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 140,
      child: GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => PokeDetailScreen(pokemon: pokemon)),
          );
        },
        child: Stack(
          children: [
            _buildContent(),
            _buildImage(),
          ],
        ),
      ),
    );
  }
}
