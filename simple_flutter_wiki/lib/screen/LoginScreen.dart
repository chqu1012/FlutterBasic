import 'package:flutter/material.dart';
import 'package:simple_flutter_wiki/provider/WikiRestProvider.dart';

import 'WikiScreen.dart';

class LoginScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => new _State();
}

class _State extends State<LoginScreen> {
  TextEditingController nameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  bool loginfail = false;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Simple Flutter Wiki',
        theme: new ThemeData(primaryColor: Color.fromRGBO(58, 66, 86, 1.0)),
        debugShowCheckedModeBanner: false,
        home: Scaffold(
            appBar: AppBar(
              title: Text('Login Screen'),
            ),
            body: Padding(
                padding: EdgeInsets.all(10),
                child: ListView(
                  children: <Widget>[
                    Container(
                        alignment: Alignment.center,
                        padding: EdgeInsets.all(10),
                        child: Text(
                          'Simple Wiki Application',
                          style: TextStyle(
                              color: Color.fromRGBO(55, 65, 85, 1.0),
                              fontWeight: FontWeight.w500,
                              fontSize: 30),
                        )),
                    Container(
                      padding: EdgeInsets.all(10),
                      child: TextField(
                        controller: nameController,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'User Name',
                          errorText: loginfail ? 'email not match' : null,
                        ),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
                      child: TextField(
                        obscureText: true,
                        controller: passwordController,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Password',
                          errorText: loginfail ? 'password not match' : null,
                        ),
                      ),
                    ),
                    FlatButton(
                      onPressed: () {
                        //forgot password screen
                      },
                      textColor: Colors.blue,
                      child: Text('Forgot Password'),
                    ),
                    Container(
                        height: 50,
                        padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                        child: RaisedButton(
                          textColor: Colors.white,
                          color: Color.fromRGBO(55, 65, 85, 1.0),
                          child: Text('Login'),
                          onPressed: () {
                            print(nameController.text);
                            print(passwordController.text);
                            login();
                            /*
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (BuildContext context) =>
                                        new WikiPage()));
                                        */
                          },
                        )),
                    Container(
                        child: Row(
                      children: <Widget>[
                        Text('Does not have account?'),
                        FlatButton(
                          textColor: Colors.blue,
                          child: Text(
                            'Sign in',
                            style: TextStyle(fontSize: 20),
                          ),
                          onPressed: () {},
                        )
                      ],
                      mainAxisAlignment: MainAxisAlignment.center,
                    ))
                  ],
                ))));
  }

  Future<void> login() async {
    var provider = WikiRestProvider();
    var response =
        await provider.login(nameController.text, passwordController.text);
    if (response.statusCode == 200) {
      if (response.body == 'true') {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => new WikiPage()));
      } else {
        setState(() {
          loginfail = true;
        });
      }
    } else {
      setState(() {
        loginfail = true;
      });
    }
  }
}
