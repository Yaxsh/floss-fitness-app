import 'package:floss_fitness_app/views/pages/exercises_details_page.dart';
import 'package:floss_fitness_app/views/pages/exercises_page.dart';
import 'package:floss_fitness_app/views/pages/home_page.dart';
import 'package:floss_fitness_app/views/pages/test_page.dart';
import 'package:floss_fitness_app/views/pages/workout_details_page.dart';
import 'package:floss_fitness_app/views/pages/workout_page.dart';
import 'package:flutter/material.dart';
import 'const/constants.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: Constants.titleOfApp,
      theme: ThemeData(
        primarySwatch: Colors.lightGreen,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const HomePage(),
        '/workout': (context) => const WorkoutPage(),
        '/exercises': (context) => const ExercisesPage(),
        '/exercise-details': (context) => const ExercisesDetailsPage(),
        //todo: replace with pushNamed in workoutCard
        // '/workoutDetails': (context) => const WorkoutDetailsPage(),
      },
    );
  }
}
