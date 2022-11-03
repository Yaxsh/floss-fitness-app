class Workout{
  late int workoutId;
  late DateTime startDateTime;
  late DateTime endDateTime;
  late bool isCompleted;

  Workout({required this.workoutId, required this.startDateTime, required this.endDateTime, required this.isCompleted});

  @override
  String toString() {
    return 'Workout{workoutId: $workoutId, startDateTime: $startDateTime, endDateTime: $endDateTime, isCompleted: $isCompleted}';
  }
}