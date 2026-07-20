import 'package:flutter/material.dart';
import 'package:inixindo/widgets/forms/form_input.dart';

class LoginPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _LoginPageState();
  }
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController _usernameC = TextEditingController();
  TextEditingController _passwordC = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.network(
              "https://inixindojogja.co.id/wp-content/uploads/2023/05/logoweb.png",
            ),
            Text(
              "Selamat Datang Kembali",
              style: TextStyle(fontSize: 20, overflow: TextOverflow.clip),
            ),
            FormInput(
              controller: _usernameC,
              labelText: "Username",
              obscureText: false,
              keyboardType: TextInputType.emailAddress,
              icon: Icons.email,
            ),
            FormInput(
              controller: _passwordC,
              labelText: "Password",
              obscureText: true,
              icon: Icons.key,
              suffixIcon: Icon(Icons.visibility),
              suffixIcon2: Icon(Icons.visibility_off),
            ),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: actionLogin,
                label: Text("Login"),
                icon: Icon(Icons.login),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void actionLogin() {
    print(_passwordC.text);
    print(_usernameC.text);
  }
}
