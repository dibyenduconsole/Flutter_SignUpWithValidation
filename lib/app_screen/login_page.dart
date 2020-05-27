import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:login_signup_ui/utils/curve_painter.dart';

enum AuthMode { LOGIN, SINGUP }

TextEditingController dateCtl = TextEditingController();

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  DateTime selectedDate = DateTime.now();

  Future<Null> _selectDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime(2015, 8),
        lastDate: DateTime(2101));
    if (picked != null && picked != selectedDate)
      setState(() {
        selectedDate = picked;
        dateCtl.text = selectedDate.toLocal().toString().split(' ')[0];
      });
  }

  final GlobalKey<FormState> _signupForm = GlobalKey<FormState>();
  final GlobalKey<FormState> _loginForm = GlobalKey<FormState>();

  String _email;
  String _password;
  String _name;
  String _dob;

  void validateAndSaveSignup() {
    final FormState form = _signupForm.currentState;
    if (form.validate()) {
      print('Sign up Form is valid');
      _showcontent("SignUp","SignUp Successful");
    } else {
      print('Sign up Form is invalid');
    }
  }

  void validateAndSaveLogin() {
    final FormState form = _loginForm.currentState;
    if (form.validate()) {
      print('Login Form is valid');
      _showcontent("Login","Login successful");
    } else {
      print('Login Form is invalid');
    }
  }

void _showcontent(String title, String message) {
    showDialog(
      context: context, barrierDismissible: false, // user must tap button!

      builder: (BuildContext context) {
        return new AlertDialog(
          title: new Text(title),
          content: new SingleChildScrollView(
            child: new ListBody(
              children: [
                new Text(message),
              ],
            ),
          ),
          actions: [
            new FlatButton(
              child: new Text('Close'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  // To adjust the layout according to the screen size
  // so that our layout remains responsive ,we need to
  // calculate the screen height
  double screenHeight;
  // Set intial mode to login
  AuthMode _authMode = AuthMode.LOGIN;
  @override
  Widget build(BuildContext context) {
    screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      body: SingleChildScrollView(
        child: Stack(
          children: <Widget>[
            lowerHalf(context),
            upperHalf(context),
            _authMode == AuthMode.LOGIN
                ? loginCard(context)
                : singUpCard(context),
            pageTitle(),
          ],
        ),
      ),
    );
  }

  Widget pageTitle() {
    return Container(
      margin: EdgeInsets.only(top: 50),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Icon(
            Icons.school,
            size: 48,
            color: Colors.white,
          ),
          Text(
            "   InstaSchool",
            style: TextStyle(
                fontSize: 34, color: Colors.white, fontWeight: FontWeight.w400),
          )
        ],
      ),
    );
  }

  Widget loginCard(BuildContext context) {
    return Column(
      children: <Widget>[
        Container(
          margin: EdgeInsets.only(top: screenHeight / 4),
          padding: EdgeInsets.only(left: 10, right: 10),
          child: Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            elevation: 8,
            child: Padding(
              padding: const EdgeInsets.all(30.0),
              child: Form(
                key: _loginForm,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Align(
                      alignment: Alignment.topLeft,
                      child: Text(
                        "Login",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 28,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    TextFormField(
                      decoration: InputDecoration(
                          labelText: "Your Email",
                          hasFloatingPlaceholder: true),
                      validator: (value) =>
                          value.isEmpty ? 'Email cannot be blank' : null,
                      onSaved: (value) => _email = value,
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                      decoration: InputDecoration(
                          labelText: "Password", hasFloatingPlaceholder: true),
                      validator: (value) =>
                          value.isEmpty ? 'Password cannot be blank' : null,
                      onSaved: (value) => _password = value,
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        MaterialButton(
                          onPressed: () {},
                          child: Text("Forgot Password ?"),
                        ),
                        Expanded(
                          child: Container(),
                        ),
                        FlatButton(
                          child: Text("Login"),
                          color: Colors.green[800],
                          textColor: Colors.white,
                          padding: EdgeInsets.only(
                              left: 38, right: 38, top: 15, bottom: 15),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5)),
                          onPressed: () {
                            validateAndSaveLogin();
                          },
                        )
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SizedBox(
              height: 40,
            ),
            Text(
              "Don't have an account ?",
              style: TextStyle(color: Colors.grey),
            ),
            FlatButton(
              onPressed: () {
                setState(() {
                  _authMode = AuthMode.SINGUP;
                });
              },
              textColor: Colors.black87,
              child: Text("Create Account"),
            )
          ],
        )
      ],
    );
  }

  Widget singUpCard(BuildContext context) {
    return Column(
      children: <Widget>[
        Container(
          margin: EdgeInsets.only(top: screenHeight / 5),
          padding: EdgeInsets.only(left: 10, right: 10),
          child: Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            elevation: 8,
            child: Padding(
              padding: const EdgeInsets.all(30.0),
              child: Form(
                key: _signupForm,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Align(
                      alignment: Alignment.topLeft,
                      child: Text(
                        "Create Account",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 28,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    TextFormField(
                      decoration: InputDecoration(
                          labelText: "Your Name", hasFloatingPlaceholder: true),
                      validator: (value) =>
                          value.isEmpty ? 'Name cannot be blank' : null,
                      onSaved: (value) => _name = value,
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                      controller: dateCtl,
                      onTap: () {
                        // Below line stops keyboard from appearing
                        FocusScope.of(context).requestFocus(new FocusNode());
                        _selectDate(context);
                      },
                      decoration: InputDecoration(
                          enabled: false,
                          labelText: "Date of Birth",
                          hasFloatingPlaceholder: true),
                      validator: (value) => value.isEmpty
                          ? 'Date of Birth cannot be blank'
                          : null,
                      onSaved: (value) => _dob = value,
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    TextFormField(
                      decoration: InputDecoration(
                          labelText: "Your Email",
                          hasFloatingPlaceholder: true),
                      validator: (value) =>
                          value.isEmpty ? 'Email cannot be blank' : null,
                      onSaved: (value) => _email = value,
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                      decoration: InputDecoration(
                          labelText: "Password", hasFloatingPlaceholder: true),
                      validator: (value) =>
                          value.isEmpty ? 'Password cannot be blank' : null,
                      onSaved: (value) => _password = value,
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Text(
                      "Password must be at least 8 characters and include a special character and number",
                      style: TextStyle(color: Colors.grey),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        Expanded(
                          child: Container(),
                        ),
                        FlatButton(
                          child: Text("Sign Up"),
                          color: Colors.green[800],
                          textColor: Colors.white,
                          padding: EdgeInsets.only(
                              left: 38, right: 38, top: 15, bottom: 15),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5)),
                          onPressed: () {
                            validateAndSaveSignup();
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SizedBox(
              height: 40,
            ),
            Text(
              "Already have an account?",
              style: TextStyle(color: Colors.grey),
            ),
            FlatButton(
              onPressed: () {
                setState(() {
                  _authMode = AuthMode.LOGIN;
                });
              },
              textColor: Colors.black87,
              child: Text("Login"),
            )
          ],
        ),
        Align(
          alignment: Alignment.bottomCenter,
          child: FlatButton(
            child: Text(
              "Terms & Conditions",
              style: TextStyle(
                color: Colors.grey,
              ),
            ),
            onPressed: () {},
          ),
        ),
      ],
    );
  }

  Widget upperHalf(BuildContext context) {
    return Container(
      height: screenHeight / 2,
      //color: Colors.purpleAccent,
      child: BackgroundPainter(),
    );
  }

  Widget lowerHalf(BuildContext context) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Container(
        height: screenHeight / 2,
        color: Color(0xFFECF0F3),
      ),
    );
  }
}
