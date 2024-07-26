import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const SignUp();
  }
}

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final formkey = GlobalKey<FormState>();

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
    formkey.currentState!.validate();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Form(
            key: formkey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Emergency Service",
                  style: Theme.of(context).textTheme.titleLarge!.copyWith(
                      fontWeight: FontWeight.bold,
                      fontSize: 40,
                      color: Color.fromARGB(255, 220, 24, 10)),
                ),
                SizedBox(
                  height: 40,
                ),
                Text(
                  "SignUp",
                  style: Theme.of(context).textTheme.titleMedium!.copyWith(
                      fontWeight: FontWeight.w600,
                      fontSize: 40,
                      color: Color.fromARGB(255, 220, 24, 10)),
                ),
                SizedBox(
                  height: 25,
                ),
                CustomForm(hinttext: "Name", controller: nameController),
                SizedBox(
                  height: 15,
                ),
                CustomForm(hinttext: "Email", controller: emailController),
                SizedBox(
                  height: 15,
                ),
                CustomForm(
                    hinttext: "password", controller: passwordController),
                SizedBox(
                  height: 20,
                ),
                SignupLoginButton(buttonname: "SignUp", ontap: () {}),
                RichText(
                  text: TextSpan(
                    text: "Already have an account? ",
                    style: Theme.of(context).textTheme.titleMedium,
                    children: [
                      WidgetSpan(
                        child: GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => LogIn()),
                            );
                          },
                          child: Text(
                            "LogIn",
                            style: TextStyle(
                              color: Colors.red,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class LogIn extends StatefulWidget {
  const LogIn({
    super.key,
  });

  @override
  State<LogIn> createState() => _LogInState();
}

class _LogInState extends State<LogIn> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final formkey = GlobalKey<FormState>();
  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: EdgeInsets.all(12.0),
        child: Form(
          key: formkey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "LogIn",
                style: TextStyle(
                  color: Colors.red,
                  fontWeight: FontWeight.bold,
                  fontSize: 38,
                ),
              ),
              SizedBox(
                height: 30,
              ),
              CustomForm(controller: emailController, hinttext: "Email"),
              SizedBox(
                height: 15,
              ),
              CustomForm(
                controller: passwordController,
                hinttext: "Password",
                isObscure: true,
              ),
              SizedBox(
                height: 30,
              ),
              SignupLoginButton(
                buttonname: "LOGIN",
                ontap: () {},
              ),
              SizedBox(
                height: 10,
              ),
              RichText(
                  text: TextSpan(
                      text: "Don't have an account? ",
                      style: Theme.of(context).textTheme.titleMedium,
                      children: [
                    TextSpan(
                        text: "LogIn",
                        style: TextStyle(
                            color: Colors.red, fontWeight: FontWeight.bold))
                  ]))
            ],
          ),
        ),
      ),
    );
  }
}

class CustomForm extends StatelessWidget {
  const CustomForm(
      {super.key,
      required this.hinttext,
      required this.controller,
      this.isObscure = false});

  final TextEditingController controller;
  final String hinttext;
  final bool isObscure;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      obscureText: isObscure,
      validator: (value) {
        if (value!.trim().isEmpty) {
          return "$hinttext is required";
        }
        return null;
      },
      obscuringCharacter: "*",
      decoration: InputDecoration(
        contentPadding: EdgeInsets.all(10),
        hintText: hinttext,
        enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(
              width: 3,
              color: Color.fromARGB(255, 186, 18, 6),
            ),
            borderRadius: BorderRadius.circular(8)),
        focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
              width: 3,
              color: Colors.black,
            ),
            borderRadius: BorderRadius.circular(8)),
      ),
    );
  }
}

class SignupLoginButton extends StatelessWidget {
  const SignupLoginButton(
      {super.key, required this.buttonname, required this.ontap});
  final String buttonname;
  final VoidCallback ontap;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(7),
          gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                Colors.red,
                Color.fromARGB(255, 220, 24, 10),
                const Color.fromARGB(255, 173, 16, 5),
              ])),
      child: ElevatedButton(
        onPressed: ontap,
        style: ElevatedButton.styleFrom(
            fixedSize: Size(395, 55),
            backgroundColor: Colors.transparent,
            shadowColor: Colors.transparent),
        child: Text(
          buttonname,
          style: TextStyle(color: Colors.white),
        ),
      ),
    );
  }
}
