import 'package:flutter/material.dart';
import 'dart:async';

class LoginScreen extends StatefulWidget {
  _LoginState createState() => _LoginState();
}



class _LoginState extends State<LoginScreen> {

  final _formKey = GlobalKey<FormState>();

  final FocusNode _userFocus = FocusNode();
  final FocusNode _passFocus = FocusNode();


  void _showDialog(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          content: SizedBox(
            height: 100.0,
            child: Center(
              child: CircularProgressIndicator(),
            ),
          ),
        );
      }
    );
  }

  _navigateToNext(BuildContext context) {
    _showDialog(context);
    const timeout = Duration(seconds: 3);
    Timer.periodic(timeout, (Timer t) {
      Navigator.pushNamedAndRemoveUntil(context, '/main', (Route<dynamic> route) => false);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _buildContent(),
    );
  }

  Widget _buildContent() {
    return SafeArea(
      child: Container(
        child: Center(
          child: _buildForm(),
        ),
      ),
    );
  }

  Widget _buildForm() {
    return SafeArea(
      child: Form(
        key: _formKey,
        child: ListView(
          padding: EdgeInsets.symmetric(horizontal: 24.0),
          children: <Widget>[
            SizedBox(height: 80.0,),
            Column(
              children: <Widget>[
                Image.asset('images/logo.png', scale: 1.5,),
                SizedBox(height: 5.0,)
              ],
            ),
            SizedBox(height: 60.0,),
            TextFormField(
              textInputAction: TextInputAction.next,
              focusNode: _userFocus,
              decoration: InputDecoration(
                labelText: 'Usuário',
                filled: true
              ),
              onFieldSubmitted: (term){
                _userFocus.unfocus();
                FocusScope.of(context).requestFocus(_passFocus);
              },
            ),
            SizedBox(height: 12.0,),
            TextFormField(
              focusNode: _passFocus,
              decoration: InputDecoration(
                labelText: 'Senha',
                filled: true,
              ),
              obscureText: true,
              onFieldSubmitted: (term){
                _passFocus.unfocus();
                _navigateToNext(context);
              },
            ),
            ButtonBar(
              children: <Widget>[
                RaisedButton(
                  child: Text('ENTRAR'),
                  onPressed: (){
                    _showDialog(context);
                    const timeout = Duration(seconds: 3);
                    Timer.periodic(timeout, (Timer t) {
                      Navigator.pushNamedAndRemoveUntil(context, '/main', (Route<dynamic> route) => false);
                    });
                  },
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}