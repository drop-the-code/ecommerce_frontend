import 'package:flutter/material.dart';
import 'package:ecommerce_frontend/view/components/TextPasswordField.dart';

class RegisterPage extends StatelessWidget {
  RegisterPage({Key key, this.title}) : super(key: key);
  final TextEditingController email = new TextEditingController();
  final TextEditingController name = new TextEditingController();
  final TextEditingController password = new TextEditingController();
  final TextEditingController passwordVerification = new TextEditingController();
  final String title;
  final _formKey = GlobalKey<FormState>();

  bool validPasswordAndPasswordVerificationTheSame(String value) {
    return ((value.length > 0 && passwordVerification.text.length > 0) &&
        value != passwordVerification.text);
  }

  String _validPasswordVerification(String value) {
    if (value.isEmpty) {
      return 'Não deixar campos vazios';
    }
    if (password.text != passwordVerification.text) {
      return 'Senhas não coincidem';
    }
    return null;
  }

  String _validPassword(String value) {
    if (value.isEmpty) {
      return 'Não deixar campos vazios';
    }
    if (validPasswordAndPasswordVerificationTheSame(value)) {
      return 'Senhas não coincidem';
    }
  }

  String _validBasic(String value) {
    if (value.isEmpty) {
      return 'Não deixar campos vazios';
    }
    return null;
  }

  String _validEmail(String value) {
    if (value.isEmpty) {
      return 'Não deixar campos vazios';
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.white24,
        child: Center(
          child: Container(
            height: 600,
            width: 600,
            child: Form(
              key: _formKey,
              child: Card(
                color: Colors.white,
                elevation: 15,
                child: Padding(
                  padding: const EdgeInsets.only(left: 50.0, right: 50.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(bottom: 30.0),
                        child: Text(
                          "Acesse a  plataforma",
                          style: TextStyle(fontSize: 20),
                        ),
                      ),
                      TextFormField(
                          controller: email,
                          validator: _validEmail,
                          decoration: InputDecoration(
                            labelText: "Digite o email",
                            icon: Icon(Icons.email),
                          )),
                      TextFormField(
                          validator: _validBasic,
                          decoration: InputDecoration(
                              labelText: "Digite  seu nome",
                              icon: Icon(Icons.person))),
                      TextPasswordField(
                        validator: _validPassword,
                        controller: password,
                        obscureText: true,
                        labelText: "Digite sua senha",
                      ),
                      TextPasswordField(
                        validator: _validPasswordVerification,
                        controller: passwordVerification,
                        obscureText: true,
                        labelText: "Digite sua senha novamente",
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 20),
                        child: ElevatedButton.icon(
                          style: ElevatedButton.styleFrom(
                              padding: EdgeInsets.symmetric(
                                  vertical: 15, horizontal: 80)),
                          icon: Icon(Icons.login),
                          onPressed: () {
                            if (_formKey.currentState.validate()) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(content: Text('INSIDE IF')));
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(content: Text('OUTSIDE IF')));
                            }
                          },
                          label: Text("Cadastrar"),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 20),
                        child: OutlinedButton.icon(
                          style: ElevatedButton.styleFrom(
                              padding: EdgeInsets.symmetric(
                                  vertical: 15, horizontal: 64)),
                          icon: Icon(Icons.person_add),
                          onPressed: () {
                            Navigator.of(context)
                                .pushReplacementNamed('/login');
                          },
                          label: Text("Voltar"),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
