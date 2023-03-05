import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:floss_fitness_app/bloc/state/workout_state.dart';
import 'package:floss_fitness_app/data/models/exercise.dart';
import 'package:floss_fitness_app/views/widgets/set_row.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../bloc/controller/workout_bloc.dart';
import '../../data/models/set.dart';

class WorkingExerciseCard extends StatefulWidget {
  WorkingExerciseCard({Key? key, required this.workingExerciseId, required this.exercises, this.selectedValue, required this.isOngoing}) : super(key: key);

  final int workingExerciseId;
  String? selectedValue;
  //todo: extract all exercises from DB in constructor in workout page
  List<Exercise> exercises = [];
  //flag if finish exercise button is pressed yet
  bool isOngoing;

  @override
  State<WorkingExerciseCard> createState() => _WorkingExerciseCardState();
}

class _WorkingExerciseCardState extends State<WorkingExerciseCard> {

  final TextEditingController textEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    debugPrint('WORKING EXERCISE ID: ${widget.workingExerciseId} AND LIST OF EX: ${widget.exercises}');
    debugPrint('SELECTED VALUE: ${widget.selectedValue} FOR ID ${widget.workingExerciseId}');
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
                items: widget.exercises.map((e) => e.name).toList()
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
                onChanged: widget.isOngoing ? (value) {
                  debugPrint("SELECTED EXER : $value");
                  //todo: sent event to modify working exercise
                  BlocProvider.of<WorkoutBloc>(context).add(ModifyWorkingExerciseEvent(eventType: EventType.modifyWorkingExercise, workingExerciseId: widget.workingExerciseId, exerciseName: value! as String));
                  setState(() {
                    widget.selectedValue = value as String;
                  });
                } : null,
                buttonHeight: 40,
                buttonWidth: 140,
                itemHeight: 40,
                dropdownMaxHeight: 200,
                searchController: textEditingController,
                searchInnerWidgetHeight: 10,
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
                physics: const NeverScrollableScrollPhysics(),
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
                OutlinedButton(onPressed: widget.isOngoing ? () async {
                  BlocProvider.of<WorkoutBloc>(context).add(WorkoutEvent(eventType: EventType.addSetToWorkingExercise, workingExerciseId: widget.workingExerciseId));
                  await Future.delayed(const Duration(milliseconds: 500));
                  setState(() {});
                } : null,
                child: const Text("Add set")),
                ElevatedButton(
                  onPressed: (widget.isOngoing && (widget.selectedValue!=null && widget.selectedValue!='') && _areSetsFinished(BlocProvider.of<WorkoutBloc>(context).state)) ? () {
                    BlocProvider.of<WorkoutBloc>(context).add(WorkoutEvent(eventType: EventType.endWorkingExercise, workingExerciseId: widget.workingExerciseId));
                    widget.isOngoing = false;
                    debugPrint('${widget.selectedValue} - active: ${widget.selectedValue!=null || widget.selectedValue!=''}');
                    setState(() {});
                  } : null,
                  child: widget.selectedValue==null || widget.selectedValue==''
                      ? const Text('Select exercise') :
                        _areSetsFinished(BlocProvider.of<WorkoutBloc>(context).state) ?
                          const Text('Finish exercise') :
                          const Text('Finish sets')
                ),
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
        debugPrint('SET ID: ${set.setId} end: ${set.endTimeOfSet == null}');
        setRows.add(
            SetRow(setId: set.setId, reps: set.reps, weight: set.weight, isEnded: set.endTimeOfSet == null ? false : true, sendSetStateToCard: refreshEndExerciseButton,));
      }
    }
    return setRows;
  }

  bool _areSetsFinished(WorkoutState workoutState){
    return workoutState.sets
        .where((element) => element.workingExercisesId == widget.workingExerciseId && element.endTimeOfSet==null).isNotEmpty ? false : true;
  }

  refreshEndExerciseButton(){
    setState(() {});
  }
}
