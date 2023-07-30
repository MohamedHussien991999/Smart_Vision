import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_farm/modules/login/cubit/cubit.dart';
import 'package:smart_farm/modules/login/cubit/states.dart';
import '../../layout/plantlayoutscreen.dart';
import '../../shared/components/components.dart';
import '../register/register_screen.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController emailController = TextEditingController();
    TextEditingController passwordController = TextEditingController();
    GlobalKey<FormState> formKey = GlobalKey<FormState>();
    return BlocProvider(
      create: (BuildContext context) => PlantLoginCubit(),
      child: BlocConsumer<PlantLoginCubit, PlantLoginStates>(
        listener: (context, state) {
          if (state is PlantLoginSuccessStates) {
            showCustom(context, state.loginMessaga, Colors.green, Icons.check);

            navigateAndFinish(context, const PlantLayoutScreen());
          }
          if (state is PlantLoginErrorStates) {
            showCustom(context, state.error, Colors.red, Icons.error);
          }
        },
        builder: (context, state) {
          PlantLoginCubit cubit = PlantLoginCubit.get(context);
          return Scaffold(
            appBar: AppBar(
              automaticallyImplyLeading: false,
              backgroundColor: Colors.green,
            ),
            body: WillPopScope(
              onWillPop: onWillPop,
              child: Form(
                key: formKey,
                child: Center(
                  child: SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Center(
                              child: Icon(
                                Icons.eco,
                                size: 150,
                                color: Colors.green,
                              ),
                            ),
                            Center(
                              child: Text(
                                'LOGIN',
                                style: Theme.of(context)
                                    .textTheme
                                    .headlineMedium!
                                    .copyWith(
                                      color: Colors.black,
                                    ),
                              ),
                            ),
                            const SizedBox(height: 20.0),
                            Center(
                              child: Text(
                                'Login now to Detect The Plant Disses',
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyLarge!
                                    .copyWith(
                                      color: Colors.grey,
                                    ),
                              ),
                            ),
                            const SizedBox(
                              height: 30.0,
                            ),

                            //email
                            defaultTextFormField(
                              controller: emailController,
                              type: TextInputType.emailAddress,
                              label: 'Email Address',
                              prefix: Icons.email,
                              validate: (String? value) {
                                if (value!.isEmpty) {
                                  return 'please enter your email address';
                                }
                                return null;
                              },
                            ),
                            const SizedBox(
                              height: 15.0,
                            ),

                            //password

                            defaultTextFormField(
                                controller: passwordController,
                                type: TextInputType.text,
                                label: 'Password',
                                isPassword: cubit.isPasswordShown,
                                suffix: cubit.suffix,
                                onSuffixPressed: () {
                                  cubit.changePasswordVisibility();
                                },
                                prefix: Icons.lock,
                                validate: (value) {
                                  if (value == "") {
                                    return 'password is too short';
                                  }
                                  return null;
                                }),

                            const SizedBox(
                              height: 30.0,
                            ),
                            ConditionalBuilder(
                              condition: state is! PlantLoginLoadingStates,
                              builder: (context) => defaultButton(
                                text: "Login",
                                background: Colors.green,
                                function: () {
                                  if (formKey.currentState!.validate()) {
                                    cubit.userLogin(
                                        context: context,
                                        email: emailController.text,
                                        password: passwordController.text);
                                  }
                                },
                              ),
                              fallback: (context) => const Center(
                                  child: CircularProgressIndicator()),
                            ),
                            const SizedBox(
                              height: 15.0,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Text('Don\'t have an account?'),
                                defaultTextButton(
                                  title: 'Register',
                                  onPressed: () {
                                    navigateTo(
                                        context, const PlantRegisterScreen());
                                  },
                                ),
                              ],
                            ),
                          ]),
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
