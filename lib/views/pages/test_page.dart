import 'package:floss_fitness_app/data/data_providers/workout_database_provider.dart';
import 'package:floss_fitness_app/views/widgets/custom_wigets.dart';
import 'package:flutter/material.dart';

import '../../const/db_constants.dart';

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
          future: WorkoutDatabaseProvider.instance.getTestQuery(),
          builder: (BuildContext buildContext, AsyncSnapshot<List<Map<String, Object?>>> asyncSnap){
            if(!asyncSnap.hasData || asyncSnap.data?.length==0){
              return const Center(child: Text("no data!!"),);
            }
            else{
              return Center(child: Text(DbConstants.CREATE_SET_TABLE));
            }
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => { WorkoutDatabaseProvider.instance.insertTestQuery() },
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}
