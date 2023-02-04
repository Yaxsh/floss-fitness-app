import 'package:floss_fitness_app/data/models/working_exercise.dart';
import 'package:flutter/material.dart';

import '../../data/repository/workout_database_repository.dart';
import 'finished_set_row.dart';

class FinishedWorkingExerciseCard extends StatefulWidget {
  const FinishedWorkingExerciseCard({Key? key, required this.finishedWorkingExercise}) : super(key: key);

  final WorkingExercise finishedWorkingExercise;

  @override
  State<FinishedWorkingExerciseCard> createState() => _FinishedWorkingExerciseCardState();
}

class _FinishedWorkingExerciseCardState extends State<FinishedWorkingExerciseCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.fromLTRB(5, 10, 5, 0),
      color: Colors.grey,
      child: Column(
        children: [
          Text("exercise"),
          const Divider(
            color: Colors.black,
            indent: 5,
            endIndent: 5,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 15),
            //todo: replace future building with arguments in constructor because of incorrect behavior
            child: FutureBuilder(
                future: WorkoutDatabaseRepository.getAllSetsForWorkingExercise(widget.finishedWorkingExercise.id),
                builder: (BuildContext buildContext,AsyncSnapshot<List<Map<String, Object?>>> asyncSnap) {
                  if(asyncSnap.hasData){
                    debugPrint("DATA ON FINISHED SETS FOR WORKING EXERCISE ${widget.finishedWorkingExercise.id} : ${asyncSnap.data}");
                  }
                  else{
                    debugPrint("NO DATA FOR WORKING EXERCISE ${widget.finishedWorkingExercise.id}");
                  }
                  return ListView(
                    shrinkWrap: true,
                    children: _getSetRowsFromDB(asyncSnap.data),
                  );
                }
            ),
          ),
          const Divider(
            color: Colors.black,
            indent: 5,
            endIndent: 5,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(onPressed: () {
                debugPrint("EDITED NOTE OF WORKING EXERCISE!");
              },
                  child: const Text("Edit note TODO")),
            ],
          ),
        ],
      ),
    );
  }

  List<FinishedSetRow> _getSetRowsFromDB(List<Map<String, Object?>>? finishedSetListOfMaps) {
    List<FinishedSetRow> finishedSetsRows = [];
    for(Map<String, Object?> setMap in finishedSetListOfMaps!){
      finishedSetsRows.add(FinishedSetRow(reps: setMap['reps'] as int, weight: setMap['weight'] as int));
    }
    return finishedSetsRows;
  }
}