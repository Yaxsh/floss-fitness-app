import 'package:floss_fitness_app/pages/widgets/custom_wigets.dart';
import 'package:floss_fitness_app/pages/widgets/workout_card.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  //todo: read workout from db, call selectAllWorkouts()!!
  List<WorkoutCard> workoutCardList = [const WorkoutCard()];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomWidgets.getAppBar(),
      drawer: const Drawer(),
      body: ListView(
        key: UniqueKey(),
        scrollDirection: Axis.vertical,
        children: workoutCardList,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => {print("clicked floating button!!")},
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}
