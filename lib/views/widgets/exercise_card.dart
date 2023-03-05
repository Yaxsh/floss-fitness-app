import 'package:flutter/material.dart';

import '../pages/edit_exercise_page.dart';

class ExerciseCard extends StatefulWidget {
  const ExerciseCard({Key? key, required this.name, required this.isCompound, required this.exerciseId, required this.updateExerciseCard}) : super(key: key);

  //todo: replace with Exercise model
  final String name;
  final bool isCompound;
  final int exerciseId;

  final Function updateExerciseCard;

  @override
  State<ExerciseCard> createState() => _ExerciseCardState();
}

class _ExerciseCardState extends State<ExerciseCard> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        //todo: replace with pushNamed
        await Navigator.of(context).push(MaterialPageRoute(builder: (context) =>
            EditExercisePage(
                exerciseName: widget.name,
                isCompound: widget.isCompound,
                exerciseId:  widget.exerciseId
            )));
        widget.updateExerciseCard();
      },
      child: Container(
        color: widget.isCompound ? Colors.blue : Colors.red,
        margin: const EdgeInsets.fromLTRB(5, 10, 5, 0),
        //todo: add GestureDetector for Row
        child: Row(
          children: [
            Text(widget.name),
          ],
        ),
      ),
    );
  }
}
