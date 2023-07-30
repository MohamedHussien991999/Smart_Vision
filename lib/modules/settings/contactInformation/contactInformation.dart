// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:smart_farm/shared/components/components.dart';
import 'package:smart_farm/shared/components/constants.dart';

class ContactInformation extends StatelessWidget {
  TextEditingController phoneNumberController;
  TextEditingController streetNameController;
  TextEditingController cityController;
  TextEditingController stateController;
  TextEditingController countryController;
  TextEditingController postCodeController;

  ContactInformation({
    Key? key,
    required this.phoneNumberController,
    required this.streetNameController,
    required this.cityController,
    required this.stateController,
    required this.countryController,
    required this.postCodeController,
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
                  const Text("1) Phone Number :",
                      style: TextStyle(fontSize: 20)),
                  const SizedBox(
                    height: 12,
                  ),
                  defaultTextFormField(
                    hint: loginModelFinal!.phoneNumber,
                    prefix: Icons.phone,
                    controller: phoneNumberController,
                    type: TextInputType.text,
                    label: 'Phone Number',
                    validate: (value) {
                      if (value == "") {
                        phoneNumberController.text =
                            loginModelFinal!.phoneNumber!;
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
                    hint: loginModelFinal!.streetName,
                    prefix: Icons.add_road,
                    controller: streetNameController,
                    type: TextInputType.text,
                    label: 'Street Name',
                    validate: (value) {
                      if (value == "") {
                        streetNameController.text =
                            loginModelFinal!.streetName!;
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
                    hint: loginModelFinal!.city,
                    prefix: Icons.location_city,
                    controller: cityController,
                    type: TextInputType.text,
                    label: 'City',
                    validate: (value) {
                      if (value == "") {
                        cityController.text = AutofillHints.addressCity;
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
                    hint: loginModelFinal!.state,
                    prefix: Icons.location_on_outlined,
                    controller: stateController,
                    type: TextInputType.text,
                    label: 'State',
                    validate: (value) {
                      if (value == "") {
                        stateController.text = loginModelFinal!.state!;
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
                    hint: loginModelFinal!.country,
                    prefix: Icons.flag,
                    controller: countryController,
                    type: TextInputType.text,
                    label: 'Country',
                    validate: (value) {
                      if (value == "") {
                        countryController.text = loginModelFinal!.country!;
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
                    hint: loginModelFinal!.postCode,
                    prefix: Icons.local_post_office_sharp,
                    controller: postCodeController,
                    type: TextInputType.text,
                    label: 'Post Code',
                    validate: (value) {
                      if (value == "") {
                        postCodeController.text = loginModelFinal!.postCode!;
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
