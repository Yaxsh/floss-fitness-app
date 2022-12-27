import 'package:floss_fitness_app/views/widgets/custom_wigets.dart';
import 'package:floss_fitness_app/views/widgets/set_card.dart';
import 'package:flutter/material.dart';

class WorkoutPage extends StatefulWidget {
  const WorkoutPage({Key? key}) : super(key: key);

  @override
  State<WorkoutPage> createState() => _WorkoutPageState();
}

class _WorkoutPageState extends State<WorkoutPage> {

  List<SetCard> setCardsList = [const SetCard()];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomWidgets.getAppBar(),
      drawer: const Drawer(),
      body: ListView(
        key: UniqueKey(),
        scrollDirection: Axis.vertical,
        children: setCardsList,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _addSet(),
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }

  void _addSet() {
    setCardsList.add(const SetCard());
    setState(() {});
  }
  
}
