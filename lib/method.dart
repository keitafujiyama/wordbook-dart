// PACKAGE
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:wordbook/widget.dart';

import 'class.dart';



// METHOD
double addSize (BuildContext context) {
  final size = MediaQuery.of (context).size;
  final average = (size.height + size.width) * 0.5;

  if (size.height > size.width * 1.5) {
    return average * 0.025;
  } else if (size.height > size.width) {
    return average * 0.02;
  } else {
    return average * 0.015;
  }
}

void showSheet (BuildContext context, VocabularyClass vocabulary, Widget widget) => showModalBottomSheet <void> (
  context: context,
  builder: (_) => SingleChildScrollView (child: Column (
    crossAxisAlignment: CrossAxisAlignment.start,
    mainAxisSize: MainAxisSize.min,
    children: [
      Padding (
        padding: EdgeInsets.all (MediaQuery.of (context).size.width * 0.05),
        child: Row (children: [
          Expanded (child: Text (vocabulary.word,
            textScaleFactor: 1,
            style: GoogleFonts.notoSans (
              color: Colors.black,
              fontSize: addSize(context),
              fontWeight: FontWeight.bold,
            ),
          ),),
          SizedBox (width: MediaQuery.of (context).size.shortestSide * 0.1),
          widget,
        ],),
      ),
      Container (
        color: Colors.grey.withOpacity (0.25),
        padding: EdgeInsets.all (MediaQuery.of (context).size.width * 0.05),
        width: double.maxFinite,
        child: SheetTile (vocabulary.hint, 'HINT'),
      ),
      Padding (
        padding: EdgeInsets.all (MediaQuery.of (context).size.width * 0.05),
        child: SheetTile (vocabulary.description, 'DESCRIPTION'),
      ),
      const ListTile (),
    ],
  ),),
);
