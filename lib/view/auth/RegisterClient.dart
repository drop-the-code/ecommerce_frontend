import 'package:ecommerce_frontend/model/User.dart';
import 'package:ecommerce_frontend/shared/store/user_store.dart';
import 'package:ecommerce_frontend/shared/user_session.dart';
import 'package:ecommerce_frontend/validators/basic_validator.dart';
import 'package:flutter/material.dart';
import 'package:ecommerce_frontend/view/components/TextPasswordField.dart';

class RegisterPage extends StatefulWidget {
  RegisterPage({Key key, this.title}) : super(key: key);
  final String id = "";
  final String title;

  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final TextEditingController email = TextEditingController();

  final TextEditingController name = TextEditingController();
  final TextEditingController cpf = TextEditingController();
  final TextEditingController address = TextEditingController();

  final TextEditingController password = TextEditingController();

  final TextEditingController passwordVerification = TextEditingController();
  final TextEditingController securityCode = TextEditingController();
  final TextEditingController number = TextEditingController();
  final TextEditingController nameCard = TextEditingController();
  final TextEditingController validThru = TextEditingController();

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
                          validator: BasicValidator.validEmail,
                          decoration: InputDecoration(
                            labelText: "Digite o email",
                            icon: Icon(Icons.email),
                          )),
                      TextFormField(
                          controller: name,
                          validator: BasicValidator.validBasic,
                          decoration: InputDecoration(
                              labelText: "Digite  seu nome",
                              icon: Icon(Icons.person))),
                      TextFormField(
                          controller: cpf,
                          validator: BasicValidator.validBasic,
                          decoration: InputDecoration(
                              labelText: "Digite  seu CPF",
                              icon: Icon(Icons.person))),
                      TextFormField(
                          controller: address,
                          validator: BasicValidator.validBasic,
                          decoration: InputDecoration(
                              labelText: "Digite  seu endereço",
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
                      TextFormField(
                          controller: securityCode,
                          validator: BasicValidator.validBasic,
                          decoration: InputDecoration(
                              labelText: "Digite o cvv do cartão",
                              icon: Icon(Icons.person))),
                      TextFormField(
                          controller: number,
                          validator: BasicValidator.validBasic,
                          decoration: InputDecoration(
                              labelText: "Digite o numero do cartao",
                              icon: Icon(Icons.person))),
                      TextFormField(
                          controller: nameCard,
                          validator: BasicValidator.validBasic,
                          decoration: InputDecoration(
                              labelText: "Digite o nome que está no cartão ",
                              icon: Icon(Icons.person))),
                      TextFormField(
                          controller: validThru,
                          validator: BasicValidator.validBasic,
                          decoration: InputDecoration(
                              labelText: "Digite a validade do cartao",
                              icon: Icon(Icons.person))),
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
                              Map<String, dynamic> data = {
                                "name": name.text,
                                "cpf": cpf.text,
                                "address": address.text,
                              };
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
