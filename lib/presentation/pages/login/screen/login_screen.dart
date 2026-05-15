import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:zesty_go_resturant/presentation/routes/app_routes.dart';
import '../../../common_widget/custom_text_field.dart';
import '../../../const/app_const_dimensions.dart';
import '../../../const/styles.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(
            Dimensions.PADDING_SIZE_OVER_EXTRA_LARGE,
          ),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                 const SizedBox(height: 80),

                 Text(
                   'Login',
                   style: displayBase(context)?.copyWith(
                     fontSize: 32,
                     fontWeight: FontWeight.bold,
                     color: const Color(0xFF1F2C52),
                   ),
                 ),

                 const SizedBox(height: 50),

                 CustomTextField(
                   header: 'E-mail',
                   hintText: 'Enter your email',
                   controller: _emailController,
                   inputType: TextInputType.emailAddress,
                   validator: (value) {
                     if (value == null || value.isEmpty)
                       return 'Email is required';
                     return null;
                   },
                 ),

                 const SizedBox(height: Dimensions.PADDING_SIZE_LARGE),

                 CustomTextField(
                   header: 'Password',
                   hintText: 'Enter your password',
                   isPassword: true,
                   controller: _passwordController,
                   inputAction: TextInputAction.done,
                   validator: (value) {
                     if (value == null || value.isEmpty)
                       return 'Password is required';
                     return null;
                   },
                 ),

                 const SizedBox(height: 40),

                 ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      Get.offAllNamed(RouteName.BOTTOM_NAV_SCREEN);
                    }
                  },
                   style: ElevatedButton.styleFrom(
                     backgroundColor: const Color(0xFFFBB03B),
                     shape: const StadiumBorder(),
                     minimumSize: const Size(
                       double.infinity,
                       Dimensions.BUTTON_DEFAULT_HIGHT,
                     ),
                     elevation: 0,
                   ),
                  child: Text('Login', style: buttonTextStyle(context)),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
