// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../config/constants.dart';
import '../../../layout/plantlayoutscreen.dart';
import '../../../model/plant_model.dart';
import '../../../shared/components/components.dart';
import 'cubit/details_cubit.dart';
import 'cubit/details_states.dart';

class DetailsScreen extends StatelessWidget {
  DetailsScreen({Key? key, required this.des}) : super(key: key);
  final Plant des;
  bool isLoadingDeleteImage = true;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => DetailsScreenCubit(),
      child: BlocConsumer<DetailsScreenCubit, DetailsScreenStates>(
          listener: (context, state) {
        if (state is DeleteImageErrorState) {
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
        } else if (state is DeleteImageSuccessState) {
          showCustom(
              context, "Deleting Image success", Colors.green, Icons.check);
          navigateAndFinish(context, const PlantLayoutScreen());
        } else if (state is DetailsScreenLoadingState) {
          isLoadingDeleteImage = false;
          showDialog(
            barrierDismissible: false,
            context: context,
            builder: (context) {
              return const AlertDialog(
                title: Text("Deleting Image Wait..."),
                content: SizedBox(
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
      }, builder: (context, state) {
        DetailsScreenCubit cubit = DetailsScreenCubit.get(context);
        return Scaffold(
          appBar: AppBar(
            centerTitle: true,
            automaticallyImplyLeading: false,
            backgroundColor: Colors.white,
            title: const Text(
              "Details Detection Image ",
              style: TextStyle(
                color: Colors.black,
                fontSize: 28,
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
                    image: FileImage(des.image!),
                    fit: BoxFit.cover,
                  )),
                ),
                const Divider(
                  height: 8,
                  color: deactiveColorIndicator,
                ),
                const SizedBox(
                  height: 30,
                ),
                const SizedBox(
                  height: 30,
                ),
                const Padding(
                  padding: EdgeInsets.only(left: 12.0),
                  child: Center(
                    child: Text(
                      "About Plants",
                      style: TextStyle(fontSize: 40),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 12.0),
                  child: Text(
                    "1) type : ${des.type}",
                    style: const TextStyle(
                        fontSize: 25, color: descriptionTextColor),
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 12.0),
                  child: Text(
                    "2) diseases : ${des.diseases}",
                    style: const TextStyle(
                        fontSize: 25, color: descriptionTextColor),
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 12.0),
                  child: Text(
                    "3) confidence : ${des.confidence}",
                    style: const TextStyle(
                        fontSize: 25, color: descriptionTextColor),
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Text(
                        "4) Result Image  ",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 25,
                          fontFamily: "gillsans",
                        ),
                      )
                    ],
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                des.resultImage != null
                    ? Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Container(
                          height: MediaQuery.of(context).size.height * .5,
                          decoration: BoxDecoration(
                              image: DecorationImage(
                            image: FileImage(des.resultImage!),
                            fit: BoxFit.cover,
                          )),
                        ),
                      )
                    : Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Container(
                          height: MediaQuery.of(context).size.height * .5,
                          decoration: const BoxDecoration(
                              image: DecorationImage(
                            image:
                                AssetImage("assets/images/empty_data_set.png"),
                            fit: BoxFit.cover,
                          )),
                        ),
                      ),
              ],
            ),
          ),
          bottomNavigationBar: BottomAppBar(
            child: BottomAppBar(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
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
                    onTap: isLoadingDeleteImage
                        ? () async {
                            if (des.id != null) {
                              cubit.deleteImage(des.id!);
                            }
                          }
                        : null,
                    child: Container(
                      alignment: Alignment.center,
                      margin:
                          const EdgeInsets.only(top: 10, bottom: 15, right: 10),
                      width: MediaQuery.of(context).size.width / 2 - 30,
                      height: 50,
                      decoration: BoxDecoration(
                        color: isLoadingDeleteImage
                            ? const Color.fromARGB(255, 11, 219, 153)
                            : Colors.grey,
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: const Text(
                        "Delete",
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
          ),
        );
      }),
    );
  }
}
