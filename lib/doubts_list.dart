import 'package:flutter/material.dart';
import 'package:mentor_mate/components/doubt_card.dart';

class DoubtPage extends StatefulWidget {
  @override
  _DoubtPageState createState() => _DoubtPageState();
}

class _DoubtPageState extends State<DoubtPage> {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
          itemCount: 1,
          itemBuilder: (BuildContext context, index) {
            return Doubts();
          }),
    );
  }
}
