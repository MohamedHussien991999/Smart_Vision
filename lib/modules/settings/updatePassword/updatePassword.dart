import 'package:flutter/material.dart';
import 'package:smart_farm/shared/components/components.dart';

class UpdatePasswordScreen extends StatelessWidget {
  final TextEditingController oldPasswordController;
  final TextEditingController newPasswordController;
  final TextEditingController confirmNewPasswordController;

  const UpdatePasswordScreen({
    Key? key,
    required this.oldPasswordController,
    required this.newPasswordController,
    required this.confirmNewPasswordController,
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
                  const Text("1) Old Password :",
                      style: TextStyle(fontSize: 20)),
                  const SizedBox(
                    height: 12,
                  ),
                  defaultTextFormField(
                    prefix: Icons.lock,
                    controller: oldPasswordController,
                    type: TextInputType.text,
                    label: 'Old Password',
                    validate: (value) {
                      if (value == "") {
                        return '\t\t\t        password is too short';
                      } else if (value!.length < 8) {
                        return '     password is too Slower Than 8 Char';
                      }
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
                  const Text("2) New Password :",
                      style: TextStyle(fontSize: 20)),
                  const SizedBox(
                    height: 12,
                  ),
                  defaultTextFormField(
                    prefix: Icons.lock,
                    controller: newPasswordController,
                    type: TextInputType.name,
                    label: 'New Password',
                    validate: (value) {
                      if (value == "") {
                        return '\t\t\t        password is too short';
                      } else if (value!.length < 8) {
                        return '     password is too Slower Than 8 Char';
                      }
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
                  const Text("3) Confirm New Password :",
                      style: TextStyle(fontSize: 20)),
                  const SizedBox(
                    height: 12,
                  ),
                  defaultTextFormField(
                    prefix: Icons.lock,
                    controller: confirmNewPasswordController,
                    type: TextInputType.name,
                    label: 'Confirm New Password',
                    validate: (value) {
                      if (value == "") {
                        return '\t\t\t        password is too short';
                      } else if (value!.length < 8) {
                        return '     password is too Slower Than 8 Char';
                      }
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
