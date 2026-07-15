import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/widgets/app_text_form_field.dart';
import '../manager/home_cubit.dart';

class AddStudentView extends StatefulWidget {
  const AddStudentView({super.key});

  @override
  State<AddStudentView> createState() => _AddStudentViewState();
}

class _AddStudentViewState extends State<AddStudentView> {
  final _formKey = GlobalKey<FormState>();

  final nameController = TextEditingController();
  final ageController = TextEditingController();
  final gradeController = TextEditingController();
  final addressController = TextEditingController();

  @override
  void dispose() {
    nameController.dispose();
    ageController.dispose();
    gradeController.dispose();
    addressController.dispose();
    super.dispose();
  }

  void addStudent() {
    if (!_formKey.currentState!.validate()) return;

    context.read<HomeCubit>().addStudent({
      'name': nameController.text.trim(),
      'age': int.parse(ageController.text.trim()),
      'grade': gradeController.text.trim(),
      'address': addressController.text.trim(),
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Add Student')),
      body: BlocConsumer<HomeCubit, HomeState>(
        listener: (context, state) {
          if (state is AddStudentSuccess) {
            ScaffoldMessenger.of(context)
              ..hideCurrentSnackBar()
              ..showSnackBar(
                const SnackBar(content: Text('Student added successfully')),
              );

            nameController.clear();
            ageController.clear();
            gradeController.clear();
            addressController.clear();

            Navigator.pop(context);
          }

          if (state is HomeFailure) {
            ScaffoldMessenger.of(context)
              ..hideCurrentSnackBar()
              ..showSnackBar(SnackBar(content: Text(state.message)));
          }
        },
        builder: (context, state) {
          return SingleChildScrollView(
            padding: const EdgeInsets.all(20),
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  AppTextFormField(
                    controller: nameController,
                    hintText: 'Student Name',
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return 'Name is required';
                      }
                      return null;
                    },
                  ),

                  const SizedBox(height: 16),

                  AppTextFormField(
                    controller: ageController,
                    hintText: 'Age',
                    keyboardType: TextInputType.number,
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return 'Age is required';
                      }

                      if (int.tryParse(value) == null) {
                        return 'Enter a valid age';
                      }

                      return null;
                    },
                  ),

                  const SizedBox(height: 16),

                  AppTextFormField(
                    controller: gradeController,
                    hintText: 'Grade',
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return 'Grade is required';
                      }
                      return null;
                    },
                  ),

                  const SizedBox(height: 16),

                  AppTextFormField(
                    controller: addressController,
                    hintText: 'Address',
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return 'Address is required';
                      }
                      return null;
                    },
                  ),

                  const SizedBox(height: 30),

                  SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: ElevatedButton(
                      onPressed: state is AddStudentLoading ? null : addStudent,
                      child: state is AddStudentLoading
                          ? const SizedBox(
                              width: 22,
                              height: 22,
                              child: CircularProgressIndicator(strokeWidth: 2),
                            )
                          : const Text('Add Student'),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
