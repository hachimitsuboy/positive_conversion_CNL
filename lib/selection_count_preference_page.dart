import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:positive_conversion_cnl/get_value_page.dart';

class SelectionCountPreferencePage extends StatefulWidget {
  final String inputWord;
  final List<String> inputWordSynonyms;

  SelectionCountPreferencePage({
    required this.inputWord,
    required this.inputWordSynonyms,
  });

  @override
  _SelectionCountPreferencePageState createState() =>
      _SelectionCountPreferencePageState();
}

class _SelectionCountPreferencePageState
    extends State<SelectionCountPreferencePage> {
  List<DropdownMenuItem<int>> _items = [];
  int _selectItem = 0;

  @override
  void initState() {
    super.initState();
    setItems();
    _selectItem = _items[0].value!;
  }

  void setItems() {
    _items
      ..add(
        DropdownMenuItem(
          child: Text(
            "1位",
            style: TextStyle(fontSize: 20),
          ),
          value: 1,
        ),
      )
      ..add(
        DropdownMenuItem(
          child: Text(
            "3位",
            style: TextStyle(fontSize: 20),
          ),
          value: 2,
        ),
      )
      ..add(
        DropdownMenuItem(
          child: Text(
            "5位",
            style: TextStyle(fontSize: 20),
          ),
          value: 3,
        ),
      )
      ..add(
        DropdownMenuItem(
          child: Text(
            "10位",
            style: TextStyle(fontSize: 20),
          ),
          value: 4,
        ),
      )
      ..add(
        DropdownMenuItem(
          child: Text(
            "30位",
            style: TextStyle(fontSize: 20),
          ),
          value: 5,
        ),
      );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("検索設定画面"),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          children: [
            SizedBox(
              height: 80,
            ),
            Text(
              "「${widget.inputWord}」の類語群の中から",
              style: TextStyle(fontSize: 20.0),
            ),
            SizedBox(
              height: 70.0,
            ),
            Text(
              "上位",
              style: TextStyle(fontSize: 25.0, fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 50,
            ),
            DropdownButton(
              items: _items,
              value: _selectItem,
              onChanged: (int? value) {
                setState(() {
                  _selectItem = value!;
                });
              },
            ),
            SizedBox(
              height: 160,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () => toGetValuePage(context),
                  child: Text(
                    "ポジティブ類語検索",
                    style: TextStyle(fontSize: 17),
                  ),
                  style: ElevatedButton.styleFrom(
                    primary: Colors.lightGreen,
                    onPrimary: Colors.white,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  toGetValuePage(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => GetValuePage(
          resultWords: widget.inputWordSynonyms,
          selectedValue: _selectItem,
        ),
      ),
    );
  }
}
