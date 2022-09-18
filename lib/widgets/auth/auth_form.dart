import 'dart:io';


import '../pickers/user_image_picker.dart';

import 'package:flutter/material.dart';

class AuthForm extends StatefulWidget {
  final void Function({
    required String email,
    required String password,
    required String username,
    required bool isLogin,
    required File image,
    required BuildContext ctx,
  }) submitfn;
  final bool _isLoading;

  AuthForm(this.submitfn, this._isLoading);

  @override
  _AuthFormState createState() => _AuthFormState();
}

class _AuthFormState extends State<AuthForm> {
  final _formKey = GlobalKey<FormState>();

  bool _isLogin = true;
  bool _isSecure = true;
  String _email = '';
  String _password = '';
  String _username = '';
  File _userImageFile = File('path');

  void _pickedImage(File pickedImage) {
    _userImageFile = pickedImage;
  }

  void _submit() {
    final isValid = _formKey.currentState!.validate();
    FocusScope.of(context).unfocus();

    if (!_isLogin &&
        (_userImageFile == null || _userImageFile.path == 'path')) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text('Pick an Image'),
          backgroundColor: Theme.of(context).errorColor,
        ),
      );
      return;
    }

    if (isValid) {
      _formKey.currentState!.save();
      widget.submitfn(
        ctx: context,
        email: _email.trim(),
        isLogin: _isLogin,
        image: _userImageFile,
        password: _password.trim(),
        username: _username.trim(),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        decoration:const  BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Colors.black87, Color(0xff8A8887 )],
          ),
        ),
        child: Scaffold(
          backgroundColor: Colors.transparent,
          body: Form(
            key: _formKey,
            child: SingleChildScrollView(
              padding: EdgeInsets.symmetric(horizontal: 20, vertical:_isLogin ? 110:40),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: Text(
                      _isLogin ? 'Login' : 'Create account',
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 26,
                        color: Colors.white,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Center(
                    child: Text(
                      _isLogin
                          ? 'Login to our chat app'
                          : 'On creating new account you can connect with all of your friends',
                      style: const TextStyle(
                        fontSize: 18,
                        color: Colors.white,
                      ),
                      maxLines: 2,
                      textAlign: TextAlign.center,
                    ),
                  ),
                  const SizedBox(height: 50),
                  if (!_isLogin) Center(child: UserImagePicker(_pickedImage)),
                  const SizedBox(height: 20),
                  const Text(
                    'E-Mail',
                    textAlign: TextAlign.start,
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  TextFormField(
                    key: const ValueKey('email'),
                    cursorColor: Colors.white70,
                    style: const TextStyle(color: Colors.white),
                    decoration: const InputDecoration(
                      hintText: 'Ahmedhuss@gmail.com',
                      hintStyle: TextStyle(color: Colors.white70),
                    ),
                    keyboardType: TextInputType.emailAddress,
                    validator: (value) {
                      if (value == null ||
                          value.isEmpty ||
                          !value.contains('@')) {
                        return 'Please enter a valid e-mail';
                      }
                      return null;
                    },
                    onSaved: (val) => _email = val!,
                  ),
                  const SizedBox(height: 20),
                  if (!_isLogin)
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'User Name',
                          textAlign: TextAlign.start,
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        TextFormField(
                          key: const ValueKey('username'),
                          style: const TextStyle(color: Colors.white),
                          decoration: const InputDecoration(
                            hintText: 'Ahmed Hussein',
                            hintStyle: TextStyle(color: Colors.white70),
                          ),
                          keyboardType: TextInputType.text,
                          onSaved: (val) => _username = val!,
                          validator: (value) {
                            if (value!.isEmpty || value.length < 5) {
                              return 'Invalid User Name';
                            }
                            return null;
                          },
                        ),
                      ],
                    ),
                  const SizedBox(height: 20),
                  const Text(
                    'Password',
                    textAlign: TextAlign.start,
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  TextFormField(
                    key: const ValueKey('password'),
                    style: const TextStyle(color: Colors.white),
                    obscureText: _isSecure,
                    decoration: InputDecoration(
                      hintText: _isSecure ? '•••••••••••••' : '1s23^456m4A@5',
                      hintStyle: const TextStyle(color: Colors.white70),
                      suffixIcon: IconButton(
                          onPressed: () {
                            setState(() {
                              _isSecure = !_isSecure;
                            });
                          },
                          icon: Icon(
                            _isSecure ? Icons.visibility_off : Icons.visibility,
                            color: const Color(0xff5B1818),
                          )),
                    ),
                    keyboardType: TextInputType.visiblePassword,
                    validator: (value) {
                      if (value == null || value.isEmpty || value.length <= 5) {
                        return 'Please enter a valid password';
                      }
                      return null;
                    },
                    onSaved: (val) => _password = val!,
                  ),
                  const SizedBox(height: 20),
                  if (widget._isLoading)
                    const Center(
                      child: CircularProgressIndicator(
                        color: Color(0xff4D0B0B),
                      ),
                    ),
                  if (!widget._isLoading)
                    Center(
                      child: SizedBox(
                        width: MediaQuery.of(context).size.width * 0.6,
                        height: MediaQuery.of(context).size.height * 0.07,
                        child: ElevatedButton(
                          onPressed: _submit,
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all(
                              const Color(0xff910E0E),
                            ),
                            shape: MaterialStateProperty.all<
                                RoundedRectangleBorder>(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(18.0),
                              ),
                            ),
                          ),
                          child: Text(_isLogin ? 'LOGIN' : 'SIGN UP'),
                        ),
                      ),
                    ),
                  const SizedBox(height: 20),
                  if (!widget._isLoading)
                    Center(
                      child: TextButton(
                        onPressed: () {
                          setState(() {
                            _isLogin = !_isLogin;
                          });
                        },
                        style: ButtonStyle(
                          foregroundColor:
                              MaterialStateProperty.all(Colors.white),
                        ),
                        child: Text(
                          '${_isLogin ? 'create account' : 'i already have an account'} ',
                          style: const TextStyle(fontSize: 18),
                        ),
                      ),
                    ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
