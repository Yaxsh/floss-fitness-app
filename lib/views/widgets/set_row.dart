import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../bloc/controller/workout_bloc.dart';
import '../../bloc/state/workout_state.dart';

class SetRow extends StatefulWidget {
  //todo: add reps and weight
  SetRow({Key? key, required this.setId}) : super(key: key);

  final int setId;

  @override
  State<SetRow> createState() => _SetRowState();
}

class _SetRowState extends State<SetRow> {
  TextEditingController repsTextEditingController = TextEditingController();
  TextEditingController weightTextEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocListener<WorkoutBloc, WorkoutState>(
      listener: (context, state) {},
      child: Row(
        children: [
          //todo: replace with Expanded/Flexible
          Padding(padding: EdgeInsets.only(right: 5)),
          SizedBox(
            width: 35,
            child: TextField(
              controller: weightTextEditingController,
              keyboardType: TextInputType.number,
            ),
          ),
          const Text("  kg  x ", style: TextStyle(fontWeight: FontWeight.bold)),
          SizedBox(
            width: 35,
            child: TextField(
                controller: repsTextEditingController,
                keyboardType: TextInputType.number),
          ),
          const Text("  reps.", style: TextStyle(fontWeight: FontWeight.bold)),
          Padding(padding: EdgeInsets.only(right: 25)),
          ElevatedButton(onPressed: () {
            BlocProvider.of<WorkoutBloc>(context).add(
                EndSetFromWorkingExerciseEvent(
                    eventType: EventType.endSetFromWorkingExercise,
                    reps:int.parse(repsTextEditingController.text),
                    weight: int.parse(weightTextEditingController.text),
                    setId: widget.setId
                )
            );
          }, child: Text("end set"))
        ],
      ),
    );
  }

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    repsTextEditingController.dispose();
    weightTextEditingController.dispose();
    super.dispose();
  }
}
