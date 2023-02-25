import 'package:floss_fitness_app/data/models/workout.dart';
import 'package:floss_fitness_app/views/pages/workout_details_page.dart';
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
      onTap: (){
        debugPrint("Clicked workout with id: ${widget.workout.id}!!");
        //todo: replace with pushNamed
        Navigator.of(context).push(MaterialPageRoute(builder: (context) => WorkoutDetailsPage(workout: widget.workout)));
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
