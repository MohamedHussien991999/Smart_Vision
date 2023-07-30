// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';

import '../../../shared/components/components.dart';

class ContactInformationRegister extends StatelessWidget {
  TextEditingController phoneNumberController;
  TextEditingController streetNameController;
  TextEditingController cityController;
  TextEditingController stateController;
  TextEditingController countryController;
  TextEditingController postCodeController;
  GlobalKey<FormState> formKeyContactInformation;
  ContactInformationRegister({
    Key? key,
    required this.phoneNumberController,
    required this.streetNameController,
    required this.cityController,
    required this.stateController,
    required this.countryController,
    required this.postCodeController,
    required this.formKeyContactInformation,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKeyContactInformation,
      child: SizedBox(
        width: double.infinity,
        child: Column(
          children: <Widget>[
            ...ListTile.divideTiles(color: Colors.grey, tiles: [
              ListBody(
                children: [
                  const Text("1) Phone Number :",
                      style: TextStyle(fontSize: 20)),
                  const SizedBox(
                    height: 12,
                  ),
                  defaultTextFormField(
                    prefix: Icons.phone,
                    controller: phoneNumberController,
                    type: TextInputType.text,
                    label: 'Phone Number',
                    validate: (value) {
                      if (value == "") {
                        return "Phone Number must not be empty";
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
                  const Text("2) Street Name :",
                      style: TextStyle(fontSize: 20)),
                  const SizedBox(
                    height: 12,
                  ),
                  defaultTextFormField(
                    prefix: Icons.add_road,
                    controller: streetNameController,
                    type: TextInputType.text,
                    label: 'Street Name',
                    validate: (value) {
                      if (value == "") {
                        streetNameController.text = "";
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
                  const Text("3) City :", style: TextStyle(fontSize: 20)),
                  const SizedBox(
                    height: 12,
                  ),
                  defaultTextFormField(
                    prefix: Icons.location_city,
                    controller: cityController,
                    type: TextInputType.text,
                    label: 'City',
                    validate: (value) {
                      if (value == "") {
                        cityController.text = "";
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
                  const Text("4) State :", style: TextStyle(fontSize: 20)),
                  const SizedBox(
                    height: 12,
                  ),
                  defaultTextFormField(
                    prefix: Icons.location_on_outlined,
                    controller: stateController,
                    type: TextInputType.text,
                    label: 'State',
                    validate: (value) {
                      if (value == "") {
                        stateController.text = "";
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
                  const Text("5) Country :", style: TextStyle(fontSize: 20)),
                  const SizedBox(
                    height: 12,
                  ),
                  defaultTextFormField(
                    prefix: Icons.flag,
                    controller: countryController,
                    type: TextInputType.text,
                    label: 'Country',
                    validate: (value) {
                      if (value == "") {
                        return "Country must not be empty";
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
                  const Text("6) Post Code :", style: TextStyle(fontSize: 20)),
                  const SizedBox(
                    height: 12,
                  ),
                  defaultTextFormField(
                    prefix: Icons.local_post_office_sharp,
                    controller: postCodeController,
                    type: TextInputType.text,
                    label: 'Post Code',
                    validate: (value) {
                      if (value == "") {
                        postCodeController.text = "";
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
