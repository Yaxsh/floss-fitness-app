import 'package:bloc/bloc.dart';
import 'package:floss_fitness_app/data/repository/workout_database_repository.dart';
import 'package:floss_fitness_app/bloc/state/workout_state.dart';

class WorkoutBloc extends Bloc<WorkoutEvent, WorkoutState>{

  late WorkoutDatabaseRepository _workoutDatabaseRepository;

  WorkoutBloc(WorkoutState initialState) : super(initialState){
    _workoutDatabaseRepository = WorkoutDatabaseRepository();
  }
}

class WorkoutEvent{
  final EventType eventType;
  final int? setId;
  final int? exerciseId;

  WorkoutEvent({required this.eventType, this.setId, this.exerciseId});
}

enum EventType{
  addSet,
  modifySet,
  endSet,
  endWorkout
}