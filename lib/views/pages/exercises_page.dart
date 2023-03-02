import 'package:floss_fitness_app/views/widgets/custom_static_widgets.dart';
import 'package:flutter/material.dart';

import '../../data/repository/workout_database_repository.dart';
import '../widgets/exercise_card.dart';

class ExercisesPage extends StatefulWidget {
  const ExercisesPage({Key? key}) : super(key: key);

  @override
  State<ExercisesPage> createState() => _ExercisesPageState();
}

class _ExercisesPageState extends State<ExercisesPage> {

  List<ExerciseCard> exerciseCards = [];
  //todo: replace with more efficient way of tracking, state or better data structure?
  List<int> exerciseIdDisplayed = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomWidgets.getAppBar(),
      body: FutureBuilder<List<Map<String, Object?>>>(
          future: WorkoutDatabaseRepository.getAllExerciseFromDBAsMaps(),
          builder: (BuildContext buildContext, AsyncSnapshot<List<Map<String, Object?>>> asyncSnap) {
            if(asyncSnap.hasData) {
              refreshToRebuild();
              readExercisesFromData(asyncSnap.data!);
            }
            else{
              return const CircularProgressIndicator();
            }
            return ListView(
              children: exerciseCards,
            );
          }),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await Navigator.pushNamed(context, '/exercise-details');
          setState(() {});
        },
        child: Icon(Icons.add),
      ),
    );
  }

  readExercisesFromData(List<Map<String, Object?>> data){
      for (Map<String, Object?> exerciseMap in data) {
        debugPrint("MAP: $exerciseMap");
        if(!exerciseIdDisplayed.contains(exerciseMap['id'] as int)) {
          exerciseCards.add(ExerciseCard(
              name: exerciseMap['name'].toString(),
              isCompound: exerciseMap['is_compound'] as int == 1 ? true : false,
              exerciseId: exerciseMap['id'] as int,
              updateExerciseCard: updateExercises));
          exerciseIdDisplayed.add(exerciseMap['id'] as int);
        }
      }
      return ListView(
        children: exerciseCards,
      );
  }

  refreshToRebuild(){
    exerciseIdDisplayed = [];
    exerciseCards = [];
  }

  updateExercises(){
    setState(() {});
  }
}
