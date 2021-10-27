import 'package:flutter/material.dart';
import 'package:positive_conversion_cnl/data_class/score_data.dart';
import 'package:positive_conversion_cnl/home_screen.dart';

class SelectedOtherPage extends StatelessWidget {
  final List<ScoreData> scoreList;
  final int selectedValue;

  SelectedOtherPage({required this.scoreList, required this.selectedValue});

  @override
  Widget build(BuildContext context) {
    late int itemCount;

    switch (selectedValue) {
      case 2:
        itemCount = 3;
        break;
      case 3:
        itemCount = 5;
        break;
      case 4:
        itemCount = 10;
        break;
      case 5:
        itemCount = 30;
        break;
    }

    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        SizedBox(
          height: 25.0,
        ),
        Text(
          "上位$itemCount件",
          style: TextStyle(
              fontSize: 22.0,
              fontWeight: FontWeight.w600,
              color: Colors.lightGreen),
        ),
        SizedBox(
          height: 30.0,
        ),
        //ColumnのなかにListView.builderを入れる場合
        LimitedBox(
          maxHeight: 350,
          child: ListView.builder(
            itemCount: itemCount,
            itemBuilder: (BuildContext context, int index) {
              return SizedBox(
                height: 65.0,
                child: Card(
                  elevation: 25.0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                  color: Colors.lightGreen,
                  child: ListTile(
                    leading: Text(
                      (index + 1).toString(),
                      style: TextStyle(fontSize: 22.0, color: Colors.white),
                    ),
                    title: Padding(
                      padding: const EdgeInsets.only(top: 3.0),
                      child: Text(
                        scoreList[(scoreList.length - (index + 1))].synonym,
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                    subtitle: Padding(
                      padding: const EdgeInsets.only(bottom: 15.0),
                      child: Text(
                        "score: ${scoreList[(scoreList.length - (index + 1))].score.toString()}",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                ),
              );
            },
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

  toNextPage(BuildContext context) {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => HomeScreen(),
      ),
    );
  }
}
