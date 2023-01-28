import 'dart:convert';

import 'package:floss_fitness_app/data/data_providers/workout_database_provider.dart';
import 'package:floss_fitness_app/data/repository/workout_database_repository.dart';
import 'package:floss_fitness_app/views/widgets/custom_static_widgets.dart';
import 'package:flutter/material.dart';
import '../../data/models/workout.dart';

class TestPage extends StatefulWidget {
  const TestPage({Key? key}) : super(key: key);

  @override
  State<TestPage> createState() => _TestPageState();
}

class _TestPageState extends State<TestPage> {

  late Workout res;

  @override
  Widget build(BuildContext context) {

    final arguments = ModalRoute.of(context)?.settings.arguments as Map<String, Object?>;
    print(arguments.toString());
    print(arguments['start_date_time']);

    return Scaffold(
      appBar: CustomWidgets.getAppBar(),
      drawer: const Drawer(),
      body: Center(
        child: FutureBuilder<List<Map<String, Object?>>>(
          future: WorkoutDatabaseProvider.selectAllWorkouts(),
          builder: (BuildContext buildContext, AsyncSnapshot<List<Map<String, Object?>>> asyncSnap){
            if(!asyncSnap.hasData){
              return const Center(child: Text("no data!!"),);
            }
            else{
              return Center(child: Text(asyncSnap.data.toString()));
            }
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async => {
          res = await WorkoutDatabaseRepository.createAndReturnNewWorkoutInDb(),
          debugPrint(res.toString()),
        },
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}
