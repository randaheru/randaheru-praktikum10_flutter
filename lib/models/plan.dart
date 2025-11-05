import './task.dart';

class Plan {
  final String name;
  final List<Task> tasks;

  const Plan({this.name = '', this.tasks = const []});

  // Menghitung jumlah task yang sudah complete
  int get completedCount => tasks.where((task) => task.complete).length;

  // Memberikan pesan ringkasan progress
  String get completenessMessage =>
      '$completedCount out of ${tasks.length} tasks';
}
