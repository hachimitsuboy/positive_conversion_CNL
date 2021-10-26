import 'package:flutter/material.dart';

class WordCard extends StatelessWidget {
  final List<String> resultList;

  WordCard({
    required this.resultList,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: resultList.length,
      itemBuilder: (BuildContext context, int index) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            elevation: 20,
            color: Colors.white70,
            child: ListTile(
              leading: Text(
                (index + 1).toString(),
                style: TextStyle(fontSize: 22),
              ),
              title: Text(resultList[index]),
            ),
          ),
        );
      },
    );
  }
}
