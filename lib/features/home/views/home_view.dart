import 'package:firebase_practice/features/home/views/add_student_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../manager/home_cubit.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  @override
  void initState() {
    super.initState();
    context.read<HomeCubit>().getStudents();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Students"),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => BlocProvider.value(
                value: context.read<HomeCubit>(),
                child: const AddStudentView(),
              ),
            ),
          );
        },
        child: const Icon(Icons.add),
      ),
      body: BlocBuilder<HomeCubit, HomeState>(
        builder: (context, state) {
          if (state is GetStudentsLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          if (state is HomeFailure) {
            return Center(
              child: Text(state.message),
            );
          }

          if (state is GetStudentsSuccess) {
            if (state.students.isEmpty) {
              return const Center(
                child: Text("No students found"),
              );
            }

            return ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: state.students.length,
              itemBuilder: (context, index) {
                final student = state.students[index].data();

                return Card(
                  margin: const EdgeInsets.only(bottom: 12),
                  child: ListTile(
                    leading: CircleAvatar(
                      child: Text(
                        student['name'][0].toUpperCase(),
                      ),
                    ),
                    title: Text(student['name']),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Age: ${student['age']}"),
                        Text("Grade: ${student['grade']}"),
                        // Text("Address: ${student['address']}"),
                      ],
                    ),
                  ),
                );
              },
            );
          }

          return const SizedBox();
        },
      ),
    );
  }
}