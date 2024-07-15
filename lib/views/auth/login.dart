import 'package:fasionxt/views/auth/register.dart';
import 'package:fasionxt/views/colors.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool _isPasswordVisible = false;
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgPurple,
      body: Stack(
        children: [
          Align(
            alignment: Alignment.topCenter,
            child: Padding(
              padding: const EdgeInsets.only(top: 100.0),
              child: Image.asset(
                'assets/images/logo.png',
                width: 150,
                height: 150,
              ),
            ),
          ),
          DraggableScrollableSheet(
            initialChildSize: 0.50,
            minChildSize: 0.50,
            maxChildSize: 0.65,
            builder: (BuildContext context, ScrollController scrollController) {
              return Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30.0),
                    topRight: Radius.circular(30.0),
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black12,
                      spreadRadius: 5,
                      blurRadius: 7,
                    ),
                  ],
                ),
                child: SingleChildScrollView(
                  controller: scrollController,
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: 10),
                          Center(
                            child: Text(
                              'Login',
                              style: TextStyle(
                                fontSize: 24.0,
                                color: purplePrimary,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          SizedBox(height: 30),
                          Container(
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(25.0),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black12,
                                  spreadRadius: 0,
                                  blurRadius: 2,
                                ),
                              ],
                            ),
                            child: Column(
                              children: [
                                TextFormField(
                                  controller: _usernameController,
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Username harus diisi';
                                    }
                                    return null;
                                  },
                                  decoration: InputDecoration(
                                    prefixIcon:
                                        Icon(Icons.person, color: bgBlue),
                                    hintText: 'Username',
                                    border: UnderlineInputBorder(
                                        borderSide:
                                            BorderSide(color: Colors.grey)),
                                  ),
                                ),
                                TextFormField(
                                  controller: _passwordController,
                                  obscureText: !_isPasswordVisible,
                                  decoration: InputDecoration(
                                    prefixIcon: Icon(Icons.lock, color: bgBlue),
                                    hintText: 'Password',
                                    border: InputBorder.none,
                                    suffixIcon: IconButton(
                                      icon: Icon(
                                        _isPasswordVisible
                                            ? Icons.visibility
                                            : Icons.visibility_off,
                                      ),
                                      onPressed: () {
                                        setState(() {
                                          _isPasswordVisible =
                                              !_isPasswordVisible;
                                        });
                                      },
                                    ),
                                  ),
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Password harus diisi';
                                    }
                                    return null;
                                  },
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: 10),
                          Align(
                            alignment: Alignment.centerRight,
                            child: TextButton(
                              onPressed: () {},
                              child: Text(
                                'Forgot Password?',
                                style: TextStyle(color: danger),
                              ),
                            ),
                          ),
                          SizedBox(height: 10),
                          Center(
                            child: ElevatedButton(
                              onPressed: () {
                                if (_formKey.currentState!.validate()) {
                                  (isLoading) ? null : null;
                                }
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: bluePrimary,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30.0),
                                ),
                                padding: EdgeInsets.symmetric(
                                  horizontal: 70,
                                  vertical: 12,
                                ),
                              ),
                              child: (isLoading)
                                  ? CircularProgressIndicator()
                                  : Text(
                                      'Login',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                            ),
                          ),
                          SizedBox(height: 20),
                          Center(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text('New Member?'),
                                TextButton(
                                  onPressed: () {
                                    Navigator.of(context).push(
                                      MaterialPageRoute(
                                        builder: (context) => RegisterPage(),
                                      ),
                                    );
                                  },
                                  child: Text(
                                    'Register for Free',
                                    style: TextStyle(color: bluePrimary),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
