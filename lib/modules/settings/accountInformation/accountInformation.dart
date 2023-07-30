import 'package:flutter/material.dart';
import 'package:smart_farm/shared/components/components.dart';
import 'package:smart_farm/shared/components/constants.dart';

class AccountInformation extends StatelessWidget {
  final TextEditingController firstNameController;
  final TextEditingController lastNameController;
  final TextEditingController userNameController;
  final TextEditingController emailController;

  const AccountInformation({
    Key? key,
    required this.firstNameController,
    required this.lastNameController,
    required this.userNameController,
    required this.emailController,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
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
                    hint: loginModelFinal!.firstName,
                    prefix: Icons.lock,
                    controller: firstNameController,
                    type: TextInputType.text,
                    label: 'First name',
                    validate: (value) {
                      if (value == "") {
                        firstNameController.text = loginModelFinal!.firstName!;
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
                    hint: loginModelFinal!.lastName,
                    prefix: Icons.lock,
                    controller: lastNameController,
                    type: TextInputType.name,
                    label: 'Last Name',
                    validate: (value) {
                      if (value == "") {
                        lastNameController.text = loginModelFinal!.lastName!;
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
                    hint: loginModelFinal!.userName,
                    prefix: Icons.lock,
                    controller: userNameController,
                    type: TextInputType.name,
                    label: ' User Name ',
                    validate: (value) {
                      if (value == "") {
                        userNameController.text = loginModelFinal!.userName!;
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
                    hint: loginModelFinal!.email,
                    prefix: Icons.lock,
                    controller: emailController,
                    type: TextInputType.name,
                    label: ' Email ',
                    validate: (value) {
                      if (value == "") {
                        emailController.text = loginModelFinal!.email!;
                      } else if (!value!.contains('@')) {
                        return '     Enter Valid Email ';
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
            ]),
          ],
        ),
      ),
    );
  }
}
