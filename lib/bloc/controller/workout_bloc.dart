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
          //todo: find better way to initialize exercises
          if(!state.isExerciseListRead) {
            state.exercises.addAll(await _workoutDatabaseRepository.getAllExerciseFromDbAsList());
            state.isExerciseListRead = true;
          }
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
          for(var i=0; i<state.sets.length ; i++){
            if(state.sets.elementAt(i).setId == returnedSet.setId){
              state.sets[i] = returnedSet;
            }
          }
          debugPrint('RE SET: ${returnedSet.toString()}');
          break;
        case EventType.modifyWorkingExercise:
          var event1 = event as ModifyWorkingExerciseEvent;
          debugPrint('MODIFIED WORKING EX!!: ${event1.exerciseName!} WITH ID ${event1.workingExerciseId}');
          //todo: make sure name of exercise is unique
          state.workingExercises.where((workingExercise) => workingExercise.id==event1.workingExerciseId).first.exerciseId =
            state.exercises.where((element) => element.name == event1.exerciseName!).first.exerciseId!;
          debugPrint('wok after update ${state.workingExercises}');
          state.nameOfWorkingExerciseByName.update(event1.workingExerciseId!, (value) => event1.exerciseName, ifAbsent: () => event1.exerciseName);
          debugPrint('state.nameOfWorkingExerciseByName: ${state.nameOfWorkingExerciseByName}');
          break;
        case EventType.endWorkingExercise:
          int exerciseId = -1;
          int indexOfWorkingExercise = 0;
          for(WorkingExercise workingExerciseInState in state.workingExercises){
            if(event.workingExerciseId! == workingExerciseInState.id){
              exerciseId = workingExerciseInState.exerciseId;
              break;
            }
            indexOfWorkingExercise++;
          }
          WorkingExercise workingExercise = await _workoutDatabaseRepository.endWorkingExercise(event.workingExerciseId!, exerciseId);
          state.workingExercises[indexOfWorkingExercise] = workingExercise;
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
  modifyWorkingExercise,
  endWorkingExercise,
  endWorkout,
}

class ModifySetFromWorkingExerciseEvent extends WorkoutEvent{
  final int reps;
  final num weight;

  ModifySetFromWorkingExerciseEvent({required super.eventType, required this.reps, required this.weight, setId}){
    this.setId = setId;
  }
}

class EndSetFromWorkingExerciseEvent extends WorkoutEvent{
  final int reps;
  final num weight;
  
  EndSetFromWorkingExerciseEvent({required super.eventType, required this.reps, required this.weight, setId}){
    this.setId = setId;
  }
}

class ModifyWorkingExerciseEvent extends WorkoutEvent{
  final String exerciseName;

  ModifyWorkingExerciseEvent({required super.eventType, required super.workingExerciseId, required this.exerciseName});
}