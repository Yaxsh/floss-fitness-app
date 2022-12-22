class Exercise{
  int? exerciseId;
  late String name;
  late bool isCompound;

  Exercise({this.exerciseId, required this.name, required this.isCompound});

  @override
  String toString(){
    return 'Exercise{exerciseId: $exerciseId, name: $name, isCompound: $isCompound}';
  }
}