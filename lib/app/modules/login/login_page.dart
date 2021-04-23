import 'dart:ffi';

import 'package:cuida_pet/app/shared/components/facebook_button.dart';
import 'package:cuida_pet/app/shared/theme_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'login_controller.dart';

class LoginPage extends StatefulWidget {
  final String title;
  const LoginPage({Key key, this.title = "Login"}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends ModularState<LoginPage, LoginController> {
  //use 'controller' variable to access controller

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ThemeUtils.primaryColor,
      body: Container(
        width: ScreenUtil.screenWidthDp,
        height: ScreenUtil.screenHeightDp,
        child: Stack(
          children: [
            Container(
              width: ScreenUtil.screenWidthDp,
              height: ScreenUtil.screenHeightDp * .95,
              decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage('lib/assets/images/login_background.png'),
                    fit: BoxFit.fill),
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: ScreenUtil.statusBarHeight + 30),
              width: double.infinity,
              child: Column(
                children: [
                  Image.asset(
                    'lib/assets/images/logo.png',
                    fit: BoxFit.fill,
                    width: ScreenUtil().setWidth(400),
                  ),
                  _buildForm(),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildForm() {
    return Padding(
      padding: const EdgeInsets.all(18.0),
      child: Form(
          child: Column(
        children: [
          TextFormField(
            decoration: InputDecoration(
              labelText: 'Login',
              labelStyle: TextStyle(fontSize: 15),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(50),
                gapPadding: 0,
              ),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          TextFormField(
            obscureText: true,
            decoration: InputDecoration(
              labelText: 'Senha',
              labelStyle: TextStyle(fontSize: 15),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(50),
                gapPadding: 0,
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.all(10),
            width: ScreenUtil.screenWidthDp,
            height: 60,
            child: RaisedButton(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20)),
              onPressed: () {},
              child: Text(
                'Entrar',
                style: TextStyle(fontSize: 20, color: Colors.white),
              ),
              color: ThemeUtils.primaryColor,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              children: [
                Expanded(
                  child: Divider(
                    color: ThemeUtils.primaryColor,
                    thickness: 1,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    'ou',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: ThemeUtils.primaryColor,
                        fontSize: 20),
                  ),
                ),
                Expanded(
                  child: Divider(
                    color: ThemeUtils.primaryColor,
                    thickness: 1,
                  ),
                )
              ],
            ),
          ),
          FacebookButton(),
          FlatButton(
            onPressed: () {},
            child: Text('Cadastre-se'),
          )
        ],
      )),
    );
  }
}
