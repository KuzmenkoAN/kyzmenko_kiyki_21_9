import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/student.dart';
import '../providers/students_provider.dart';
import '../widgets/new_student.dart';
import '../widgets/students_item.dart';

class StudentsScreen extends ConsumerWidget {
  const StudentsScreen({Key? key}) : super(key: key);

  void _showNewStudentModal(BuildContext context, WidgetRef ref,
      {Student? student, int? index}) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => NewStudent(
        student: student,
        onSave: (newStudent) {
          if (index != null) {
            ref.read(studentsProvider.notifier).editStudent(index, newStudent);
          } else {
            ref.read(studentsProvider.notifier).addStudent(newStudent);
          }
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final students = ref.watch(studentsProvider);

    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: AppBar(
        title: const Text(
          'Student Directory',
          style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: students.isEmpty
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(
                    Icons.people_outline,
                    size: 80,
                    color: Colors.grey,
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    'No students added yet!',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                      color: Colors.grey,
                    ),
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton.icon(
                    onPressed: () => _showNewStudentModal(context, ref),
                    icon: const Icon(Icons.add),
                    label: const Text('Add Student'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blueAccent,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(
                          vertical: 12, horizontal: 20),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                  ),
                ],
              ),
            )
          : ListView.builder(
              padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
              itemCount: students.length,
              itemBuilder: (context, index) {
                final student = students[index];
                return Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 6.0, horizontal: 4.0),
                  child: StudentsItem(
                    student: student,
                    onDelete: () {
                      ref.read(studentsProvider.notifier).removeStudent(index);
                      final container = ProviderScope.containerOf(context);
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: const Text('Student deleted'),
                          action: SnackBarAction(
                            label: 'Undo',
                            onPressed: () {
                              container.read(studentsProvider.notifier).undo();
                            },
                          ),
                        ),
                      );
                    },
                    onTap: () => _showNewStudentModal(context, ref,
                        student: student, index: index),
                  ),
                );
              },
            ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => _showNewStudentModal(context, ref),
        icon: const Icon(Icons.add),
        label: const Text('Add Student'),
        backgroundColor: Colors.blueAccent,
      ),
    );
  }
}
