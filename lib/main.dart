import 'package:excel_converter/core/theme/theme.dart';
import 'package:excel_converter/features/attendence/data/datasource/sqflite_datasource.dart';
import 'package:excel_converter/features/attendence/presentation/bloc/absent/absent_bloc.dart';
import 'package:excel_converter/features/attendence/presentation/bloc/attendence/attendence_bloc.dart';
import 'package:excel_converter/features/attendence/presentation/pages/attendance_page.dart';
import 'package:excel_converter/features/attendence/presentation/pages/homepage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initializeDatabase();

  runApp(MultiBlocProvider(
    providers: [
      BlocProvider(
        create: (context) => AttendenceBloc(),
      ),
      BlocProvider(
        create: (context) => AbsentBloc(),
      )
    ],
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: AppTheme.darkThemeMode,
        home: const Homepage());
  }
}
