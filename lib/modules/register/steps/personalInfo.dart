// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';

import '../../../shared/components/components.dart';
import '../../../shared/components/constants.dart';

class PersonalInformationRegister extends StatelessWidget {
  final TextEditingController workFieldController;
  final TextEditingController usageTargetController;
  GlobalKey<FormState> formKeyRegisterPersonalInformation;
  String? selectedOption;

  PersonalInformationRegister({
    Key? key,
    required this.workFieldController,
    required this.usageTargetController,
    required this.selectedOption,
    required this.formKeyRegisterPersonalInformation,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Form(
        key: formKeyRegisterPersonalInformation,
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
                    DropdownButtonFormField<String>(
                      value: selectedOption,
                      hint: const Text('Select an option'),
                      validator: (value) =>
                          value == null ? 'field required' : null,
                      items: const [
                        DropdownMenuItem(
                          value: 'farmer',
                          child: Text('Farmer'),
                        ),
                        DropdownMenuItem(
                          value: 'engineer',
                          child: Text('Engineer'),
                        ),
                      ],
                      onChanged: (newValue) {
                        cubitselectedOption = newValue!;
                        print(
                            "selected option is $selectedOption in personal information");
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
                    const Text("2) Work Field :",
                        style: TextStyle(fontSize: 20)),
                    const SizedBox(
                      height: 12,
                    ),
                    defaultTextFormField(
                      prefix: Icons.business_center,
                      controller: workFieldController,
                      type: TextInputType.text,
                      label: 'Work Field',
                      validate: (value) {
                        if (value == "") {
                          workFieldController.text = "";
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
                    const Text("3) Usage Target :",
                        style: TextStyle(fontSize: 20)),
                    const SizedBox(
                      height: 12,
                    ),
                    defaultTextFormField(
                      prefix: Icons.business_center,
                      controller: usageTargetController,
                      type: TextInputType.text,
                      label: 'Usage Target',
                      validate: (value) {
                        if (value == "") {
                          usageTargetController.text = "";
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
      ),
    );
  }
}
