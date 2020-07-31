import 'package:flutter/material.dart';

const kPokedexUrl =
    "https://raw.githubusercontent.com/Biuni/PokemonGO-Pokedex/master/pokedex.json";

final Map<String, Color> kColorTypes = {
  "Grass": Colors.lightGreen.shade400,
  "Dragon": Colors.lightBlue.shade400,
  "Psychic": Colors.pinkAccent.shade200,
  "Fire": Colors.red.shade400,
  "Water": Colors.blue.shade400,
  "Ice": Colors.lightBlueAccent,
  "Normal": Colors.grey.shade400,
  "Rock": Colors.orange.shade400,
  "Electric": Colors.yellow.shade700,
  "Bug": Colors.green,
  "Ground": Colors.brown,
  "Poison": Colors.purple.shade400,
  "Fighting": Colors.deepOrange.shade400,
  "Ghost": Colors.deepPurpleAccent,
  "Flying": Colors.grey,
};