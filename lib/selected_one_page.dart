import 'package:flutter/material.dart';
import 'package:positive_conversion_cnl/data_class/score_data.dart';
import 'package:positive_conversion_cnl/home_screen.dart';

class SelectedOnePage extends StatelessWidget {
  final List<ScoreData> scoreList;
  final int selectedValue;

  SelectedOnePage({required this.scoreList, required this.selectedValue});

  @override
  Widget build(BuildContext context) {
    return Column(
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
          (scoreList.isEmpty)
              ? "0を超えるポジティブ値をもつ類語が見つかりませんでした"
              : "「${scoreList[scoreList.length - 1].synonym}」",
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
                      (scoreList.isEmpty)
                          ? "測定不能"
                          : scoreList[scoreList.length -1].score.toString(),
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
          height: 80,
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
    );
  }
}

toNextPage(BuildContext context) {
  Navigator.pushReplacement(
    context,
    MaterialPageRoute(
      builder: (context) => HomeScreen(),
    ),
  );
}
