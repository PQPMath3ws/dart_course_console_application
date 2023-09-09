import 'dart:convert';
import 'dart:io';
import 'dart:math';
import 'dart:typed_data';

import 'package:dart_course_console_application/clear_cls.dart';
import 'package:dart_course_console_application/exercises_classes.dart';

import 'package:http/http.dart' as http;
import 'package:mysql_client/mysql_client.dart';
import 'package:path/path.dart' as path;
import 'package:pointycastle/api.dart';

class Exercises {
  int _exerciseToRun = -1;

  List<Function> _exercises = [];

  int exercisesLength() => _exercises.length;

  Exercises() {
    _exercises = [
      _printYourName,
      _askUserFullName,
      _showPersonInsideListPerIndex,
      _countToTenWithLoop,
      _loopWithUserInteraction,
      _guessTheNumberWithError,
      _joinTheDirectoryAndFileAndOutput,
      _showEmployeeInfos,
      _getPersonAgeWithoutPublicSetter,
      _knowingTheHotel,
      _youCanReachAtGenericClass,
      _helloWordFromFile,
      _heyIamRunningHere,
      _appendingToAFile,
      _compressingDataToArchive,
      _heyIAmEncryptedText,
      _downloadingAWebPage,
      _iAmAddingInfoToADatabase
    ];
  }

  Future<void> runExercise() async {
    if (_exerciseToRun != -1) {
      clearTerminalClsConsole();
      if (_exercises[_exerciseToRun] is Future Function()) {
        await _exercises[_exerciseToRun]();
      } else {
        _exercises[_exerciseToRun]();
      }
    } else {
      throw Error();
    }
  }

  void setExerciseToRun({required int exerciseToRun}) {
    if (_exercises.asMap().containsKey(exerciseToRun - 1)) {
      _exerciseToRun = exerciseToRun - 1;
    } else {
      throw Error();
    }
  }

  // Dart - Beginners Course

  /*

  Exercise 1: Change the hello world application to display your name.
  
  */

  void _printYourName() {
    print("My name is Mathews Martins!");
  }

  /*

  Exercise 2: Ask the user for their first name, and store their input in a variable.
  Then ask the user for their last name and store that in a variable.
  Finally display the full name to the user.

  */

  void _askUserFullName() {
    List<String> fullname = ["", ""];
    List<bool> nameAndSurnameIsOk = [false, false];

    while (!nameAndSurnameIsOk[0] || !nameAndSurnameIsOk[1]) {
      try {
        stdout.write("Type your full name: ");
        fullname[0] = stdin.readLineSync()!;

        if (fullname[0].isEmpty) throw Error();

        nameAndSurnameIsOk[0] = true;

        stdout.write("Type your full surname: ");
        fullname[1] = stdin.readLineSync()!;

        if (fullname[1].isEmpty) throw Error();

        nameAndSurnameIsOk[1] = true;
      } catch (error) {
        stderr.writeln("\nFill the name and/or surname correctly!\n");
      }
    }

    print("\nNice to meet you, ${fullname[0]} ${fullname[1]}!");
  }

  /*

  Exercise 3: Create a list of people, ask the user for an index.
  Display the person in the list at the index the user supplied.

  */

  void _showPersonInsideListPerIndex() {
    const List<String> peoples = [
      "Andrew",
      "Charles",
      "Amelia",
      "Matthew",
      "Carl",
      "Emma",
      "Miles",
      "Sophia",
      "Isabella"
    ];

    while (true) {
      try {
        stdout.write("Type a number to possible show a person's name: ");
        int index = int.parse(stdin.readLineSync()!);

        print("\nPerson on index $index is ${peoples[index]}!\n");

        stdout.write("Can you run it again? (Y or N): ");
        String choise = stdin.readLineSync()!;

        if (choise.toLowerCase() == 'y') {
          continue;
        } else {
          if (choise.toLowerCase() != 'n') {
            print("\nUnrecognized option - Ending Program...");
          }
          break;
        }
      } on FormatException {
        print("\nThe input is not a valid number - Try Again!\n");
      } on RangeError {
        print("\nNot exists person in this index/range - Try Again!");
      }
    }

    print("\nThat's it! - Bye, bye!");
  }

  /*

  Exercise 4: Use a loop to count to 10. Print each number on the screen.
  At the 5th loop, print out "half way there".

  */

  void _countToTenWithLoop() {
    print("Counting to 10 with while: \n");

    int count = 1;

    while (count <= 10) {
      print("$count${count == 5 ? " (half way there)" : ""}");
      count++;
    }

    count = 1;

    print("\nCounting to 10 with do while: \n");

    do {
      print("$count${count == 5 ? " (half way there)" : ""}");
      count++;
    } while (count <= 10);

    print("\nCounting to 10 with for: \n");

    for (int i = 1; i <= 10; i++) {
      print("$i${i == 5 ? " (half way there)" : ""}");
    }
  }

  /*

  Exercise 5: Ask the user for a maximum number, use a loop to print
  each number on the screen from 1 to the number they provided.
  At the half way point, print out "half way there".
  Spit these tasks into functions.

  */

  void _loopWithUserInteraction() {
    int userLoopMaxInteraction = -1;

    bool interactionIsValid = false;

    void captureTheMaxInteraction() {
      stdout.write("Type number to count at: ");
      userLoopMaxInteraction = int.parse(stdin.readLineSync()!).abs();
    }

    void loopWithUserInput() {
      for (int i = 1; i <= userLoopMaxInteraction; i++) {
        print(
          "$i${userLoopMaxInteraction % 2 == 0 ? userLoopMaxInteraction / 2 == i ? " (half way there)" : "" : userLoopMaxInteraction ~/ 2 == i ? " (half way there)" : (userLoopMaxInteraction ~/ 2) + 1 == i ? " (half way there)" : ""}",
        );
      }
    }

    while (!interactionIsValid) {
      try {
        captureTheMaxInteraction();

        interactionIsValid = true;
        print("");

        loopWithUserInput();
      } on FormatException {
        print("\nInput a valid number range!\n");
      }
    }
  }

  /*

  Exercise 6: Ask the user for an age, if the age is less than 18,
  throw an Exception of "too young". If the age is over 99 throw an Exception
  of "too old". Catch the Exception and use a catch all.
  Also split these tasks up into different functions.

  */

  void _guessTheNumberWithError() {
    bool isValidInput = false;
    bool isValidAge = false;

    int inputNumber = -1;

    void captureTheInput() {
      stdout.write("Input one valid age number: ");

      inputNumber = int.parse(stdin.readLineSync()!).abs();
    }

    bool validateTheAge() {
      if (inputNumber < 18) throw "Too Young!";

      if (inputNumber > 95) throw "Too Old!";

      return true;
    }

    while (!isValidInput) {
      try {
        captureTheInput();

        isValidInput = true;

        isValidAge = validateTheAge();
      } on FormatException {
        print("\nInput a invalid age number - Try Again!\n");
      } catch (error) {
        print("\n${error.toString()}");
      } finally {
        if (isValidInput && isValidAge) {
          print("\n$inputNumber it's a valid age number!");
        }
      }
    }
  }

  // Dart - Intermediate Course

  /*

  Exercise 1: Import the "path" package and use it to join a directory path
  to a filename and print out the results.

  */

  void _joinTheDirectoryAndFileAndOutput() {
    String joinedPath = path.join("my_dir", "my_file.extension");
    print(joinedPath);
  }

  /*

  Exercise 2: Create an employee class. This class should have two strings,
  "name" and "position". Set those strings in the constructor.
  Then make a function that prints out the employee's name and position.

  */

  void _showEmployeeInfos() {
    Employee employee1 =
        Employee(name: "Mathews", position: "Founder of NerdTech");

    Employee employee2 =
        Employee(name: "Gabriel", position: "Beta Tester of NerdTech");

    employee1.printEmployeeInfos();
    print("");
    employee2.printEmployeeInfos();
  }

  /*

  Exercise 3: Create a person class that has an age getter but not a setter.
  This will allow the age to be read from the class but not changed.
  Set the age in the class constructor.

  */

  void _getPersonAgeWithoutPublicSetter() {
    Person person1 = Person(age: 20);
    Person person2 = Person(age: 18);
    Person person3 = Person(age: 14);

    print("I'm a first person with ${person1.age} years old!\n");
    print("I'm a second person with ${person2.age} years old!\n");
    print("I'm a third person with ${person3.age} years old!");
  }

  /*

  Exercise 4: Make a Bed and Breakfast class (BnB) that inherits a
  House class and uses a Hotel class as a interface. The hotel class should
  have a "guests" variable as an integer. The abstract house class should have
  a rooms variable as a integer and a function "ringDoorbell".
  The Bnb class will need to implement the house properties.

  */

  void _knowingTheHotel() {
    BnB bnb = BnB(bnbGuests: 12, bnbRooms: 4);

    bnb.ringDoorBell();
  }

  /*

  Exercise 5: Make the following classes:
  
  Employee
  Manager – inherit employee
  Cashier – inherit employee
  Payroll – use generics to allow only descendants of the employee class
  
  Both the Cashier and Manager classes should have a “sayHello” function
  that prints the class name. The payroll class should allow adding to an
  internal list, and a “print” function that calls the “sayHello” of
  each item in the internal list.

  */

  void _youCanReachAtGenericClass() {
    Manager manager = Manager();
    Cashier cashier1 = Cashier();
    Cashier cashier2 = Cashier();

    Payroll payroll = Payroll();

    payroll.add(value: cashier1);
    payroll.add(value: manager);
    payroll.add(value: cashier2);

    payroll.print();
  }

  /*

  Exercise 6: Create a file in the current directory.
  Write "Hello World" into the file.
  Read the contents of the file back.
  Delete the file.

  */

  Future<void> _helloWordFromFile() async {
    Directory directory = Directory(Platform.script
        .toString()
        .replaceFirst("file://", "")
        .replaceFirst("/bin/main.dart", ""));
    File file = File("${directory.path}/hello_world.txt");

    Future<void> writeInFile() async {
      RandomAccessFile randomAccessFile = await file.open(mode: FileMode.write);
      await randomAccessFile.writeString("Hello World!");
      await randomAccessFile.flush();
      await randomAccessFile.close();
    }

    Future<void> readFile() async {
      if (!await file.exists()) {
        print("File doesn't exists!\n");
        return;
      }

      print("Content of ${file.path} file:\n");

      print("\"\n${await file.readAsString()}\n\"");
    }

    Future<void> deleteFile() async {
      if (!await file.exists()) {
        print("File doesn't exists!\n");
        return;
      }

      await file.delete();
    }

    await writeInFile();

    await readFile();

    await deleteFile();
  }

  // Dart - Advanced Course

  /*

  Exercise 1: Determine the operating system you are on and print
  the PATH variable from the operating system.

  */

  void _heyIamRunningHere() {
    print(
      "Hey - I'm running in ${Platform.operatingSystem} ${Platform.operatingSystemVersion} OS!\n",
    );

    print("The PATH variable contains: ${Platform.environment["PATH"]} ");
  }

  /*

  Exercise 2: Append to a file and read it back asynchronously.

  */

  Future<void> _appendingToAFile() async {
    Directory directory = Directory.current;
    File file = File("${directory.path}/file_to_append.txt");

    Future<void> writeInFile() async {
      RandomAccessFile randomAccessFile =
          await file.open(mode: FileMode.append);
      await randomAccessFile.writeString(
          "${await file.length() != 0 ? "\n" : ""}I'm runing at: ${DateTime.now().toString()} !");
      await randomAccessFile.flush();
      await randomAccessFile.close();
    }

    Future<void> readFile() async {
      if (!await file.exists()) {
        print("File doesn't exists!\n");
        return;
      }

      print("Content of ${file.path} file:\n");

      print("\"\n${await file.readAsString()}\n\"");
    }

    await writeInFile();

    await readFile();
  }

  /*

  Exercise 3: Compress some data using GZIP or ZLIB and write it to a file,
  then decompress it and print it on the screen.

  */

  Future<void> _compressingDataToArchive() async {
    Directory baseDir = Directory(Platform.script
        .toString()
        .replaceFirst("file://", "")
        .replaceFirst("/bin/main.dart", ""));

    File compressedFile =
        File(path.absolute(baseDir.path, "compressed_file.txt"));

    if (!await compressedFile.exists()) {
      await compressedFile.create();
    }

    String textToEncode = "";
    bool reachedSecretMessage = false;

    try {
      stdout.write("Type a text you want to compress in a file: ");
      textToEncode = stdin.readLineSync()!;

      if (textToEncode.isEmpty) {
        throw Error();
      }
    } catch (error) {
      textToEncode =
          "Hello, dear!\r\nThis is an a secret compressed message!\r\nI'm so glad you came read this.\r\nI Love You!\r\nBye, Bye!";

      reachedSecretMessage = true;
    }

    List<int> utf8Encoded = utf8.encode(textToEncode);
    List<int> gZipEncoded = gzip.encode(utf8Encoded);

    await compressedFile.writeAsBytes(gZipEncoded);

    print("\nMessage compressed and saved successfully!");

    if (reachedSecretMessage) {
      print("\nYou compressed a secret message!");
    }

    List<int> gZipDecodedMessage =
        gzip.decode(await compressedFile.readAsBytes());
    String utf8DecodedMessage = utf8.decode(gZipDecodedMessage);

    print("\nThe file encoded message was: \n\n$utf8DecodedMessage");
  }

  /*

  Exercise 4: Use Salsa20 to encrypt a string, then use SHA-256 to compare
  the plain text to the encrypted text.

  */

  void _heyIAmEncryptedText() {
    bool isValidText = false;
    String textToEncrypt = "";

    Uint8List generateRandomBytes(int lengthOfBytes) {
      final SecureRandom secureRandom = SecureRandom("AES/CTR/AUTO-SEED-PRNG");

      final Uint8List key = Uint8List(16);
      final KeyParameter keyParameter = KeyParameter(key);
      final ParametersWithIV<KeyParameter> parametersWithIV =
          ParametersWithIV<KeyParameter>(keyParameter, Uint8List(16));

      secureRandom.seed(parametersWithIV);

      final Random random = Random();

      for (int i = 0; i < random.nextInt(255); i++) {
        secureRandom.nextUint8();
      }

      final Uint8List bytes = secureRandom.nextBytes(lengthOfBytes);

      return bytes;
    }

    Uint8List createUint8ListFromString(String value) =>
        Uint8List.fromList(utf8.encode(value));

    while (!isValidText) {
      try {
        stdout.write("Type a text who you want to encrypt: ");
        textToEncrypt = stdin.readLineSync()!;

        if (textToEncrypt.isEmpty) {
          throw Error();
        }

        isValidText = true;
      } catch (error) {
        print("\nYour text cannot be empty!\n");
      }
    }

    final Uint8List randomBytes1 = generateRandomBytes(16);
    final KeyParameter keyParameter = KeyParameter(randomBytes1);
    final Uint8List randomBytes2 = generateRandomBytes(8);
    final ParametersWithIV<KeyParameter> parametersWithIV =
        ParametersWithIV<KeyParameter>(keyParameter, randomBytes2);

    final StreamCipher streamCipher = StreamCipher("Salsa20");
    streamCipher.init(true, parametersWithIV);

    final Uint8List plainText = createUint8ListFromString(textToEncrypt);
    final Uint8List encryptedData = streamCipher.process(plainText);

    streamCipher.reset();
    streamCipher.init(false, parametersWithIV);

    final Uint8List decryptedData = streamCipher.process(encryptedData);

    final Digest digest = Digest("SHA-256");

    if (base64.encode(digest.process(plainText)) ==
        base64.encode(digest.process(decryptedData))) {
      print("\nThe compared values is the same!");
    } else {
      print("\nThe compared values is not the same!");
    }
  }

  /*

  Exercise 5: Download a web page using HTTP Get and display the length.

  */

  Future<void> _downloadingAWebPage() async {
    String url = "";
    bool isValidUrl = false;

    while (!isValidUrl) {
      try {
        stdout.write("Type a valid URL to download it's content: ");
        url = stdin.readLineSync()!;

        if (url.isEmpty) {
          throw Error();
        }

        isValidUrl = Uri.parse(url).isAbsolute;

        if (!isValidUrl) {
          throw Error();
        }
      } catch (error) {
        print("\nYou typed a invalid URL!\n");
      }
    }

    final http.Response response = await http.get(Uri.parse(url));

    print("\nWebsite: $url");
    print("\nWebsite Response Body Length: ${response.contentLength}");
    print("\nWebsite Response Status Code: ${response.statusCode}");
  }

  /*

  Exercise 6: Use SQlJocky to add rows to a table.
  
  OBS: I'm using other lib for database, because SQLJocky does not have
  support for Dart 3.

  */

  Future<void> _iAmAddingInfoToADatabase() async {
    MySQLConnectionPool getSQLConnectionPool(String? database) {
      return MySQLConnectionPool(
        host: "0.0.0.0",
        port: 3306,
        userName: "root",
        password: "root",
        maxConnections: 5,
        databaseName: database,
      );
    }

    try {
      MySQLConnectionPool mySQLConnectionPool = getSQLConnectionPool(null);

      await mySQLConnectionPool
          .execute("CREATE DATABASE IF NOT EXISTS dart_exercise_db_temp;");

      await mySQLConnectionPool.close();

      mySQLConnectionPool = getSQLConnectionPool("dart_exercise_db_temp");

      await mySQLConnectionPool.execute(
          "CREATE TABLE IF NOT EXISTS infos (id INT NOT NULL PRIMARY KEY AUTO_INCREMENT, info TEXT NOT NULL);");

      while (true) {
        try {
          stdout.write("\nType a text who you want to insert in a table: ");
          String textToInsert = stdin.readLineSync()!;

          if (textToInsert.isEmpty) {
            throw Error();
          }

          await mySQLConnectionPool
              .execute("INSERT INTO infos (info) VALUES (\"$textToInsert\");");

          stdout.write("\nDo you wanna insert more infos in table? (Y or N): ");
          String choose = stdin.readLineSync()!;

          if (choose.toLowerCase() == "y") {
            continue;
          } else {
            print("\nAll right! - Ending inserts!");
            break;
          }
        } catch (error) {
          print("\nEmpty string is not allowed! - Try Again!");
        }
      }

      print("\nGetting all values inserted in a table...");

      print("\nTable 'infos' VALUES: \n");

      final IResultSet queryResult =
          await mySQLConnectionPool.execute("SELECT * FROM infos;");

      if (queryResult.rows.isNotEmpty) {
        for (final resultRow in queryResult.rows) {
          print(resultRow.assoc());
        }
      } else {
        print("\nTable 'infos' is empty!\n");
      }

      await mySQLConnectionPool.close();

      mySQLConnectionPool = getSQLConnectionPool(null);

      await mySQLConnectionPool
          .execute("DROP DATABASE IF EXISTS dart_exercise_db_temp;");

      await mySQLConnectionPool.close();
    } catch (error) {
      print("\nError on MySQL Service - Check settings and try again later!");
      print("\nError: ${error.toString()}\n");
    }
  }
}
