part of 'home_cubit.dart';

sealed class HomeState {}

final class HomeInitial extends HomeState {}

final class AddStudentLoading extends HomeState {}

final class AddStudentSuccess extends HomeState {}

final class GetStudentsLoading extends HomeState {}

final class GetStudentsSuccess extends HomeState {
  final List<QueryDocumentSnapshot<Map<String, dynamic>>> students;

  GetStudentsSuccess({required this.students});
}

final class HomeFailure extends HomeState {
  final String message;

  HomeFailure(this.message);
}
