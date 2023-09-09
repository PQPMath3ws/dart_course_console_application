import 'package:dart_course_console_application/clear_cls.dart';

void header({required int exercisesCount}) {
  clearTerminalClsConsole();

  print("-****-----******---******---******");
  print("-*---*----*----*---*--**------**--");
  print("-*----*---******---*-**-------**--");
  print("-*---*----*----*---*--**------**--");
  print("-****-----*----*---*----*-----**--");
  print("\n");

  exercisesOptions(exercisesCount: exercisesCount);
}

void exercisesOptions({required int exercisesCount}) {
  print("Choose what you want to run: \n");

  for (int i = 1; i <= exercisesCount; i++) {
    print("$i) Exercise $i");
  }

  print("\n");
}
