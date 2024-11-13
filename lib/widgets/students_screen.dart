import 'package:flutter/material.dart';
import '../models/students.dart';
import 'student_item.dart';
import 'new_student.dart';

class StudentsScreen extends StatefulWidget {
  @override
  _StudentsScreenState createState() => _StudentsScreenState();
}

class _StudentsScreenState extends State<StudentsScreen> {
  List<Student> students = [
    Student(firstName: 'Alice', lastName: 'Johnson', department: Department.finance, grade: 85, gender: Gender.female),
    Student(firstName: 'Bob', lastName: 'Smith', department: Department.it, grade: 90, gender: Gender.male),
    Student(firstName: 'Clara', lastName: 'Adams', department: Department.medical, grade: 78, gender: Gender.female),
    Student(firstName: 'David', lastName: 'Brown', department: Department.law, grade: 92, gender: Gender.male),
  ];

  void addStudent(Student student) {
    setState(() {
      students.add(student);
    });
  }

  void editStudent(int index, Student updatedStudent) {
    setState(() {
      students[index] = updatedStudent;
    });
  }

  void deleteStudent(int index) {
    final deletedStudent = students[index];
    setState(() {
      students.removeAt(index);
    });
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Student deleted'),
        action: SnackBarAction(
          label: 'Undo',
          onPressed: () {
            setState(() {
              students.insert(index, deletedStudent);
            });
          },
        ),
      ),
    );
  }

  void openNewStudentForm({Student? student, int? index}) {
    showModalBottomSheet(
      context: context,
      builder: (context) => NewStudent(
        student: student,
        onSave: (newStudent) {
          if (index != null) {
            editStudent(index, newStudent);
          } else {
            addStudent(newStudent);
          }
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Students'),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () => openNewStudentForm(),
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: students.length,
        itemBuilder: (context, index) {
          return Dismissible(
            key: ValueKey(students[index]),
            background: Container(color: Colors.red, alignment: Alignment.centerLeft, child: Icon(Icons.delete, color: Colors.white)),
            onDismissed: (_) => deleteStudent(index),
            child: InkWell(
              onTap: () => openNewStudentForm(student: students[index], index: index),
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 8.0),
                child: StudentItem(student: students[index]),
              ),
            ),
          );
        },
      ),
    );
  }
}
