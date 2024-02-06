import 'package:flutter/material.dart';

TextStyle tileTitle = const TextStyle(
  fontWeight: FontWeight.w500,
  color: Colors.white,
  fontSize: 23,
);

TextStyle titolo = const TextStyle(
  fontWeight: FontWeight.w600,
  color: Colors.black,
  fontSize: 30,
);

TextStyle sottotitoloGrassetto = const TextStyle(
  fontWeight: FontWeight.w600,
  color: Colors.black,
  fontSize: 15,
);

TextStyle sottotitolo = const TextStyle(
  fontWeight: FontWeight.w400,
  color: Colors.black,
  fontSize: 15,
);

TextStyle sottotitoloRed = const TextStyle(
  fontWeight: FontWeight.w400,
  color: Colors.red,
  fontSize: 15,
);

TextStyle sottotitoloLink = const TextStyle(
  fontWeight: FontWeight.w400,
  color: Colors.blueAccent,
  fontSize: 15,
);

TextStyle sottotitoloOpaco = const TextStyle(
  fontWeight: FontWeight.w400,
  color: Colors.black54,
  fontSize: 15,
);

Widget customDivider() {
  return const Divider(indent: 16, endIndent: 16);
}
