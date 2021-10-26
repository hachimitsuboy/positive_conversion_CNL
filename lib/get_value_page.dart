import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:positive_conversion_cnl/data_class/score_data.dart';
import 'package:positive_conversion_cnl/home_screen.dart';

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
          title: Text("計算結果"),
          centerTitle: true,
        ),
        body: (scoreList.isEmpty)
            ? Center(
                child: CircularProgressIndicator(),
              )
            : Center(
                child: Column(
                  children: [
                    SizedBox(
                      height: 38,
                    ),
                    Text(
                      "最もポジティブ値の高い用語",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w200,
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Text(
                      (maxScoreWord != "")
                          ? "「$maxScoreWord」" //TODO
                          : "0を超えるポジティブ値をもつ類語が見つかりませんでした",
                      style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(
                      height: 55,
                    ),
                    Center(
                      child: Stack(
                        children: [
                          Center(
                            child: Container(
                              width: 200,
                              height: 200,
                              decoration: const BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.lightGreen,
                              ),
                            ),
                          ),
                          Center(
                            child: Column(
                              children: [
                                SizedBox(
                                  height: 32.0,
                                ),
                                Text(
                                  "ポジティブ値",
                                  style: TextStyle(
                                      fontSize: 20.0, color: Colors.white),
                                ),
                                SizedBox(
                                  height: 40,
                                ),
                                Text(
                                  (maxScoreWord != "")
                                      ? maxScore.toString()
                                      : "0",
                                  style: TextStyle(
                                      fontSize: 32.0, color: Colors.white),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 100,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          //TODO
                          onPressed: () => toNextPage(context),
                          child: Text("トップへ戻る"),
                          style: ElevatedButton.styleFrom(
                            primary: Colors.lightGreen,
                            onPrimary: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ));
  }

  //各類語ごとにポジティブ値を計測する
  void _getValue(List<String> resultWords, int selectedValue) async {
    print("GetValue Start");
    String apiKey = "AIzaSyB33dqHKAzR-2jQ9lqAMQMGdDTnummwGNc";
    String urlString =
        "https://language.googleapis.com/v1/documents:analyzeSentiment?key=$apiKey";
    Uri uri = Uri.parse(urlString);

    for (int i = 0; i < 10; i++) {
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

  toNextPage(BuildContext context) {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => HomeScreen(),
      ),
    );
  }
}
