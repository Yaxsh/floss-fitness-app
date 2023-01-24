import 'package:flutter/material.dart';

class SetRow extends StatefulWidget {
  const SetRow({Key? key, required this.setId}) : super(key: key);

  final int setId;

  @override
  State<SetRow> createState() => _SetRowState();
}

class _SetRowState extends State<SetRow> {
  @override
  Widget build(BuildContext context) {
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
