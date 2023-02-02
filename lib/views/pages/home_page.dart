import 'package:floss_fitness_app/views/widgets/custom_static_widgets.dart';
import 'package:floss_fitness_app/views/widgets/workout_card.dart';
import 'package:flutter/material.dart';

import '../../data/data_providers/workout_database_provider.dart';
import '../../data/models/workout.dart';
import '../../data/repository/workout_database_repository.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<WorkoutCard> workoutCardList = [];
  //todo: investigate why future is executed 3 times!!
  List<int> workoutDisplayed = [];

  late Workout newWorkout;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomWidgets.getAppBar(),
      drawer: const Drawer(),
      body: FutureBuilder<List<Map<String, Object?>>>(
        future: WorkoutDatabaseRepository.getAllFinishedWorkouts(),
        builder: (BuildContext buildContext, AsyncSnapshot<List<Map<String, Object?>>> asyncSnap){
          if (asyncSnap.hasData) {
            debugPrint("HAS DATA: ${asyncSnap.data}");
            List<Map<String, Object?>>? map = asyncSnap.data;
            for(Map<String, Object?> workoutMap in map!){
              debugPrint("MAP IN FOR LOOP: $workoutMap");
              if(!workoutDisplayed.contains(workoutMap['id'] as int)) {
                workoutCardList.add(WorkoutCard(workout: Workout.fromEndUpdateMap(workoutMap)));
                workoutDisplayed.add(workoutMap['id'] as int);
              }
            }
          }
          else if(!asyncSnap.hasData){
            debugPrint("NO DATA!!!");
            return const Center(child: CircularProgressIndicator());
          }
          return ListView(
            key: UniqueKey(),
            scrollDirection: Axis.vertical,
            children: workoutCardList,
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async => {
          newWorkout = await WorkoutDatabaseRepository.createAndReturnNewWorkoutInDb(),
          Navigator.pushNamed(context, '/workout', arguments: newWorkout.toMap())
        },
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}
