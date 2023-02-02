import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../bloc/controller/workout_bloc.dart';
import '../../bloc/state/workout_state.dart';

class SetRow extends StatefulWidget {
  //todo: add reps and weight
  SetRow({Key? key, required this.setId, required this.reps, required this.weight}) : super(key: key);

  final int setId;
  late int reps;
  late int weight;

  @override
  State<SetRow> createState() => _SetRowState();
}

class _SetRowState extends State<SetRow> {
  TextEditingController repsTextController = TextEditingController();
  TextEditingController weightTextController = TextEditingController();
  
  @override
  void initState(){
    super.initState();
    weightTextController.addListener(_modifySetFromWorkingExercise);
    weightTextController.text = widget.weight != 0 ? widget.weight.toString() : "";
    repsTextController.addListener(_modifySetFromWorkingExercise);
    repsTextController.text = widget.reps != 0 ? widget.reps.toString() : "";
  }

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
              controller: weightTextController,
              keyboardType: TextInputType.number
            ),
          ),
          const Text("  kg  x ", style: TextStyle(fontWeight: FontWeight.bold)),
          SizedBox(
            width: 35,
            child: TextField(
                controller: repsTextController,
                keyboardType: TextInputType.number
            ),
          ),
          const Text("  reps.", style: TextStyle(fontWeight: FontWeight.bold)),
          Padding(padding: EdgeInsets.only(right: 25)),
          ElevatedButton(onPressed: () {
            BlocProvider.of<WorkoutBloc>(context).add(
                EndSetFromWorkingExerciseEvent(
                    eventType: EventType.endSetFromWorkingExercise,
                    reps:int.parse(repsTextController.text),
                    weight: int.parse(weightTextController.text),
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
    repsTextController.dispose();
    weightTextController.dispose();
    super.dispose();
  }

  void _modifySetFromWorkingExercise(){
    BlocProvider.of<WorkoutBloc>(context).add(
        ModifySetFromWorkingExerciseEvent(
            eventType: EventType.modifySetFromWorkingExercise,
            reps: _isNumeric(repsTextController.text) ? int.parse(repsTextController.text) : 0,
            weight: _isNumeric(weightTextController.text) ? int.parse(weightTextController.text) : 0,
            setId: widget.setId
        )
    );
  }

  bool _isNumeric(String? s) {
    //todo: put in some util class
    if (s == null) {
      return false;
    }
    return double.tryParse(s) != null;
  }
}
