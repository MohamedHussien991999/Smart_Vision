// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../layout/plantlayoutscreen.dart';
import '../../shared/components/components.dart';
import 'cubit/detection_cubit.dart';
import 'cubit/detection_states.dart';
import 'details_test/image_details_screen_details_test .dart';

class PlantDetectionsImageScreen extends StatelessWidget {
  ImageProvider<Object>? imageFound;

  PlantDetectionsImageScreen({super.key, required this.imageFound});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => DetectionCubit(),
      child: BlocConsumer<DetectionCubit, DetectionStates>(
        listener: (context, state) {
          if (state is DetectionErrorState) {
            Navigator.of(context).pop();
            showDialog(
              barrierDismissible: false,
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  actions: [
                    TextButton(
                      onPressed: () {
                        navigateAndFinish(context, const PlantLayoutScreen());
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
          } else if (state is DetectionSuccessState) {
            showCustom(context, state.message, Colors.green, Icons.check);
            navigateAndFinish(
                context,
                ImageDetailsScreenDetailTest(
                  des: state.modelPlantDetails,
                ));
          } else if (state is DetectionLoadingState) {
            showDialog(
              barrierDismissible: false,
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
          DetectionCubit cubit = DetectionCubit.get(context);
          bool isAtLeastOneSelected = cubit.selectedModels.isNotEmpty;
          return Scaffold(
            appBar: AppBar(
              centerTitle: true,
              automaticallyImplyLeading: false,
              backgroundColor: Colors.white,
              title: const Text(
                "Detections Image",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 30,
                  fontFamily: "gillsans",
                ),
              ),
            ),
            body: Padding(
              padding: const EdgeInsets.all(10.0),
              child: ListView(
                padding: const EdgeInsets.all(10),
                children: <Widget>[
                  Container(
                    width: double.infinity,
                    height: MediaQuery.of(context).size.height * .5,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: imageFound!,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  const Divider(height: 20),
                  const Center(
                    child: Text(
                      'Choose Model',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const Divider(height: 20, thickness: 5),
                  ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: cubit.imageAvailableModels.length,
                    itemBuilder: (context, index) {
                      String model = cubit.imageAvailableModels[index];
                      String description =
                          cubit.imageFeatureDescriptions[index];
                      return CheckboxListTile(
                        subtitle: Text(description),
                        title: Text(model),
                        value: cubit.selectedModels.contains(model),
                        onChanged: (bool? value) {
                          cubit.handleModelSelection(value!, model);
                        },
                      );
                    },
                  ),
                ],
              ),
            ),
            bottomNavigationBar: BottomAppBar(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  GestureDetector(
                    onTap: () {
                      navigateAndFinish(context, const PlantLayoutScreen());
                    },
                    child: Container(
                      margin:
                          const EdgeInsets.only(top: 10, bottom: 15, left: 10),
                      alignment: Alignment.center,
                      width: MediaQuery.of(context).size.width / 2 - 30,
                      height: 50,
                      decoration: BoxDecoration(
                        color: const Color(0XFF0D6EFD),
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: const Text(
                        "Back",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'switzer',
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  GestureDetector(
                    onTap: isAtLeastOneSelected
                        ? () async {
                            await cubit.processModelImage();
                          }
                        : null,
                    child: Container(
                      alignment: Alignment.center,
                      margin:
                          const EdgeInsets.only(top: 10, bottom: 15, right: 10),
                      width: MediaQuery.of(context).size.width / 2 - 30,
                      height: 50,
                      decoration: BoxDecoration(
                        color: isAtLeastOneSelected
                            ? const Color.fromARGB(255, 11, 219, 153)
                            : Colors.grey,
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: const Text(
                        "Process",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'switzer',
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
