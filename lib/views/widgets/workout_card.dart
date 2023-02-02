import 'package:floss_fitness_app/data/models/workout.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class WorkoutCard extends StatefulWidget {
  const WorkoutCard({Key? key, required this.workout}) : super(key: key);

  final Workout workout;

  @override
  State<WorkoutCard> createState() => _WorkoutCardState();
}

class _WorkoutCardState extends State<WorkoutCard> {

  Workout? workout;
  //"${widget.workout.startDateTime.day}-${widget.workout.startDateTime.month}-${widget.workout.startDateTime.year}"

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      //todo: open specific workout stats page
      onTap: (){print("Clicked workout with id: ${widget.workout.id}!!");},
      child: Container(
        margin: const EdgeInsets.fromLTRB(5, 10, 5, 0),
        color: Colors.grey,
        child: Column(
          children: [
            //todo: replace values with workout model values after reading from DB and initializing
            Text(DateFormat('dd-MM-yyyy').format(widget.workout.startDateTime), style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),),
            Divider(color: Colors.black, height: 5),
            Row(
              children: [
                //todo: fix abomination
                Text(widget.workout.endDateTime?.difference(widget.workout.startDateTime).inSeconds.toString() ?? "LEL", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),),
                const Text(" seconds TODO", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15))
              ],
            )
          ],
        ),
      ),
    );
  }
}
