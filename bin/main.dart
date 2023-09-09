import 'dart:io';

import 'package:dart_course_console_application/exercises.dart';

import 'package:dart_course_console_application/header.dart';

void main() async {
  Exercises exercises = Exercises();

  bool runItAgain = true;
  bool isChoiceCorrect = false;
  int optionChoise = -1;

  while (runItAgain) {
    isChoiceCorrect = false;
    optionChoise = -1;

    header(exercisesCount: exercises.exercisesLength());

    while (!isChoiceCorrect) {
      try {
        stdout.write("Type your choice: ");
        optionChoise = int.parse(stdin.readLineSync()!);

        exercises.setExerciseToRun(exerciseToRun: optionChoise);

        isChoiceCorrect = true;

        await exercises.runExercise();
      } catch (error) {
        stderr.writeln("\nInvalid Option - Try Again!\n");
      }
    }

    print("\n------------------------");
    print("\nEnding Exercise...\n");

    stdout.write("Do you wanna run other exercise? (Y or N): ");

    try {
      String option = stdin.readLineSync()!;

      if ((option.toLowerCase() == "n") ||
          (option.toLowerCase() != "y" && option.toLowerCase() != "n")) {
        runItAgain = false;

        if (option.toLowerCase() != "y" && option.toLowerCase() != "n") {
          print("Unrecognized option!");
        }
      }
    } catch (error) {
      print("Unrecognized option!");

      runItAgain = false;
    }
  }

  print("\n------------------------");
  print("\nEnding Program...");
}
