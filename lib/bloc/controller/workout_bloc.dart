import 'package:bloc/bloc.dart';
import 'package:floss_fitness_app/data/models/set.dart';
import 'package:floss_fitness_app/data/models/working_exercise.dart';
import 'package:flutter/widgets.dart';
import 'package:floss_fitness_app/data/repository/workout_database_repository.dart';
import 'package:floss_fitness_app/bloc/state/workout_state.dart';

class WorkoutBloc extends Bloc<WorkoutEvent, WorkoutState>{

  late WorkoutDatabaseRepository _workoutDatabaseRepository;

  WorkoutBloc(WorkoutState initialState) : super(initialState){
    _workoutDatabaseRepository = WorkoutDatabaseRepository();

    on<WorkoutEvent>((event, emit) async {
      switch (event.eventType) {
        case EventType.endWorkingExercise:
          debugPrint("Finished set! IN BLOC");
          break;
        case EventType.addWorkingExercise:
          WorkingExercise workingExercise = await _workoutDatabaseRepository.addNewWorkingExercise();
          state.workingExercises.add(workingExercise);
          break;
        case EventType.addSetToWorkingExercise:
          debugPrint("workingExerciseId${event.workingExerciseId}");
          SetW set = SetW(typeOfSet: TypeOfSet.set, workingExercisesId: event.workingExerciseId!);
          set = await _workoutDatabaseRepository.addNewWorkingSet(set);
          state.sets.add(set);
          var setId = set.setId;
          var workingSetId = set.workingExercisesId;
          var startTime = set.startTimeOfSet;
          debugPrint("Added set $setId with working exercise id = $workingSetId with start time $startTime");
          break;
      }
    });
  }
}

class WorkoutEvent{
  final EventType eventType;
  final int? setId;
  final int? workingExerciseId;

  WorkoutEvent({required this.eventType, this.setId, this.workingExerciseId});
}

enum EventType{
  addWorkingExercise,
  addSetToWorkingExercise,
  modifyWorkingExercise,
  endWorkingExercise,
  endWorkout,
}

class AddSetToWorkingExerciseEvent extends WorkoutEvent{
  AddSetToWorkingExerciseEvent({required super.eventType});
}