import 'package:flutter/material.dart';
import 'package:positive_conversion_cnl/get_value_page.dart';
import 'package:positive_conversion_cnl/parts/wordCard.dart';
import 'package:http/http.dart' as http;
import 'package:html/parser.dart' show parse;
import 'package:positive_conversion_cnl/selection_count_preference_page.dart';

class CreateTilePage extends StatefulWidget {
  final String word;

  CreateTilePage({required this.word});

  @override
  _CreateTilePageState createState() => _CreateTilePageState();
}

class _CreateTilePageState extends State<CreateTilePage> {
  String title = "";
  String url = "";
  String searchWord = "";
  Uri target = Uri();

  List<String> _result = [];

  @override
  void initState() {
    super.initState();
    url = "https://renso-ruigo.com/word/";
    searchWord = widget.word;
    url = url + searchWord;
    target = Uri.parse(url);
    print("URL: $target");

    _getWord();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          title,
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Center(
        child: _result.isNotEmpty
            ? WordCard(
                resultList: _result,
              )
            : CircularProgressIndicator(),
      ),
      floatingActionButton: FloatingActionButton(
        elevation: 20.0,
        tooltip: "最もポジティブ値が高い類語を調べる",
        child: Icon(
          Icons.search,
          color: Colors.white,
        ),
        onPressed: () => _getValuePage(context),
      ),
    );
  }

  _getWord() async {
    print("getWord start");
    print("target: $target");
    final response = await http.get(target);
    print("response:$response");

    // 下の行のコメントを外すことで、返されたHTMLを出力できる。

    // ステータスコードをチェックする。「200 OK」以外のときはその旨を表示して終了する。
    if (response.statusCode != 200) {
      print('ERROR: ${response.statusCode}');
      return;
    }

    final document = parse(response.body);
    var getSynonyms = document
        .querySelectorAll("#ruigogun_paragraph-1 > a ")
        .map((e) => e.text)
        .toList();

    if (getSynonyms.length == 0) {
      //#content > div.main_word_table_set.view_mode_no_member > div > div.word_t_field.view_mode_no_member > div > a:nth-child(2)
      getSynonyms = document
          .querySelectorAll(" div.word_t_field.view_mode_no_member > div > a ")
          .map((e) => e.text)
          .toList();

      print("getSynonyms: $getSynonyms");
    }

    setState(() {
      _result = getSynonyms;
      title = "${widget.word}の類語: 合計 ${_result.length.toString()} 語";
    });
  }

  _getValuePage(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => SelectionCountPreferencePage(
          inputWordSynonyms: _result,
          inputWord: widget.word,
        ),
      ),
    );
  }
}
