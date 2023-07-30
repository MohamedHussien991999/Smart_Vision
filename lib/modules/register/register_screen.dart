// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_farm/modules/register/cubit/cubit.dart';
import 'package:smart_farm/modules/register/cubit/states.dart';
import '../../shared/components/components.dart';
import '../login/login_screen.dart';

class PlantRegisterScreen extends StatelessWidget {
  const PlantRegisterScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => PlantRegisterCubit(),
      child: BlocConsumer<PlantRegisterCubit, PlantRegisterStates>(
        listener: (context, state) {
          if (state is PlantRegisterSuccessState) {
            showCustom(
                context, state.loginModel.message!, Colors.green, Icons.check);
            navigateAndFinish(context, const LoginScreen());
          } else if (state is PlantRegisterErrorState) {
            Navigator.of(context).pop();
            showDialog(
              barrierDismissible: false,
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  actions: [
                    TextButton(
                      onPressed: () {
                        // Perform any desired action here
                        Navigator.of(context).pop(); // Close the dialog
                      },
                      child: const Text(
                        'Close',
                        style: TextStyle(fontSize: 25),
                      ),
                    ),
                  ],
                  content: SizedBox(
                    width: 100,
                    height: 100,
                    child: Center(
                      child: Text(state.error),
                    ),
                  ),
                );
              },
            );
          }
        },
        builder: (context, state) {
          PlantRegisterCubit cubit = PlantRegisterCubit.get(context);
          return Scaffold(
            appBar: AppBar(
              centerTitle: true,
              backgroundColor: const Color(0xFF34D399),
              title: ListTile(
                leading: Icon(
                  cubit.appBarIcon[cubit.activeCurrentStep],
                  color: Colors.white,
                ),
                title: Text(
                  " ${cubit.appBarName[cubit.activeCurrentStep]}",
                  style: const TextStyle(color: Colors.white, fontSize: 20.0),
                ), //1-firstName
              ),
            ),
            body: Stepper(
              controlsBuilder: (context, details) {
                return Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: const <Widget>[],
                );
              },

              steps: cubit.stepList(),
              currentStep: cubit.activeCurrentStep,
              type: StepperType.horizontal,

              onStepTapped: (int index) {
                if (cubit.checkVAlidation()) {
                  cubit.changeCurrentStep(index: 2, val: index);
                }
              },
              // This needs to be changed
            ),
            bottomNavigationBar: BottomAppBar(
              child: SizedBox(
                height: 120,
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        TextButton(
                          onPressed: () {
                            if (cubit.checkVAlidation()) {
                              cubit.changeCurrentStep(index: 1);
                            }
                          },
                          child: Container(
                            width: 100,
                            padding: const EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              color: const Color.fromARGB(255, 11, 219,
                                  153), // Replace with the desired color
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: const Text(
                              '\t\t Back',
                              style: TextStyle(
                                color:
                                    Colors.white, // Set the text color to white
                                fontSize: 20,
                              ),
                            ),
                          ),
                        ),
                        TextButton(
                          onPressed: () {
                            if (cubit.checkVAlidation()) {
                              cubit.changeCurrentStep(index: 0);
                              if (cubit.count >= 3) {
                                cubit.userRegister(context: context);
                              }
                            }
                          },
                          child: Container(
                            width: 100,
                            padding: const EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              color: const Color.fromARGB(255, 11, 219,
                                  153), // Replace with the desired color
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: cubit.activeCurrentStep == 2
                                ? const Text('Submit',
                                    style: TextStyle(
                                      color: Colors
                                          .white, // Set the text color to white
                                      fontSize: 20,
                                    ))
                                : const Text(
                                    '\t\t Next',
                                    style: TextStyle(
                                      color: Colors
                                          .white, // Set the text color to white
                                      fontSize: 20,
                                    ),
                                  ),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text("Have an account?"),
                        TextButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            child: const Text("Login"))
                      ],
                    )
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
