// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';

import '../../../shared/components/components.dart';

class AccountInformationRegister extends StatelessWidget {
  final TextEditingController firstNameController;
  final TextEditingController lastNameController;
  final TextEditingController userNameController;
  final TextEditingController emailController;
  final TextEditingController passwordController;
  final TextEditingController confirmPasswordController;
  IconData suffix;
  bool isPassword;
  void Function() changePasswordVisibilityRegister;
  GlobalKey<FormState> formKeyUpdatePassword;

  AccountInformationRegister({
    Key? key,
    required this.firstNameController,
    required this.lastNameController,
    required this.userNameController,
    required this.emailController,
    required this.passwordController,
    required this.confirmPasswordController,
    required this.isPassword,
    required this.suffix,
    required this.changePasswordVisibilityRegister,
    required this.formKeyUpdatePassword,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKeyUpdatePassword,
      child: SizedBox(
        width: double.infinity,
        child: Column(
          children: <Widget>[
            ...ListTile.divideTiles(color: Colors.grey, tiles: [
              ListBody(
                children: [
                  const Text("1) First name :", style: TextStyle(fontSize: 20)),
                  const SizedBox(
                    height: 12,
                  ),
                  defaultTextFormField(
                    prefix: Icons.person,
                    controller: firstNameController,
                    type: TextInputType.text,
                    label: 'First name',
                    validate: (value) {
                      if (value == "") {
                        firstNameController.text = "";
                      }
                      return null;
                    },
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              ListBody(
                children: [
                  const Text("2) Last Name :", style: TextStyle(fontSize: 20)),
                  const SizedBox(
                    height: 12,
                  ),
                  defaultTextFormField(
                    prefix: Icons.person,
                    controller: lastNameController,
                    type: TextInputType.name,
                    label: 'Last Name',
                    validate: (value) {
                      if (value == "") {
                        lastNameController.text = "";
                      }
                      return null;
                    },
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              ListBody(
                children: [
                  const Text("3) User Name :", style: TextStyle(fontSize: 20)),
                  const SizedBox(
                    height: 12,
                  ),
                  defaultTextFormField(
                    prefix: Icons.account_circle,
                    controller: userNameController,
                    type: TextInputType.name,
                    label: ' User Name ',
                    validate: (value) {
                      if (value == "") {
                        userNameController.text = "";
                        return '\t\t\t\t\t\t\tUser name must not be empty';
                      }
                      int firstCharCode = value!.codeUnitAt(0);
                      if (!RegExp(r'^[a-z]+$').hasMatch(value)) {
                        return "User name must be lower case only";
                      }
                      if (firstCharCode < 97 || firstCharCode > 122) {
                        return "User name must start with lower case letter";
                      }
                      return null;
                    },
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              ListBody(
                children: [
                  const Text("4) Email :", style: TextStyle(fontSize: 20)),
                  const SizedBox(
                    height: 12,
                  ),
                  defaultTextFormField(
                    prefix: Icons.email,
                    controller: emailController,
                    type: TextInputType.name,
                    label: ' Email ',
                    validate: (value) {
                      if (value == "") {
                        emailController.text = "";
                        return "\t\t\t\t\t\t\tEmail must not be empty";
                      } else if (!value!.contains('@')) {
                        return '\t\t\t\t\t\t\tEnter Valid Email ';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              ListBody(
                children: [
                  const Text("5)  Password :", style: TextStyle(fontSize: 20)),
                  const SizedBox(
                    height: 12,
                  ),
                  defaultTextFormField(
                      controller: passwordController,
                      type: TextInputType.text,
                      label: 'Password',
                      isPassword: isPassword,
                      suffix: suffix,
                      onSuffixPressed: () {
                        changePasswordVisibilityRegister();
                      },
                      prefix: Icons.lock,
                      validate: (value) {
                        if (value == "") {
                          return '\t\t\t\t\t\t\tpassword is too short';
                        }
                        if (value != confirmPasswordController.text) {
                          return '\t\t\t\t\t\t\tpassword is not match';
                        }
                        return null;
                      }),
                  const SizedBox(
                    height: 20,
                  ),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              ListBody(
                children: [
                  const Text("6) Confirm New Password :",
                      style: TextStyle(fontSize: 20)),
                  const SizedBox(
                    height: 12,
                  ),
                  defaultTextFormField(
                      controller: confirmPasswordController,
                      type: TextInputType.text,
                      label: 'confirmPassword',
                      isPassword: isPassword,
                      suffix: suffix,
                      onSuffixPressed: () {
                        changePasswordVisibilityRegister();
                      },
                      prefix: Icons.lock,
                      validate: (value) {
                        if (value == "") {
                          return '\t\t\t\t\t\t\tpassword is too short';
                        }
                        if (value != passwordController.text) {
                          return '\t\t\t\t\t\t\tpassword is not match';
                        }
                        return null;
                      }),
                  const SizedBox(
                    height: 20,
                  ),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
            ]),
          ],
        ),
      ),
    );
  }
}
