// PACKAGE
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher_string.dart';

import 'class.dart';
import 'method.dart';
import 'provider.dart';
import 'widget.dart';



// SCREEN
class BookScreen extends StatelessWidget {

  // CONSTRUCTOR
  const BookScreen (this.book, {super.key});

  // PROPERTY
  final BookClass book;

  // METHOD
  Color _addColor (int answers, int corrects) {
    if (answers > 0) {
      final value = corrects / answers;

      if (value > 0.9) {
        return Colors.green;
      } else if (value > 0.7) {
        return Colors.orange;
      } else {
        return Colors.red;
      }
    } else {
      return Colors.grey;
    }
  }



  // MAIN
  @override
  Widget build (BuildContext context) => Scaffold (
    appBar: AppBar (
      actions: [if (book.vocabularies.isNotEmpty) Padding (
        padding: EdgeInsets.only (right: MediaQuery.of (context).size.width * 0.05),
        child: GestureDetector (
          onTap: () => Navigator.of (context).pushNamed ('/test', arguments: TestClass ([], book, List.generate (book.vocabularies.length, (int i) => i)..shuffle ())),
          child: Icon (Icons.play_arrow_rounded, size: addSize (context) * 1.125),
        ),
      )],
      leading: GestureDetector (
        onTap: () => Navigator.of (context).pop (),
        child: Icon (Icons.arrow_back, size: addSize (context) * 1.125),
      ),
      title: SubTitle ('last: ${DateFormat.yMMMMd ().format (DateTime.fromMillisecondsSinceEpoch (book.second))}', book.title),
    ),
    body: ListView (children: [
      for (final vocabulary in book.vocabularies) Dismissible (
        key: Key (vocabulary.word),
        child: ListTile (
          contentPadding: EdgeInsets.symmetric (horizontal: MediaQuery.of (context).size.width * 0.05),
          onTap: () => showSheet (context, vocabulary, Text ('${vocabulary.corrects}/${vocabulary.answers}',
            textScaleFactor: 0.75,
            style: GoogleFonts.notoSans (
              color: Colors.grey,
              fontSize: addSize (context),
            ),
          ),),
          title: Text (vocabulary.word,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            textScaleFactor: 1,
            style: TextStyle (
              color: Colors.black,
              fontSize: addSize (context),
            ),
          ),
          trailing: Icon (Icons.brightness_1,
            color: _addColor (vocabulary.answers, vocabulary.corrects),
            size: addSize (context) * 0.75,
          ),
        ),
      ),
      const ListTile (),
    ],),
  );
}

class HomeScreen extends StatelessWidget {

  // CONSTRUCTOR
  const HomeScreen ({super.key});



  // MAIN
  @override
  Widget build (BuildContext context) => Consumer <DatabaseProvider> (builder: (_, DatabaseProvider provider, __) => Scaffold (
    appBar: AppBar (
      automaticallyImplyLeading: false,
      centerTitle: false,
      title: Text ('WORDBOOK',
        style: TextStyle (fontSize: addSize (context)),
        textScaleFactor: 1.25,
      ),
    ),
    body: ListView (children: [
      for (final book in provider.books) Dismissible (
        key: Key (book.title),
        child: ListTile (
          contentPadding: EdgeInsets.symmetric (horizontal: MediaQuery.of (context).size.width * 0.05),
          onTap: () => Navigator.of (context).pushNamed ('/book', arguments: book),
          title: Text (book.title,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            textScaleFactor: 1,
            style: TextStyle (
              color: Colors.black,
              fontSize: addSize (context),
              fontWeight: FontWeight.bold,
            ),
          ),
          trailing: Text ('${book.vocabularies.length} words',
            maxLines: 1,
            textScaleFactor: 0.75,
            style: TextStyle (
              color: Colors.grey,
              fontSize: addSize (context),
            ),
          ),
        ),
      ),
      const ListTile (),
      Container (
        alignment: Alignment.center,
        color: Colors.black,
        padding: EdgeInsets.all (MediaQuery.of (context).size.width * 0.05),
        child: Text.rich (TextSpan (children: [
          TextSpan (text: '\u00a9KEITA FUJIYAMA ${DateTime.now ().year}  |  '),
          TextSpan (
            text: 'LICENCE',
            recognizer: TapGestureRecognizer ()..onTap = () => PackageInfo.fromPlatform ().then ((PackageInfo package) => showLicensePage (
              applicationName: 'WORDBOOK',
              applicationLegalese: 'KEITA FUJIYAMA',
              applicationVersion: package.version,
              context: context,
            ),),
          ),
          const TextSpan (text: '  |  '),
          TextSpan (
            recognizer: TapGestureRecognizer ()..onTap = () => launchUrlString ('https://github.com/keitafujiyama/wordbook-dart'),
            text: 'REPOSITORY',
          ),
        ],),
          textScaleFactor: 0.5,
          style: TextStyle (
            color: Colors.white,
            fontSize: addSize (context),
          ),
        ),
      ),
    ],),
  ),);
}

class ResultScreen extends StatelessWidget {

  // CONSTRUCTOR
  const ResultScreen (this.test, {super.key});

  // PROPERTY
  final TestClass test;



  // MAIN
  @override
  Widget build (BuildContext context) => Consumer <DatabaseProvider> (builder: (_, DatabaseProvider provider, __) {
    return Scaffold (
      appBar: AppBar (
        leading: GestureDetector (
          onTap: () => Navigator.of (context).maybePop ().whenComplete (() => Navigator.of (context).pushReplacementNamed ('/home')),
          child: Icon (Icons.clear_rounded, size: addSize (context) * 1.125),
        ),
        title: Text ('RESULT',
          style: TextStyle (fontSize: addSize (context)),
          textScaleFactor: 1.125,
        ),
      ),
      body: ListView (children: [
        const ListTile (dense: true),
        Padding (
          padding: EdgeInsets.symmetric (horizontal: MediaQuery.of (context).size.width * 0.05),
          child: Stack (
            alignment: Alignment.center,
            children: [
              CircularPercentIndicator (
                animation: true,
                animationDuration: 1000,
                backgroundColor: Colors.transparent,
                circularStrokeCap: CircularStrokeCap.round,
                curve: Curves.easeIn,
                lineWidth: MediaQuery.of (context).size.shortestSide * 0.05,
                percent: test.answers.where ((bool value) => value == true).length / test.answers.length,
                radius: MediaQuery.of (context).size.shortestSide * 0.25,
              ),
              Icon (Icons.check_circle_rounded,
                color: Theme.of (context).primaryColor,
                size: MediaQuery.of (context).size.shortestSide * 0.5,
              ),
            ],
          ),
        ),
        Padding (
          padding: EdgeInsets.symmetric (horizontal: MediaQuery.of (context).size.width * 0.05),
          child: Column (
            mainAxisSize: MainAxisSize.min,
            children: [
              Text ('${((test.answers.where ((bool value) => value == true).length / test.answers.length) * 100).toStringAsFixed (2)}%',
                textScaleFactor: 2,
                style: GoogleFonts.notoSans (
                  color: Colors.black,
                  fontSize: addSize (context),
                  fontWeight: FontWeight.w900,
                ),
              ),
              Text ('${test.answers.where ((bool value) => value == true).length} / ${test.answers.length}',
                maxLines: 1,
                textScaleFactor: 1,
                style: GoogleFonts.notoSans (
                  color: Colors.grey,
                  fontSize: addSize (context),
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
        const ListTile (),
        for (int i = 0; i < test.answers.length; i ++) ListTile (
          contentPadding: EdgeInsets.symmetric (horizontal: MediaQuery.of (context).size.width * 0.05),
          onTap: () => showSheet (context, test.book.vocabularies [test.orders [i]], AnswerIcon (test.answers [i])),
          leading: Text ((i + 1).toString (),
            maxLines: 1,
            textScaleFactor: 0.75,
            style: GoogleFonts.notoSans (
              color: Colors.grey,
              fontSize: addSize (context),
              fontWeight: FontWeight.bold,
            ),
          ),
          title: Text (test.book.vocabularies [test.orders [i]].word,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            textScaleFactor: 1,
            style: TextStyle (
              color: Colors.black,
              fontSize: addSize (context),
              fontWeight: test.answers [i] ? FontWeight.normal : FontWeight.bold,
            ),
          ),
          trailing: AnswerIcon (test.answers [i]),
        ),
        const ListTile (),
      ],),
    );
  },);
}

class SplashScreen extends StatefulWidget {

  // CONSTRUCTOR
  const SplashScreen ({super.key});



  // MAIN
  @override
  State <SplashScreen> createState () => _SplashScreenState ();
}
class _SplashScreenState extends State <SplashScreen> {

  @override
  void initState () {
    super.initState ();

    Future <void>.delayed (const Duration (seconds: 1), () => Navigator.of (context).pushReplacementNamed ('/home'));
  }

  @override
  Widget build (_) => Scaffold (
    backgroundColor: Theme.of (context).primaryColor,
    floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    body: Center (child: Column (
      mainAxisSize: MainAxisSize.min,
      children: [
        Text ('WORDBOOK',
          textScaleFactor: 1.25,
          style: GoogleFonts.notoSans (
            color: Colors.white,
            fontSize: addSize (context),
            fontWeight: FontWeight.bold,
          ),
        ),
        const ListTile (dense: true),
        Icon (Icons.stay_current_portrait_rounded,
          color: Colors.white,
          size: addSize (context) * 2.5,
        ),
        Text ('portrait',
          textScaleFactor: 1,
          style: GoogleFonts.notoSans (
            color: Colors.white,
            fontSize: addSize (context),
          ),
        ),
      ],
    ),),
    floatingActionButton: Text ('KEITA FUJIYAMA',
      textAlign: TextAlign.center,
      textScaleFactor: 0.75,
      style: GoogleFonts.notoSans (
        color: Colors.white,
        fontSize: addSize (context),
      ),
    ),
  );
}

class TestScreen extends StatefulWidget {

  // CONSTRUCTOR
  const TestScreen (this.test, {super.key});

  // PROPERTY
  final TestClass test;



  // MAIN
  @override
  State <TestScreen> createState () => _TestScreenState ();
}
class _TestScreenState extends State <TestScreen> {

  // PROPERTY
  bool _isAnswered = false;
  bool _isOpened = false;
  final FlutterTts _speech = FlutterTts ();



  // MAIN
  @override
  Widget build (_) => Scaffold (
    appBar: AppBar (
      leading: GestureDetector (
        onTap: () => widget.test.answers.isNotEmpty ? Navigator.of (context).pushReplacementNamed ('/result', arguments: widget.test) : Navigator.of (context).maybePop ().whenComplete (() => Navigator.of (context).pushReplacementNamed ('/home')),
        child: Icon (Icons.clear_rounded, size: addSize (context) * 1.125),
      ),
      title: SubTitle ('/ ${widget.test.book.vocabularies.length}', '${widget.test.book.title.toUpperCase ()} #${widget.test.answers.length + 1}'),
    ),
    body: ListView (
      padding: EdgeInsets.symmetric (horizontal: MediaQuery.of (context).size.width * 0.125),
      children: [
        AspectRatio (
          aspectRatio: 1 / 1,
          child: FittedBox (child: Text (widget.test.book.vocabularies [widget.test.orders [widget.test.answers.length]].word,
            textAlign: TextAlign.center,
            style: GoogleFonts.notoSans (
              color: Colors.black,
              fontWeight: FontWeight.w900,
            ),
          ),),
        ),
        if (widget.test.book.vocabularies [widget.test.orders [widget.test.answers.length]].hint.isNotEmpty) GestureDetector (
          onTap: () => setState (() => _isOpened = true),
          child: Container (
            padding: EdgeInsets.all (MediaQuery.of (context).size.shortestSide * 0.05),
            decoration: BoxDecoration (
              borderRadius: const BorderRadius.all (Radius.circular (2.5)),
              color: Colors.grey.withOpacity (0.25),
            ),
            child: Stack (
              alignment: Alignment.center,
              children: [
                Text (widget.test.book.vocabularies [widget.test.orders [widget.test.answers.length]].hint,
                  textScaleFactor: 0.75,
                  style: TextStyle (
                    color: _isOpened ? Colors.black : Colors.transparent,
                    fontSize: addSize (context),
                  ),
                ),
                if (!_isOpened) Text ('HINT',
                  textScaleFactor: 0.75,
                  style: GoogleFonts.notoSans (
                    color: Colors.black,
                    fontSize: addSize (context),
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ),
        const ListTile (dense: true),
        GestureDetector (
          onTap: () => setState (() {
            _isAnswered = !_isAnswered;
            _isOpened = true;
          }),
          child: Column (
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text ('ANSWER',
                textScaleFactor: 0.625,
                style: GoogleFonts.notoSans (
                  color: Theme.of (context).primaryColor,
                  fontSize: addSize (context),
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text (widget.test.book.vocabularies [widget.test.orders [widget.test.answers.length]].description,
                textScaleFactor: 0.75,
                style: TextStyle (
                  color: _isAnswered ? Colors.black : Colors.transparent,
                  fontSize: addSize (context),
                ),
              ),
            ],
          ),
        ),
        Center (child: Icon (Icons.arrow_drop_down,
          color: Colors.grey,
          size: addSize (context),
        ),),
        const ListTile (),
      ],
    ),
    bottomNavigationBar: BottomNavigationBar (
      backgroundColor: Colors.grey.shade100,
      currentIndex: 1,
      elevation: double.minPositive,
      iconSize: addSize (context) * 1.25,
      selectedItemColor: _isAnswered ? Theme.of (context).primaryColor : Colors.grey,
      unselectedItemColor: _isAnswered ? Colors.black : Colors.grey,
      items: const [
        BottomNavigationBarItem (
          icon: Icon (Icons.highlight_off_rounded),
          label: 'INCORRECT',
        ), BottomNavigationBarItem (
          icon: Icon (Icons.check_circle_outline_rounded),
          label: 'CORRECT',
        ),
      ],
      onTap: (int i) {
        if (_isAnswered) {
          final test = TestClass (widget.test.answers..add (i == 1), widget.test.book, widget.test.orders);

          if (test.answers.length == test.book.vocabularies.length) {
            Navigator.of (context).pushReplacementNamed ('/result', arguments: test);
          } else {
            Navigator.of (context).pushReplacementNamed ('/test', arguments: test);
          }
        }
      },
      selectedLabelStyle: GoogleFonts.notoSans (
        fontSize: addSize (context) * 0.5,
        fontWeight: FontWeight.bold,
      ),
      unselectedLabelStyle: GoogleFonts.notoSans (
        fontSize: addSize (context) * 0.5,
        fontWeight: FontWeight.bold,
      ),
    ),
    floatingActionButton: FloatingActionButton (
      backgroundColor: Theme.of (context).scaffoldBackgroundColor,
      elevation: 10,
      foregroundColor: Colors.black,
      onPressed: () => _speech.speak (widget.test.book.vocabularies [widget.test.orders [widget.test.answers.length]].word),
      child: Icon (Icons.volume_up_rounded, size: addSize (context)),
    ),
  );
}
