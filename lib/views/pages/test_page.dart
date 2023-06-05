import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:floss_fitness_app/views/widgets/custom_static_widgets.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
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
    return Scaffold(
      appBar: CustomWidgets.getAppBar(),
      drawer: const Drawer(),
      body: FutureBuilder(
        future: Future.wait([
          Permission.manageExternalStorage.request(),
          Permission.storage.request(),
          // Permission.accessMediaLocation.request()
        ]),
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
          if (snapshot.hasData) {
            //storage manageExternalStorage accessMediaLocation
            return Center(
              child: Text(snapshot.data!.toString()),
            );
          } else {
            return const Center(
              child: Text('have perm'),
            );
          }
        },
      ),
      floatingActionButton: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
        FloatingActionButton(
          onPressed: () async => {
            tst(),
            debugPrint('XD'),
          },
          tooltip: 'Increment',
          heroTag: "btn1",
          child: const Icon(Icons.add),
        ),
        Padding(padding: EdgeInsets.only(right: 10)),
        FloatingActionButton(
          onPressed: () async => {
            tst1(),
            debugPrint('XD1'),
          },
          tooltip: 'Increment',
          heroTag: "btn2",
          child: const Icon(Icons.inbox),
        ),
      ]),
    );
  }

  tst() async {
    ///data/user/0/com.example.floss_fitness_app/databases/fitnelly.db
    File dbFile = File(
        '/data/user/0/com.example.floss_fitness_app/databases/fitnelly.db');
    String? selectedDirectory = await FilePicker.platform.getDirectoryPath();
    debugPrint('DIR: $selectedDirectory');
    dbFile.copy('$selectedDirectory/fitnelly-tst.db');
  }

  tst1() async{
    ///storage/emulated/0/Fitnelly/fitnelly-tst.db
    File dbFile = File(
        '/storage/emulated/0/Fitnelly/fitnelly-tst.db');
    dbFile.copy('/data/user/0/com.example.floss_fitness_app/databases/fitnelly.db');
  }
}
