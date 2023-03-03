import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../bloc/controller/workout_bloc.dart';
import '../../bloc/state/workout_state.dart';

class SetRow extends StatefulWidget {
  //todo: add reps and weight
  SetRow({Key? key, required this.setId, required this.reps, required this.weight, required this.isEnded}) : super(key: key);

  final int setId;
  late int reps;
  late int weight;
  bool isEnded;

  @override
  State<SetRow> createState() => _SetRowState();
}

class _SetRowState extends State<SetRow> {
  final _formKey = GlobalKey<FormState>();
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
      child: Form(
        key: _formKey,
        child: Row(
          children: [
            //todo: replace with Expanded/Flexible
            const Padding(padding: EdgeInsets.only(right: 5)),
            SizedBox(
              width: 40,
              child: TextFormField(
                enabled: !widget.isEnded,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "";
                  }
                  return null;
                },
                controller: weightTextController,
                keyboardType: TextInputType.number
              ),
            ),
            const Text("  kg  x ", style: TextStyle(fontWeight: FontWeight.bold)),
            SizedBox(
              width: 40,
              child: TextFormField(
                  enabled: !widget.isEnded,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "";
                    }
                    return null;
                  },
                  controller: repsTextController,
                  keyboardType: TextInputType.number
              ),
            ),
            const Text("  reps.", style: TextStyle(fontWeight: FontWeight.bold)),
            const Padding(padding: EdgeInsets.only(right: 25)),
            ElevatedButton(
              onPressed: widget.isEnded ? null : endSet,
              child: const Text("end set"))
          ],
        ),
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

  endSet () {
    if(_formKey.currentState!.validate()){
      BlocProvider.of<WorkoutBloc>(context).add(
          EndSetFromWorkingExerciseEvent(
              eventType: EventType.endSetFromWorkingExercise,
              reps:int.parse(repsTextController.text),
              weight: int.parse(weightTextController.text),
              setId: widget.setId
          ));
      widget.isEnded = true;
      setState(() {});
    }
  }
}
