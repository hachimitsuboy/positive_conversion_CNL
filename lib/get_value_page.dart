import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:positive_conversion_cnl/data_class/score_data.dart';
import 'package:positive_conversion_cnl/selected_one_page.dart';
import 'package:positive_conversion_cnl/selected_other_page.dart';

class GetValuePage extends StatefulWidget {
  final List<String> resultWords;
  final int selectedValue;

  GetValuePage({
    required this.resultWords,
    required this.selectedValue,
  });

  @override
  _GetValuePageState createState() => _GetValuePageState();
}

class _GetValuePageState extends State<GetValuePage> {
  List<ScoreData> scoreList = [];
  double maxScore = -2.0;
  String maxScoreWord = "";

  @override
  void initState() {
    super.initState();
    _getValue(widget.resultWords, widget.selectedValue);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "計算結果",
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
      ),
      body: (scoreList.isEmpty)
          ? Center(
              child: CircularProgressIndicator(),
            )
          : (widget.selectedValue == 1)
              ? Center(
                  child: SelectedOnePage(
                    scoreList: scoreList,
                    selectedValue: widget.selectedValue,
                  ),
                )
              : SelectedOtherPage(
                  scoreList: scoreList,
                  selectedValue: widget.selectedValue,
                ),
    );
  }

  //各類語ごとにポジティブ値を計測する
  void _getValue(List<String> resultWords, int selectedValue) async {
    print("GetValue Start");
    String apiKey = "AIzaSyB33dqHKAzR-2jQ9lqAMQMGdDTnummwGNc";
    String urlString =
        "https://language.googleapis.com/v1/documents:analyzeSentiment?key=$apiKey";
    Uri uri = Uri.parse(urlString);

    for (int i = 0; i < 30; i++) {
      String text = resultWords[i];

      Map<String, String> headers = {"content-type": "application/json"};
      String body = json.encode({
        "document": {"type": "PLAIN_TEXT", "language": "JA", "content": text}
      });
      var res = await http.post(uri, headers: headers, body: body);
      var resultBody = json.decode(res.body);
      var resultScore = resultBody["documentSentiment"]["score"];

      var scoreData =
          ScoreData(synonym: text, score: double.parse(resultScore.toString()));
      scoreList.add(scoreData);
    }

    print("maxScoreWord: $maxScoreWord / maxScore: $maxScore");

    //ソート(末尾に最大値が入る）
    scoreList.sort((a, b) => a.score.compareTo(b.score));
    scoreList.forEach((element) {
      print("word; ${element.synonym} / score: ${element.score}");
    });

    maxScore = scoreList[scoreList.length - 1].score;
    maxScoreWord = scoreList[scoreList.length - 1].synonym;

    setState(() {});
  }
}
