class Workout{
  //todo: work out and implement DB logic between endDateTime and isCompleted
  int? id; //can be null before being written into database
  late DateTime startDateTime;
  DateTime? endDateTime;
  late int isCompleted;

  Workout({this.id, required this.startDateTime, required this.endDateTime, required this.isCompleted});

  Workout.newWorkout(){
    startDateTime = DateTime.now();
    isCompleted = 0;
  }
  Workout.fromNewInsertMap(Map<String, Object?> map){
    id = map['id'] as int;
    startDateTime = DateTime.parse(map['start_date_time'].toString());
    isCompleted = map['is_completed'] as int;
  }

  @override
  String toString() {
    return 'Workout{id: $id, startDateTime: $startDateTime, endDateTime: $endDateTime, isCompleted: $isCompleted}';
  }

  Map<String, Object?> toMap(){
    Map<String, Object?> map = Map();
    map.putIfAbsent('id', () => id);
    map.putIfAbsent('start_date_time', () => startDateTime);
    map.putIfAbsent('end_date_time', () => endDateTime);
    map.putIfAbsent('is_completed', () => isCompleted);
    return map;
  }
}