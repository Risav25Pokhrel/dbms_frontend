import 'package:flutter/material.dart';
import 'package:ticketingmanagementsystem/notifier.dart/notifiers.dart';
import 'package:ticketingmanagementsystem/requests/checkuser.dart';
import 'package:ticketingmanagementsystem/utils/fonts.dart';
import 'package:ticketingmanagementsystem/widgets/mybutton.dart';
import 'package:ticketingmanagementsystem/widgets/mytextfield.dart';

class Loginpage extends StatefulWidget {
  const Loginpage({super.key});

  @override
  State<Loginpage> createState() => _LoginpageState();
}

class _LoginpageState extends State<Loginpage> {
  final username = TextEditingController();
  final password = TextEditingController();
  @override
  void dispose() {
    username.dispose();
    password.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Center(
      child: Card(
        elevation: 10,
        shadowColor: Colors.blue,
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: SizedBox(
            width: size.width * 0.3,
            height: size.height * 0.62,
            child: Column(
              children: [
                Text("Login Page",
                    style: MyFont.headline.copyWith(fontSize: 35)),
                SizedBox(
                    width: size.width * 0.15,
                    height: 200,
                    child: Image.asset("assets/logo.png", fit: BoxFit.cover)),
                MyTextFormField(
                    controller: username,
                    labelText: "UserName",
                    prefixIcon: Icons.person),
                const Spacer(),
                MyTextFormField(
                    controller: password,
                    labelText: "Passsword",
                    obscureText: true,
                    prefixIcon: Icons.lock),
                const Spacer(),
                ValueListenableBuilder(
                  valueListenable: loading,
                  builder: (context, value, child) => MyButton(
                      loading: value,
                      isAbsorbed: value,
                      title: "Login",
                      onTap: () async {
                        loading.value = true;
                        // await checkuser(
                        //     username: username.text.toString(),
                        //     password: password.text.toString());

                        await registerUser(
                            username: username,
                            password: password,
                            phone: "980000000");

                        /// use function call backend

                        loading.value = false;
                      }),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
