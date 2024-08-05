import 'package:excel_converter/features/attendence/data/datasource/sqflite_datasource.dart';
import 'package:excel_converter/features/attendence/presentation/bloc/attendence/attendence_bloc.dart';
import 'package:excel_converter/features/attendence/presentation/pages/attendance_page.dart';
import 'package:excel_converter/features/attendence/presentation/widgets/upload_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Homepage extends StatelessWidget {
  const Homepage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text(
            "HomePage",
            style: Theme.of(context).textTheme.bodyMedium,
          ),
          actions: [
            IconButton(
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) {
                      return const AttendancePage();
                    },
                  ));
                },
                icon: const Icon(Icons.person))
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CustomButton(
                  buttonText: "Upload File",
                  onPressed: () {
                    clearDatabase();

                    context.read<AttendenceBloc>().add(LoadCsv());
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) {
                        return const AttendancePage();
                      },
                    ));
                  },
                )
              ],
            ),
          ),
        ));
  }
}
