// PACKAGE
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'method.dart';



// WIDGET
class AnswerIcon extends StatelessWidget {

  // CONSTRUCTOR
  const AnswerIcon (this.value, {super.key});

  // PROPERTY
  final bool value;



  // MAIN
  @override
  Widget build (BuildContext context) => Icon (value ? Icons.check_circle_outline_rounded : Icons.highlight_off_rounded,
    color: value ? Theme.of (context).primaryColor : Colors.black,
    size: addSize (context) * 0.75,
  );
}

class SheetTile extends StatelessWidget {

  // CONSTRUCTOR
  const SheetTile (this.object, this.subject, {super.key});

  // PROPERTY
  final String object;
  final String subject;



  // MAIN
  @override
  Widget build (BuildContext context) => Column (
    crossAxisAlignment: CrossAxisAlignment.start,
    mainAxisSize: MainAxisSize.min,
    children: [
      Text (subject,
        textScaleFactor: 0.5,
        style: GoogleFonts.notoSans (
          color: Theme.of (context).primaryColor,
          fontSize: addSize (context),
          fontWeight: FontWeight.bold,
        ),
      ),
      Text (object,
        textScaleFactor: 0.75,
        style: TextStyle (
          color: Colors.black,
          fontSize: addSize (context),
        ),
      ),
    ],
  );
}

class SubTitle extends StatelessWidget {

  // CONSTRUCTOR
  const SubTitle (this.bottom, this.top, {super.key});

  // PROPERTY
  final String bottom;
  final String top;



  // MAIN
  @override
  Widget build (BuildContext context) => Column (
    mainAxisSize: MainAxisSize.min,
    children: [
      Text (top.toUpperCase (),
        maxLines: 1,
        style: TextStyle (fontSize: addSize (context)),
        textScaleFactor: 1.125,
      ),
      Text (bottom.toLowerCase (),
        maxLines: 1,
        textScaleFactor: 0.625,
        style: TextStyle (
          color: Colors.grey,
          fontSize: addSize (context),
          fontWeight: FontWeight.bold,
        ),
      ),
    ],
  );
}
