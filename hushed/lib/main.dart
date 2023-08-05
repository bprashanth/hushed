import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:epub_parser/epub_parser.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  // This widget is the root of the application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String assetPath = "assets/florida.epub";

  void _pressed() {}

  Widget getWidget(EpubBook? book) {
    String author = 'none';
    if (book != null && book.Author?.length != 0) {
      author = book.Author!;
    }
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'The author of the ebook is:',
            ),
            Text(author),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _pressed,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called.
    return FutureBuilder(
        future: EPub.read(assetPath),
        builder: (BuildContext context, AsyncSnapshot<EpubBook> bookSnapshot){
          return getWidget(bookSnapshot.data);
        });
  }
}

class EPub {
  static Future<EpubBook> read(String filePath) async {
    ByteData data = await rootBundle.load(filePath);
    return await EpubReader.readBook(data.buffer.asUint8List());
  }
}
