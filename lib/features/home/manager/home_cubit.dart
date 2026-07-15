import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(HomeInitial());

  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  Future<void> addStudent(Map<String, dynamic> student) async {
    emit(AddStudentLoading());

    try {
      await firestore.collection('students').add(student);

      emit(AddStudentSuccess());

      getStudents();
    } on FirebaseException catch (e) {
      emit(HomeFailure(e.message ?? "Something went wrong"));
    }
  }

  Future<void> getStudents() async {
    emit(GetStudentsLoading());

    try {
      final snapshot = await firestore.collection('students').get();

      emit(GetStudentsSuccess(students: snapshot.docs));
    } on FirebaseException catch (e) {
      emit(HomeFailure(e.message ?? "Something went wrong"));
    }
  }
}
