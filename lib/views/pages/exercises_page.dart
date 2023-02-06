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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomWidgets.getAppBar(),
      body: FutureBuilder<List<Map<String, Object?>>>(
          future: WorkoutDatabaseRepository.getAllExercise(),
          builder: (BuildContext buildContext, AsyncSnapshot<List<Map<String, Object?>>> asyncSnap) {
            if(asyncSnap.hasData) {
              for (Map<String, Object?> exerciseMap in asyncSnap.data!) {
                exerciseCards.add(ExerciseCard(name: exerciseMap['name'].toString(), isCompound: exerciseMap['is_compound'] as int == 1 ? true : false));
              }
              return ListView(
                children: exerciseCards,
              );
            }
            else{
              return CircularProgressIndicator();
            }
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
}
