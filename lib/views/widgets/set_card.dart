import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:floss_fitness_app/bloc/state/workout_state.dart';
import 'package:floss_fitness_app/views/widgets/set_row.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../bloc/controller/workout_bloc.dart';
import '../../data/models/set.dart';

class SetCard extends StatefulWidget {
  SetCard({Key? key, required this.workingExerciseId}) : super(key: key);

  final int workingExerciseId;
  String? selectedValue;
  //todo: extract all exercises from DB in constructor in workout page
  List<String> exercises = <String>[
    'Deadlift',
    'Squat',
    'Bench',
    'OHP'
  ];
  //todo: replace with reading from bloc state


  @override
  State<SetCard> createState() => _SetCardState();
}

class _SetCardState extends State<SetCard> {

  final TextEditingController textEditingController = TextEditingController();
  // List<SetRow> sets = _getSetRowsFromState(BlocProvider.of<WorkoutBloc>(context).state);

  @override
  Widget build(BuildContext context) {
    return BlocListener<WorkoutBloc, WorkoutState>(
      listener: (context, state){},
      child: Container(
        margin: const EdgeInsets.fromLTRB(5, 10, 5, 0),
        color: Colors.grey,
        child: Column(
          children: [
            DropdownButtonHideUnderline(
              child: DropdownButton2(
                hint: Text(
                  'Select Item',
                  style: TextStyle(
                    fontSize: 14,
                    color: Theme.of(context).hintColor,
                  ),
                ),
                items: widget.exercises
                    .map((item) => DropdownMenuItem<String>(
                          value: item,
                          child: Text(
                            item,
                            style: const TextStyle(
                              fontSize: 14,
                            ),
                          ),
                        ))
                    .toList(),
                value: widget.selectedValue,
                onChanged: (value) {
                  setState(() {
                    widget.selectedValue = value as String;
                  });
                },
                buttonHeight: 40,
                buttonWidth: 140,
                itemHeight: 40,
                dropdownMaxHeight: 200,
                searchController: textEditingController,
                searchInnerWidget: Padding(
                  padding: const EdgeInsets.only(
                    top: 8,
                    bottom: 4,
                    right: 8,
                    left: 8,
                  ),
                  child: TextFormField(
                    controller: textEditingController,
                    decoration: InputDecoration(
                      isDense: true,
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 8,
                      ),
                      hintText: 'Select an exercise...',
                      hintStyle: const TextStyle(fontSize: 12),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                  ),
                ),
                searchMatchFn: (item, searchValue) {
                  return (item.value
                      .toString()
                      .toLowerCase()
                      .contains(searchValue.toLowerCase()));
                },
                onMenuStateChange: (isOpen) {
                  if (!isOpen) {
                    textEditingController.clear();
                  }
                },
              ),
            ),
            const Divider(
              color: Colors.black,
              indent: 5,
              endIndent: 5,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 15),
              child: ListView(
                shrinkWrap: true,
                children: _getSetRowsFromState(BlocProvider.of<WorkoutBloc>(context).state),
              ),
            ),
            const Divider(
              color: Colors.black,
              indent: 5,
              endIndent: 5,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                OutlinedButton(onPressed: () async {
                  BlocProvider.of<WorkoutBloc>(context).add(WorkoutEvent(eventType: EventType.addSetToWorkingExercise, workingExerciseId: widget.workingExerciseId));
                  await Future.delayed(const Duration(milliseconds: 500));
                  setState(() {});
                }, child: const Text("Add set")),
                ElevatedButton(onPressed: () {
                  BlocProvider.of<WorkoutBloc>(context).add(WorkoutEvent(eventType: EventType.endWorkingExercise, workingExerciseId: widget.workingExerciseId));
                },
                child: const Text("Finish exercise")),
              ],
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    textEditingController.dispose();
    super.dispose();
  }

  List<SetRow> _getSetRowsFromState(WorkoutState workoutState){
    List<SetRow> setRows = [];
    for(SetW set in workoutState.sets){
      if(set.workingExercisesId == widget.workingExerciseId) {
        setRows.add(SetRow(setId: set.setId));
      }
    }
    return setRows;
  }
}
