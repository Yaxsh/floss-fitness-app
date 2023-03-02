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

  /*todo: investigate why future is executed 3 times!!
  * replacing with better data structure might be more optimal?*/
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
            refreshToRebuild();
            readWorkoutCardsFromData(asyncSnap.data!);
          } else if (!asyncSnap.hasData) {
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
          refreshToRebuild(),
          readWorkoutCardsFromData(await WorkoutDatabaseRepository.getAllFinishedWorkouts()),
          setState(() {})
        },
        tooltip: 'Start new workout',
        child: const Icon(Icons.add),
      ),
    );
  }

  refreshToRebuild(){
    workoutCardList = [];
    workoutDisplayed = [];
    debugPrint('refreshed');
  }

  readWorkoutCardsFromData(List<Map<String, Object?>> data){
    debugPrint("readWorkoutCardsFromData building... $workoutDisplayed");
    for (Map<String, Object?> workoutMap in data) {
      if (!workoutDisplayed.contains(workoutMap['id'] as int)) {
        Workout workoutToBeInserted =
        Workout.fromEndUpdateMap(workoutMap);
        if (workoutCardList.isNotEmpty) {
          workoutToBeInserted.startDateTime
              .isAfter(workoutCardList.first.workout.startDateTime)
              ? workoutCardList.insert(
              0, WorkoutCard(workout: workoutToBeInserted, deleteWorkoutFunction: deleteWorkout, indexInHomePage: 0,))
              : workoutCardList
              .add(WorkoutCard(workout: workoutToBeInserted, deleteWorkoutFunction: deleteWorkout, indexInHomePage: workoutCardList.length-1,));
        } else {
          workoutCardList
              .add(WorkoutCard(workout: workoutToBeInserted, deleteWorkoutFunction: deleteWorkout, indexInHomePage: workoutCardList.length-1));
        }
        workoutDisplayed.add(workoutMap['id'] as int);
      }
    }
  }

  deleteWorkout(int workoutToBeDeleted) async {
    //todo: format function
    setState(() {});
    debugPrint('setstate from deletelworkout@@@!');
  }
}
