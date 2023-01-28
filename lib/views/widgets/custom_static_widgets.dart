import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../bloc/controller/workout_bloc.dart';
import '../../bloc/state/workout_state.dart';
import '../../const/constants.dart';

class CustomWidgets{

  static getAppBar(){
    return AppBar(
      title: const Text(
        Constants.titleOfApp, style: TextStyle(color: Colors.black, letterSpacing: 1.5),
      ),
    );
  }

  // static getWorkoutPageAppBar(){
  //   return BlocListener<WorkoutBloc, WorkoutState>(
  //     listener: (context, state){},
  //     child: AppBar(
  //       title: const Text(
  //         Constants.titleOfApp, style: TextStyle(color: Colors.black, letterSpacing: 1.5),
  //       ),
  //       actions: <Widget>[
  //         Padding(
  //           padding: const EdgeInsets.only(right: 20.0),
  //           child: GestureDetector(
  //             onTap: () {
  //               BlocProvider.of<WorkoutBloc>(context).add(WorkoutEvent(eventType: EventType.endWorkout)
  //             },
  //             child: const Icon(
  //               Icons.check,
  //               size: 25.0,
  //             ),
  //           ),
  //         ),
  //       ],
  //     ),
  //   );
  // }

  static getSetRow(){
    return Row(
      children: const [
        //todo: replace with Expanded/Flexible
        SizedBox(
          width: 20,
          child: TextField(
            keyboardType: TextInputType.number,
          ),
        ),
        Text("kg x "),
        SizedBox(
          width: 20,
          child: TextField(keyboardType: TextInputType.number),
        ),
        Text("reps."),
      ],
    );
  }
}