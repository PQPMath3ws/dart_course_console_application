// Exercise 2(8) of Dart - Intermediate Course

class Employee {
  String _name = "";
  String _position = "";

  Employee({required String name, required String position}) {
    _name = name;
    _position = position;
  }

  void printEmployeeInfos() {
    print("Hi! My name is $_name and I am a $_position!");
  }
}

// Exercise 3 (9) of Dart - Intermediate Course

class Person {
  int _age = -1;

  int get age => _age;

  Person({required int age}) {
    _age = age;
  }
}

// Exercise 4 (10) of Dart - Intermediate Course

class BnB extends House with Hotel {
  BnB({required int bnbGuests, required int bnbRooms}) {
    rooms = bnbRooms;
    guests = bnbGuests;
  }

  @override
  void ringDoorBell() {
    print("Ding Dong!\n");
    print("We have $rooms rooms and $guests guests!");
  }
}

abstract class House {
  late int _rooms;

  int get rooms => _rooms;

  set rooms(rooms) => _rooms = rooms;

  void ringDoorBell();
}

mixin Hotel {
  int _guests = 0;

  int get guests => _guests;

  set guests(guests) => _guests = guests;
}

// Exercise 5 (11) of Dart - Intermediate Course

class GenericEmployee {
  void sayHello() {
    print("Hello! - I'm a GenericEmployee class!");
  }
}

class Manager extends GenericEmployee {
  @override
  void sayHello() {
    print("Hello! - I'm a Manager class!");
  }
}

class Cashier extends GenericEmployee {
  @override
  void sayHello() {
    print("Hello! - I'm a Cashier class!");
  }
}

class Payroll<T extends GenericEmployee> {
  final List<T> _employees = [];

  void add({required T value}) {
    _employees.add(value);
  }

  void print() {
    for (int i = 0; i < _employees.length; i++) {
      _employees[i].sayHello();
    }
  }
}
