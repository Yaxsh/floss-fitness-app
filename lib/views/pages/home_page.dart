import 'package:flutter/material.dart';
import 'package:floss_fitness_app/views/widgets/custom_static_widgets.dart';
import 'package:floss_fitness_app/views/widgets/workout_card.dart';
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
      drawer: Drawer(
        child: ListView(
          scrollDirection: Axis.vertical,
          children: [
            Padding(
              padding: EdgeInsets.only(top: 15.0),
              child: Align(
                alignment: Alignment.center,
                child: GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(context, '/exercises');
                    },
                    child: Text("Edit exercises")
                )
              ),
            )
          ],
        ),
      ),
      body: FutureBuilder<List<Map<String, Object?>>>(
        future: WorkoutDatabaseRepository.getAllFinishedWorkouts(),
        builder: (BuildContext buildContext,
            AsyncSnapshot<List<Map<String, Object?>>> asyncSnap) {
          if (asyncSnap.hasData) {
            //todo: find more efficient way to keep track, state?
            List<Map<String, Object?>>? map = asyncSnap.data;
            for (Map<String, Object?> workoutMap in map!) {
              if (!workoutDisplayed.contains(workoutMap['id'] as int)) {
                Workout workoutToBeInserted =
                    Workout.fromEndUpdateMap(workoutMap);
                if (workoutCardList.isNotEmpty) {
                  workoutToBeInserted.startDateTime
                          .isAfter(workoutCardList.first.workout.startDateTime)
                      ? workoutCardList.insert(
                          0, WorkoutCard(workout: workoutToBeInserted))
                      : workoutCardList
                          .add(WorkoutCard(workout: workoutToBeInserted));
                } else {
                  workoutCardList
                      .add(WorkoutCard(workout: workoutToBeInserted));
                }
                workoutDisplayed.add(workoutMap['id'] as int);
              }
            }
          } else if (!asyncSnap.hasData) {
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
          newWorkout =
              await WorkoutDatabaseRepository.createAndReturnNewWorkoutInDb(),
          await Navigator.pushNamed(context, '/workout',
              arguments: newWorkout.toMap()),
          setState(() {})
        },
        tooltip: 'Start new workout',
        child: const Icon(Icons.add),
      ),
    );
  }
}
