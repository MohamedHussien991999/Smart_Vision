import 'package:flutter/material.dart';
import 'package:smart_farm/shared/components/components.dart';
import '../../../shared/components/constants.dart';

class PersonalInformation extends StatelessWidget {
  final TextEditingController roleController;
  final TextEditingController workFieldController;
  final TextEditingController usageTargetController;
  final TextEditingController featuresController;

  const PersonalInformation({
    Key? key,
    required this.roleController,
    required this.workFieldController,
    required this.usageTargetController,
    required this.featuresController,
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
                  const Text("1) Role :", style: TextStyle(fontSize: 20)),
                  const SizedBox(
                    height: 12,
                  ),
                  defaultTextFormField(
                    hint: loginModelFinal!.role,
                    controller: roleController,
                    type: TextInputType.text,
                    label: 'Role',
                    validate: (value) {
                      if (value == "") {
                        roleController.text = loginModelFinal!.role!;
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
                  const Text("2) Work Field :", style: TextStyle(fontSize: 20)),
                  const SizedBox(
                    height: 12,
                  ),
                  defaultTextFormField(
                    hint: loginModelFinal!.workField,
                    prefix: Icons.business_center,
                    controller: workFieldController,
                    type: TextInputType.text,
                    label: 'Work Field',
                    validate: (value) {
                      if (value == "") {
                        workFieldController.text = loginModelFinal!.workField!;
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
                  const Text("3) Usage Target :",
                      style: TextStyle(fontSize: 20)),
                  const SizedBox(
                    height: 12,
                  ),
                  defaultTextFormField(
                    hint: loginModelFinal!.usageTarget,
                    prefix: Icons.business_center,
                    controller: usageTargetController,
                    type: TextInputType.text,
                    label: 'Usage Target',
                    validate: (value) {
                      if (value == "") {
                        usageTargetController.text =
                            loginModelFinal!.usageTarget!;
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
                  const Text("4) Features :", style: TextStyle(fontSize: 20)),
                  const SizedBox(
                    height: 12,
                  ),
                  defaultTextFormField(
                    controller: featuresController,
                    type: TextInputType.text,
                    label: 'Features',
                    validate: (value) {
                      if (value == "") {
                        featuresController.text = "";
                      }
                    },
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                ],
              ),
            ]),
          ],
        ),
      ),
    );
  }
}
