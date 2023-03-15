import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:floss_fitness_app/views/widgets/custom_static_widgets.dart';
import 'package:floss_fitness_app/views/widgets/workout_card.dart';
import 'package:intl/intl.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import '../../const/db_constants.dart';
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
                child: FractionallySizedBox(
                  widthFactor: 0.8,
                  // heightFactor: 0.1,
                  child: OutlinedButton(
                      onPressed: () {
                        Navigator.pushNamed(context, '/exercises');
                      },
                      child: Text("Edit exercises")
                  ),
                )
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 10.0),
              child: Align(
                  alignment: Alignment.center,
                  child: FractionallySizedBox(
                    widthFactor: 0.8,
                    // heightFactor: 0.1,
                    child: OutlinedButton(
                        onPressed: () {
                          //todo: implement new screen for body weight
                          debugPrint('TODO: IMPLEMENT NEW PAGE FOR WEIGHT');
                        },
                        child: const Text("TODO: Track body weight")
                    ),
                  )
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 10.0),
              child: Align(
                  alignment: Alignment.center,
                  child: FractionallySizedBox(
                    widthFactor: 0.8,
                    // heightFactor: 0.1,
                    child: OutlinedButton(
                        onPressed: exportDB,
                        child: const Text("Export db")
                    ),
                  )
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 10.0),
              child: Align(
                  alignment: Alignment.center,
                  child: FractionallySizedBox(
                    widthFactor: 0.8,
                    // heightFactor: 0.1,
                    child: OutlinedButton(
                        onPressed: importDB,
                        child: const Text("Import db")
                    ),
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
            if(workoutCardList.isEmpty){
            //todo: check if exercises are present in table: FutureBuilder
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text('Add exercises before starting workouts!'),
                    Padding(padding: EdgeInsets.only(bottom: 10)),
                    OutlinedButton(onPressed: () {Navigator.pushNamed(context, '/exercises');}, child: Text('Add exercises')),
                    OutlinedButton(onPressed: importDB, child: Text('Import DB'))
                  ],
                ),
              );
            }
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

  exportDB() async {
    //todo: export func to util class and use in settings as well
    String databaseDirectory = await getDatabasesPath();
    String databasePath = join(databaseDirectory, DbConstants.DATABASE_NAME);
    debugPrint(databasePath);
    File dbFile = File(databasePath);
    String? selectedDirectory = await FilePicker.platform.getDirectoryPath();
    debugPrint('DIR: $selectedDirectory');
    dbFile.copy('$selectedDirectory/fitnelly-recovery-${DateFormat('dd-MM-yyyy').format(DateTime.now())}.db');
  }

  importDB() async {
    //todo: export func to util class and use in settings as well
    FilePickerResult? result = await FilePicker.platform.pickFiles();
    if (result != null) {
      File backupFile = File(result.files.single.path!);
      backupFile.copy('/data/user/0/com.example.floss_fitness_app/databases/fitnelly.db');
      setState(() {});
    }
  }
}
