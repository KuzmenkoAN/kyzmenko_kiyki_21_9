import 'package:flutter/material.dart';
import '../models/students.dart';

class StudentItem extends StatelessWidget {
  final Student student;

  const StudentItem({Key? key, required this.student}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Color genderColor = student.gender == Gender.male ? Colors.blue : Colors.pink;

    return Container(
      padding: EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: genderColor.withOpacity(0.1),
        borderRadius: BorderRadius.circular(10),
      ),
      child: ListTile(
        leading: Icon(departmentIcons[student.department], color: genderColor),
        title: Text('${student.firstName} ${student.lastName}', style: TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Text('Grade: ${student.grade}'),
        trailing: Icon(Icons.star, color: Colors.amber),
      ),
    );
  }
}
