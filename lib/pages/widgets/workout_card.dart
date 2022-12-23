import 'package:floss_fitness_app/data/models/workout.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class WorkoutCard extends StatefulWidget {
  const WorkoutCard({Key? key}) : super(key: key);

  @override
  State<WorkoutCard> createState() => _WorkoutCardState();
}

class _WorkoutCardState extends State<WorkoutCard> {

  Workout? workout;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      //todo: open specific workout stats page
      onTap: (){print("Clicked workout!!");},
      child: Container(
        margin: const EdgeInsets.fromLTRB(5, 10, 5, 0),
        color: Colors.grey,
        child: Column(
          children: [
            //todo: replace values with workout model values after reading from DB and initializing
            Text("2022-12-23", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),),
            Divider(color: Colors.black, height: 5),
            Row(
              children: [
                Text("43min", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),)
              ],
            )
          ],
        ),
      ),
    );
  }
}
