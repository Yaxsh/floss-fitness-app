import 'package:floss_fitness_app/data/models/workout.dart';
import 'package:floss_fitness_app/views/pages/workout_details_page.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class WorkoutCard extends StatefulWidget {
  WorkoutCard({Key? key, required this.workout, required this.deleteWorkoutFunction, required this.indexInHomePage}) : super(key: key);

  final Workout workout;
  final Function deleteWorkoutFunction;
  final int indexInHomePage;
  bool isDeleted = false;
  changeFlagFunction() {isDeleted = true; debugPrint('calling changeFlagFunction');}

  @override
  State<WorkoutCard> createState() => _WorkoutCardState();
}

class _WorkoutCardState extends State<WorkoutCard> {

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        debugPrint("Clicked workout with id: ${widget.workout.id}!!");
        //todo: replace with pushNamed
        await Navigator.of(context).push(MaterialPageRoute(builder: (context) => WorkoutDetailsPage(workout: widget.workout, deleteWorkoutFunction: widget.changeFlagFunction)));
        if(widget.isDeleted){
          debugPrint('calling deleteWorkoutFunction is card');
          widget.deleteWorkoutFunction(widget.indexInHomePage);
        }
      },
      child: Container(
        margin: const EdgeInsets.fromLTRB(5, 10, 5, 0),
        color: Colors.grey,
        child: Column(
          children: [
            Text(DateFormat('dd-MM-yyyy').format(widget.workout.startDateTime), style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),),
            const Divider(color: Colors.black, height: 5),
            Row(
              children: [
                //todo: fix abomination
                Text(widget.workout.endDateTime?.difference(widget.workout.startDateTime).inMinutes.toString() ?? "LEL", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),),
                const Text(" minutes", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15))
              ],
            )
          ],
        ),
      ),
    );
  }
}
