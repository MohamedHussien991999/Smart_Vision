import 'package:babstrap_settings_screen/babstrap_settings_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_farm/modules/settings/cubit_settings/cubit_settings.dart';
import 'package:smart_farm/modules/settings/cubit_settings/states_settings.dart';
import 'package:smart_farm/shared/components/components.dart';

import '../../shared/components/constants.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => SettingsCubit(),
      child: BlocConsumer<SettingsCubit, SettingsStates>(
        listener: (context, state) {
          if (state is SettingsErrorState) {
            if (state.popUpdateImage == "Updating Image ...") {
              Navigator.pop(context);
            }
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
          } else if (state is SettingsSuccessState) {
            if (state.popUpdateImageSuccess == "Updating Image ...") {
              Navigator.pop(context);
            }
            showCustom(context, state.message, Colors.green, Icons.check);
          } else if (state is SettingsLoadingState) {
            showDialog(
              context: context,
              builder: (context) {
                return AlertDialog(
                  title: Text(state.stateNow),
                  content: const SizedBox(
                    width: 100,
                    height: 100,
                    child: Center(
                      child: CircularProgressIndicator(),
                    ),
                  ),
                );
              },
            );
          }
        },
        builder: (context, state) {
          SettingsCubit cubit = SettingsCubit.get(context);
          return Scaffold(
            body: WillPopScope(
              onWillPop: onWillPop,
              child: Padding(
                padding: const EdgeInsets.all(30),
                child: ListView(
                  children: [
                    const Center(
                        child: Text(
                      "Settings ",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 45,
                        fontFamily: "gillsans",
                      ),
                    )),
                    const SizedBox(
                      height: 20.0,
                    ),
                    Container(
                      margin: const EdgeInsets.only(
                        bottom: 20,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.greenAccent,
                        borderRadius: BorderRadius.circular(30.0),
                      ),
                      child: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const SizedBox(
                              height: 25,
                            ),
                            Center(
                              child: Text(
                                "${loginModelFinal!.userName}",
                                style: const TextStyle(
                                    fontSize: 30, fontFamily: "gillsans"),
                              ),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            Container(
                              decoration: BoxDecoration(
                                  image: DecorationImage(
                                    scale: 5.0,
                                    image: FileImage(
                                        loginModelFinal!.imageProfile!),
                                    fit: BoxFit.fill,
                                  ),
                                  shape: BoxShape.circle,
                                  border: Border.all(
                                    color: Colors.grey,
                                    width: 5.0,
                                  )),
                              height: 170,
                              width: 170,
                            ),
                            Container(
                              margin: const EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(50),
                                color: Theme.of(context).cardColor,
                              ),
                              child: SettingsItem(
                                icons: Icons.edit,
                                iconStyle: IconStyle(
                                  withBackground: true,
                                  borderRadius: 50,
                                  backgroundColor: Colors.yellow[600],
                                ),
                                title: "Edit",
                                subtitle: "Tap to Edit your Photo ",
                                onTap: () {
                                  cubit.updateImage(context);
                                },
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            )
                          ],
                        ),
                      ),
                    ),
                    // User card

                    //"Edit Account"
                    SettingsGroup(
                      settingsGroupTitle: "Edit Account",
                      items: [
                        SettingsItem(
                          onTap: () {
                            cubit.updatePersonalInformationScreen(context);
                          },
                          iconStyle: IconStyle(),
                          icons: CupertinoIcons.info_circle,
                          title: "Personal Information",
                        ),
                        SettingsItem(
                          onTap: () {
                            cubit.updateAccountInformationScreen(context);
                          },
                          iconStyle: IconStyle(
                            backgroundColor: Colors.purple,
                          ),
                          icons: CupertinoIcons.person,
                          title: "Account Information",
                        ),
                        SettingsItem(
                          onTap: () {
                            cubit.updateContactInformationScreen(context);
                          },
                          iconStyle: IconStyle(
                            iconsColor: Colors.white,
                            withBackground: true,
                            backgroundColor: Colors.red,
                          ),
                          icons: CupertinoIcons.location_solid,
                          title: "Contact Information",
                        ),
                        SettingsItem(
                          onTap: () {
                            cubit.updatePasswordScreen(context);
                          },
                          iconStyle: IconStyle(
                            backgroundColor:
                                const Color.fromARGB(255, 39, 176, 41),
                          ),
                          icons: CupertinoIcons.lock,
                          title: "Update Password",
                        ),
                      ],
                    ),
                    SettingsGroup(items: [
                      SettingsItem(
                        onTap: () {
                          cubit.signOut(context);
                        },
                        iconStyle: IconStyle(
                          backgroundColor: Colors.blueGrey,
                        ),
                        icons: Icons.exit_to_app_rounded,
                        title: "Sign Out",
                      ),
                    ]),
                    SettingsGroup(items: [
                      SettingsItem(
                        onTap: () {
                          cubit.deleteUser(context);
                        },
                        icons: CupertinoIcons.delete_solid,
                        title: "Delete account",
                        titleStyle: const TextStyle(
                          color: Colors.red,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ]),
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
