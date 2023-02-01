import 'package:bloc/bloc.dart';
import 'package:floss_fitness_app/data/models/set.dart';
import 'package:floss_fitness_app/data/models/working_exercise.dart';
import 'package:floss_fitness_app/data/models/workout.dart';
import 'package:flutter/widgets.dart';
import 'package:floss_fitness_app/data/repository/workout_database_repository.dart';
import 'package:floss_fitness_app/bloc/state/workout_state.dart';

class WorkoutBloc extends Bloc<WorkoutEvent, WorkoutState>{

  late WorkoutDatabaseRepository _workoutDatabaseRepository;

  WorkoutBloc(WorkoutState initialState) : super(initialState){
    _workoutDatabaseRepository = WorkoutDatabaseRepository();

    on<WorkoutEvent>((event, emit) async {
      switch (event.eventType) {
        case EventType.addWorkingExercise:
          WorkingExercise workingExercise = await _workoutDatabaseRepository.addNewWorkingExercise(state.workout.id!);
          state.workingExercises.add(workingExercise);
          break;
        case EventType.addSetToWorkingExercise:
          SetW set = SetW(typeOfSet: TypeOfSet.set, workingExercisesId: event.workingExerciseId!);
          set = await _workoutDatabaseRepository.addNewWorkingSet(set);
          state.sets.add(set);
          break;
        case EventType.modifySetFromWorkingExercise:
          //todo: add update to DB code to be able to end exercise without ending sets if not null
          event = event as ModifySetFromWorkingExerciseEvent;
          for(SetW set in state.sets){
            if(set.setId == event.setId){
              set.reps = event.reps;
              set.weight = event.weight;
            }
          }
          break;
        case EventType.endSetFromWorkingExercise:
          //todo: add exercise id
          event = event as EndSetFromWorkingExerciseEvent;
          SetW returnedSet = await _workoutDatabaseRepository.endSetFromWorkingExercise(event.setId!, event.reps, event.weight);
          debugPrint(returnedSet.toString());
          break;
        case EventType.endWorkingExercise:
          WorkingExercise workingExercise = await _workoutDatabaseRepository.endWorkingExercise(event.workingExerciseId!);
          int indexOfWorkingExercise = 0;
          for(WorkingExercise workingExerciseInLoop in state.workingExercises){
            if(workingExerciseInLoop.id == event.workingExerciseId){
              break;
            }
            indexOfWorkingExercise++;
          }
          state.workingExercises.removeAt(indexOfWorkingExercise);
          state.workingExercises.insert(indexOfWorkingExercise, workingExercise);
          break;
        case EventType.endWorkout:
          Workout endedWorkout = await _workoutDatabaseRepository.endWorkout(state.workout.id!);
          state.workout = endedWorkout;
          break;
      }
    });
  }
}

class WorkoutEvent{
  final EventType eventType;
  late int? setId;
  final int? workingExerciseId;

  WorkoutEvent({required this.eventType, this.setId, this.workingExerciseId});
}

enum EventType{
  addWorkingExercise,
  addSetToWorkingExercise,
  modifySetFromWorkingExercise,
  endSetFromWorkingExercise,
  endWorkingExercise,
  endWorkout,
}

class ModifySetFromWorkingExerciseEvent extends WorkoutEvent{
  final int reps;
  final int weight;

  ModifySetFromWorkingExerciseEvent({required super.eventType, required this.reps, required this.weight, setId}){
    this.setId = setId;
  }
}

class EndSetFromWorkingExerciseEvent extends WorkoutEvent{
  final int reps;
  final int weight;
  
  EndSetFromWorkingExerciseEvent({required super.eventType, required this.reps, required this.weight, setId}){
    this.setId = setId;
  }
}