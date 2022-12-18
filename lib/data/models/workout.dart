class Workout{
  late int id;
  late DateTime startDateTime;
  late DateTime endDateTime;
  late bool isCompleted;

  Workout({required this.id, required this.startDateTime, required this.endDateTime, required this.isCompleted});

  @override
  String toString() {
    return 'Workout{id: $id, startDateTime: $startDateTime, endDateTime: $endDateTime, isCompleted: $isCompleted}';
  }
}