import 'package:flutter/material.dart';

class FinishedSetRow extends StatefulWidget {
  const FinishedSetRow({Key? key, required this.reps, required this.weight}) : super(key: key);

  final int reps;
  final num weight;

  @override
  State<FinishedSetRow> createState() => _FinishedSetRowState();
}

class _FinishedSetRowState extends State<FinishedSetRow> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        children: [
          const Padding(padding: EdgeInsets.only(right: 5)),
          SizedBox(
            width: 35,
            child: TextFormField(
              enabled: false,
              initialValue: widget.weight.toString(),
            ),
          ),
          const Text("  kg  x ", style: TextStyle(fontWeight: FontWeight.bold)),
          SizedBox(
            width: 35,
            child: TextFormField(
              enabled: false,
              initialValue: widget.reps.toString(),
            ),
          ),
          const Text("  reps.", style: TextStyle(fontWeight: FontWeight.bold)),
          const Padding(padding: EdgeInsets.only(right: 25)),
        ],
      ),
    );
  }
}
