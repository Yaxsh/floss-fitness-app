import 'package:floss_fitness_app/data/models/working_exercise.dart';
import 'package:flutter/material.dart';

import '../../data/repository/workout_database_repository.dart';
import 'finished_set_row.dart';

class FinishedWorkingExerciseCard extends StatefulWidget {
  FinishedWorkingExerciseCard({Key? key, required this.finishedWorkingExercise, required this.exerciseName}) : super(key: key);

  final WorkingExercise finishedWorkingExercise;
  //todo: get from constructor
  String exerciseName = "";

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
          Text(widget.exerciseName ?? "TODO"),
          const Divider(
            color: Colors.black,
            indent: 5,
            endIndent: 5,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 15),
            //todo: use multi-future builder to get exercise name, or retrieve exercises beforehand
            child: FutureBuilder<List<Map<String, Object?>>>(
                future: WorkoutDatabaseRepository.getAllSetsForWorkingExercise(widget.finishedWorkingExercise.id),
                builder: (BuildContext buildContext,AsyncSnapshot<List<Map<String, Object?>>> asyncSnap) {
                  if(asyncSnap.hasData){
                    return ListView(
                      shrinkWrap: true,
                      children: _getSetRowsFromDB(asyncSnap.data),
                    );
                  }
                  else{
                    return ListView(
                      shrinkWrap: true,
                      children: const [], //FinishedSetRow(reps: 0, weight: 0)
                    );
                  }
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