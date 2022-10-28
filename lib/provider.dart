// PACKAGE
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'class.dart';




// PROVIDER
class DatabaseProvider with ChangeNotifier {

  // METHOD
  void readJson () => rootBundle.loadString ('asset/book.json').then ((String source1) {
    final dynamic source2 = json.decode (source1);

    books = List.generate ((source2 ['books'].length ?? 0) as int, (int i) => BookClass.fromMap (source2 ['books'][i] as Map <String, dynamic>));

    notifyListeners ();
  });

  // PROPERTY
  List <BookClass> books = [];
}
