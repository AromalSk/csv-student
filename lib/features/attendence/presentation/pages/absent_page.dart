import 'package:excel_converter/features/attendence/data/datasource/sqflite_datasource.dart';
import 'package:excel_converter/features/attendence/presentation/bloc/absent/absent_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AbsentPage extends StatefulWidget {
  const AbsentPage({super.key});

  @override
  State<AbsentPage> createState() => _AbsentPageState();
}

class _AbsentPageState extends State<AbsentPage> {
  @override
  Widget build(BuildContext context) {
    printAbsentStudentsList();
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "Absent page",
          style: Theme.of(context).textTheme.bodyMedium,
        ),
      ),
      body: BlocConsumer<AbsentBloc, AbsentState>(
        listener: (context, state) {
          // TODO: implement listener
        },
        builder: (context, state) {
          if (state is AbsentLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          if (state is AbsentSuccess) {
            return ListView.builder(
              itemCount: state.absentStudents.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(
                    state.absentStudents[index].name,
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                  subtitle: Text(
                      state.absentStudents[index].rollNumber.toString(),
                      style: Theme.of(context).textTheme.displaySmall),
                  trailing: Text(state.absentStudents[index].courseName,
                      style: Theme.of(context).textTheme.displaySmall),
                );
              },
            );
          } else {
            return const Center(
              child: Text(
                "Some error occured",
              ),
            );
          }
        },
      ),
    );
  }
}
