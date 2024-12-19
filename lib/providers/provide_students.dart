import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/student.dart';

final studentsProvider = StateNotifierProvider<StudentsNotifier, List<Student>>(
    (ref) => StudentsNotifier());

class StudentsNotifier extends StateNotifier<List<Student>> {
  StudentsNotifier() : super([]);

  Student? _removedStudent;
  int? _removedIndex;

  void addStudent(Student student) {
    state = [...state, student];
  }

  void editStudent(int index, Student updatedStudent) {
    final updatedList = [...state];
    updatedList[index] = updatedStudent;
    state = updatedList;
  }

  void removeStudent(int index) {
    _removedStudent = state[index];
    _removedIndex = index;
    state = [...state.sublist(0, index), ...state.sublist(index + 1)];
  }

  void undo() {
    if (_removedStudent != null && _removedIndex != null) {
      final updatedList = [...state];
      updatedList.insert(_removedIndex!, _removedStudent!);
      state = updatedList;
      _removedStudent = null;
      _removedIndex = null;
    }
  }
}