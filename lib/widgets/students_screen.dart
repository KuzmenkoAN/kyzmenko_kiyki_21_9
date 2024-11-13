import 'package:flutter/material.dart';
import '../models/students.dart';
import 'student_item.dart';

class StudentsScreen extends StatelessWidget {
  final List<Student> students = [
    Student(firstName: 'Alice', lastName: 'Johnson', department: Department.finance, grade: 85, gender: Gender.female),
    Student(firstName: 'Bob', lastName: 'Smith', department: Department.it, grade: 90, gender: Gender.male),
    Student(firstName: 'Clara', lastName: 'Adams', department: Department.medical, grade: 78, gender: Gender.female),
    Student(firstName: 'David', lastName: 'Brown', department: Department.law, grade: 92, gender: Gender.male),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Students'),
      ),
      body: ListView.builder(
        itemCount: students.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 8.0),
            child: StudentItem(student: students[index]),
          );
        },
      ),
    );
  }
}
