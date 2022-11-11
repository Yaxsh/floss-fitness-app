import 'package:floss_fitness_app/data/db/workout_database.dart';
import 'package:floss_fitness_app/pages/widgets/custom_wigets.dart';
import 'package:flutter/material.dart';

class TestPage extends StatefulWidget {
  const TestPage({Key? key}) : super(key: key);

  @override
  State<TestPage> createState() => _TestPageState();
}

class _TestPageState extends State<TestPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomWidgets.getAppBar(),
      drawer: const Drawer(),
      body: Center(
        child: FutureBuilder<List<Map<String, Object?>>>(
          future: WorkoutDatabase.instance.getTestQuery(),
          builder: (BuildContext buildContext, AsyncSnapshot<List<Map<String, Object?>>> asnap){
            if(!asnap.hasData || asnap.data?.length==0){
              return Center(child: Text("no data"),);
            }
            else{
              return Center(child: Text(asnap.data.toString()),);
            }
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => {print("clicked floating button")},
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}
