import 'dart:io';

void main() {
  performTasks();
}

void performTasks() async {
  runTask1();
  String task2Data = await runTask2();
  runTask3(task2Data);
}

void runTask1() {
  print('Task 1 done.');
}

Future<String> runTask2() async {
  String task2Data = "";
  await Future.delayed(Duration(seconds: 3), () {
    task2Data = "azaza";
    print('Task 2 done.');
  });
  return task2Data;
}

void runTask3(task2Data) {
  print('Task 3 done with $task2Data');
}
