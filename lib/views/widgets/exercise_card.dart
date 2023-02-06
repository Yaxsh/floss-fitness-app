import 'package:flutter/material.dart';

class ExerciseCard extends StatefulWidget {
  const ExerciseCard({Key? key, required this.name, required this.isCompound}) : super(key: key);

  final String name;
  final bool isCompound;

  @override
  State<ExerciseCard> createState() => _ExerciseCardState();
}

class _ExerciseCardState extends State<ExerciseCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.grey,
      margin: const EdgeInsets.fromLTRB(5, 10, 5, 0),
      //todo: add GestureDetector for Row
      child: Row(
        children: [
          Text(widget.name),
          //todo: replace with marker for compound
          widget.isCompound ? Text(" XD") : Text("")
        ],
      ),
    );
  }
}
