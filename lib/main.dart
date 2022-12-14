import 'package:dynamic_themes/dynamic_themes.dart';
import 'package:flutter/material.dart';
import '/MyTheme.dart';

import 'MyTheme.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    final themeCollection = ThemeCollection(
      themes: {
        0: MyTheme.defaultTheme,
        1: MyTheme.darkTheme
      },
      fallbackTheme: ThemeData.light(),
    );

    return DynamicTheme(
      themeCollection: themeCollection,
      builder: (context, theme) {
        return MaterialApp(
          title: 'Flutter Demo Login',
          theme: theme,
          home: MyHomePage(title: 'Connexion'),
        );
      },
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);










  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  final formKey = GlobalKey<FormState>();


  final emailController = TextEditingController();

  final String emailPattern =
      r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';

  void _turnOnOffLight() {

    final currentTheme = DynamicTheme.of(context)!.theme;


    if (currentTheme == MyTheme.defaultTheme) {

      DynamicTheme.of(context)!.setTheme(1);
    } else {

      DynamicTheme.of(context)!.setTheme(0);
    }
  }

  void _showDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {

        return AlertDialog(
          title: const Text(":)"),
          content: Text("Bonjour " + emailController.text),
          actions: <Widget>[

            TextButton(
              child: const Text("Ok"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @protected
  void logIn() {
    setState(() {
      if (formKey.currentState!.validate()) {
        _showDialog();
      }
    });
  }

  @override
  void dispose() {

    emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(


        title: Text(widget.title),
        actions: <Widget>[
          IconButton(
              onPressed: _turnOnOffLight, icon: Icon(Icons.lightbulb_outline))
        ],
      ),
      body: Form(
        key: formKey,
        child: Padding(
          padding: const EdgeInsets.all(20),
          child:  Column(
            children: <Widget>[
               TextFormField(
                controller: emailController,
                keyboardType: TextInputType
                    .emailAddress,
                decoration:  const InputDecoration(
                    hintText: 'me@example.com', labelText: 'Adresse email'),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Veuillez saisir votre adresse email';
                  }

                  RegExp regExp =  RegExp(emailPattern);
                  if (!regExp.hasMatch(value)) {
                    return "Veuillez saisir une adresse email valide.";
                  }
                },
              ),
               TextFormField(
                obscureText: true,
                decoration:  const InputDecoration(
                    hintText: '***', labelText: 'Mot de passe'),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Veuillez saisir votre mot de passe';
                  }
                },
              ),
               Container(
                margin:  const EdgeInsets.only(top: 20.0),
                child: Hero(
                    tag: "fabHero",
                    child:  ElevatedButton(
                      onPressed: logIn,
                      child:  const Text('Login'),
                    )),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
