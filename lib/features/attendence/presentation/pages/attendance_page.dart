import 'package:excel_converter/core/theme/app_pallete.dart';
import 'package:excel_converter/features/attendence/data/datasource/sqflite_datasource.dart';
import 'package:excel_converter/features/attendence/presentation/bloc/absent/absent_bloc.dart';
import 'package:excel_converter/features/attendence/presentation/bloc/attendence/attendence_bloc.dart';
import 'package:excel_converter/features/attendence/presentation/pages/absent_page.dart';
import 'package:excel_converter/features/attendence/presentation/widgets/upload_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AttendancePage extends StatefulWidget {
  const AttendancePage({super.key});

  @override
  State<AttendancePage> createState() => _AttendancePageState();
}

class _AttendancePageState extends State<AttendancePage> {
  int currentIndex = 0;

  void markPresent() {
    setState(() {
      studentsList[currentIndex].isAbsent = false;
      if (currentIndex < studentsList.length) {
        currentIndex++;
      }
    });
  }

  void markAbsent() async {
    setState(() {
      // Update the UI to reflect the current absence status
      studentsList[currentIndex].isAbsent = true;
    });

    if (studentsList[currentIndex].id != null) {
      try {
        await markAbsentInDatabase(studentsList[currentIndex].id!);
      } catch (e) {
        print('Error marking student absent: $e');
      }
    }

    // Move to the next student if there are more students to process
    if (currentIndex < studentsList.length) {
      setState(() {
        currentIndex++;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "Attendance Page",
          style: Theme.of(context).textTheme.bodyMedium,
        ),
        actions: [
          IconButton(
              onPressed: () {
                context.read<AbsentBloc>().add(AbsentStudents());
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) {
                    return const AbsentPage();
                  },
                ));
              },
              icon: const Icon(Icons.person_off))
        ],
      ),
      body: BlocConsumer<AttendenceBloc, AttendenceState>(
        listener: (context, state) {},
        builder: (context, state) {
          if (state is AttendenceLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          if (state is AttendenceSuccess) {
            return Column(
              children: [
                LinearProgressIndicator(
                  value: currentIndex / state.students.length,
                  backgroundColor: Colors.grey[300],
                  valueColor: const AlwaysStoppedAnimation<Color>(Colors.blue),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: AppPallete.borderColor,
                    ),
                    child: ListTile(
                      leading: Text(
                        "Sl.no",
                        style: Theme.of(context).textTheme.displaySmall,
                      ),
                      title: Text(
                        "Student Name",
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                      subtitle: Text(
                        'rollNumber',
                        style: Theme.of(context).textTheme.displaySmall,
                      ),
                      // Updated
                    ),
                  ),
                ),
                Expanded(
                  child: ListView.builder(
                    itemCount: state.students.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 15, vertical: 5),
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: currentIndex == index
                                ? Colors.blue
                                : state.students[index].isAbsent
                                    ? const Color.fromARGB(255, 223, 76, 66)
                                    : Colors.white10,
                          ),
                          child: ListTile(
                            leading: Text(state.students[index].id.toString(),
                                style:
                                    Theme.of(context).textTheme.displaySmall),
                            title: Text(
                              state.students[index].name,
                              style: Theme.of(context).textTheme.bodyMedium,
                            ),
                            subtitle: Text(
                              state.students[index].rollNumber.toString(),
                              style: Theme.of(context).textTheme.displaySmall,
                            ), // Updated
                            trailing: Switch(
                              activeColor: Colors.red[100],
                              value: state.students[index].isAbsent,
                              onChanged: (bool value) async {
                                setState(() {
                                  state.students[index].isAbsent = value;
                                });

                                if (value) {
                                  await markAbsentInDatabase(
                                      state.students[index].id!);
                                } else {
                                  await removeAbsentFromDatabase(
                                      state.students[index].id!);
                                }
                              },
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      CustomButton(
                        onPressed: currentIndex < state.students.length
                            ? markPresent
                            : null,
                        buttonText: "Present",
                      ),
                      CustomButton(
                        onPressed: currentIndex < state.students.length
                            ? markAbsent
                            : null,
                        buttonText: "Absent",
                      ),
                    ],
                  ),
                ),
              ],
            );
          } else {
            return const Center(
              child: Text("No Data"),
            );
          }
        },
      ),
    );
  }
}
