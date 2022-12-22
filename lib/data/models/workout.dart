class Workout{
  //todo: work out and implement DB logic between endDateTime and isCompleted
  int? id; //can be null before being written into database
  late DateTime startDateTime;
  late DateTime endDateTime;
  late bool isCompleted;

  Workout({this.id, required this.startDateTime, required this.endDateTime, required this.isCompleted});

  @override
  String toString() {
    return 'Workout{id: $id, startDateTime: $startDateTime, endDateTime: $endDateTime, isCompleted: $isCompleted}';
  }
}