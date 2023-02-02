import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../bloc/controller/workout_bloc.dart';
import '../../bloc/state/workout_state.dart';
import '../../const/constants.dart';

class WorkoutAppBar extends StatefulWidget {
  const WorkoutAppBar({Key? key}) : super(key: key);

  @override
  State<WorkoutAppBar> createState() => _WorkoutAppBarState();
}

class _WorkoutAppBarState extends State<WorkoutAppBar> {
  @override
  Widget build(BuildContext context) {
    return BlocListener<WorkoutBloc, WorkoutState>(
      listener: (context, state){},
      child: AppBar(
        title: const Text(
          Constants.titleOfApp, style: TextStyle(color: Colors.black, letterSpacing: 1.5),
        ),
        actions: <Widget>[
          Padding(
            padding: const EdgeInsets.only(right: 20.0),
            child: GestureDetector(
              onTap: () {
                BlocProvider.of<WorkoutBloc>(context).add(WorkoutEvent(eventType: EventType.endWorkout));
              },
              child: const Icon(
                Icons.check,
                size: 25.0,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
