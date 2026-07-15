import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'features/auth/manager/auth_cubit.dart';
import 'features/auth/views/login_view.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  runApp(const MyApp());
}
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return
        BlocProvider(create: (_) => AuthCubit(),child:
       MaterialApp(
        debugShowCheckedModeBanner: false,
        home: const LoginView(),
      ),
    );
  }
}
