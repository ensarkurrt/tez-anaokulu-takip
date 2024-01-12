enum DurationEnums {
  themeChange(300, DurationType.milisecond),
  animationTransition(200, DurationType.milisecond);

  final int time;
  final DurationType type;
  const DurationEnums(this.time, this.type);
}

enum DurationType {
  milisecond,
  second,
}

extension DurationEnumsExtension on DurationEnums {
  Duration get duration => type == DurationType.milisecond ? Duration(milliseconds: time) : Duration(seconds: time);
  int get time => this.time;
}
