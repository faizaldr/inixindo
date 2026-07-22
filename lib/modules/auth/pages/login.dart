import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:inixindo/modules/auth/datas/login_api.dart';
import 'package:inixindo/modules/auth/datas/login_db.dart';
import 'package:inixindo/modules/location/pages/location.dart';
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

  final ScrollController _scrollController = ScrollController();

  void scrollKanan() {
    _scrollController.animateTo(
        _scrollController.offset + 600, duration: Duration(seconds: 10),
        curve: Curves.easeIn);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await Future.delayed(Duration(seconds: 1), () {
        scrollKanan();
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(20),
        child: SingleChildScrollView(
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
              SizedBox(
                height: 30,
                child: ListView(
                  controller: _scrollController,
                  scrollDirection: Axis.horizontal,
                  children: [
                    Text("RUMAH KU ISTANA KU"),
                    Text("RUMAH KU ISTANA KU"),
                    Text("RUMAH KU ISTANA KU"),
                    Text("RUMAH KU ISTANA KU"),
                    Text("RUMAH KU ISTANA KU"),
                  ],
                ),
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
      ),
    );
  }

  void actionLogin() async {
    final identifier = _usernameC.text.trim();
    final password = _passwordC.text;
    print(identifier);
    print(password);
    final loginResponse = await LoginApi().login(identifier, password);
    if (loginResponse != null) {
      LoginDb().saveToken(loginResponse.jwt!);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Login Berhasil : ${loginResponse.user!.username}"),
        ),
      );
      Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => LocationPage()));
    } else {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text("Login Gagal")));
    }
  }
}
