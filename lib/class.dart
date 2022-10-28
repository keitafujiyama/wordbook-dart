class BookClass {

  // CONSTRUCTOR
  BookClass (this.second, this.title, this.vocabularies);

  BookClass.fromMap (Map <String, dynamic> map) {
    second = (map ['second'] ?? 0) as int;
    title = (map ['title'] ?? '') as String;
    vocabularies = List.generate (map ['vocabularies'].length as int, (int i) => VocabularyClass.fromMap (map ['vocabularies'][i] as Map <String, dynamic>));
  }

  Map <String, dynamic> toMap () => <String, dynamic> {
    'second': second,
    'title': title,
  };

  // CONSTRUCTOR
  int second = 0;
  List <VocabularyClass> vocabularies = [];
  String title = '';
}

class TestClass {

  // CONSTRUCTOR
  const TestClass (this.answers, this.book, this.orders);

  // PROPERTY
  final BookClass book;
  final List <bool> answers;
  final List <int> orders;
}

class VocabularyClass {

  // CONSTRUCTOR
  VocabularyClass ();

  VocabularyClass.fromMap (Map <String, dynamic> map) {
    answers = (map ['answers'] ?? 0) as int;
    corrects = (map ['corrects'] ?? 0) as int;
    description = (map ['description'] ?? '') as String;
    hint = (map ['hint'] ?? '') as String;
    index = (map ['index'] ?? 0) as int;
    word = (map ['word'] ?? '') as String;
  }

  // PROPERTY
  String description = '';
  String hint = '';
  String word = '';
  int answers = 0;
  int corrects = 0;
  int index = 0;
}
