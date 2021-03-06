import 'dart:io';

import 'package:cuida_pet/app/core/database/connection.dart';
import 'package:cuida_pet/app/shared/components/cuidapet_textformfild.dart';
import 'package:cuida_pet/app/shared/components/facebook_button.dart';
import 'package:cuida_pet/app/shared/theme_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
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
  void initState() {
    super.initState();
    testeConnect();
  }

  Future<void> testeConnect() async {
    var db = await Connection().instance;
    var result = await db.rawQuery('select * from endereco');
    print(result);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ThemeUtils.primaryColor,
      body: SingleChildScrollView(
        child: Container(
          width: ScreenUtil.screenWidthDp,
          height: ScreenUtil.screenHeightDp,
          child: Stack(
            children: [
              Container(
                width: ScreenUtil.screenWidthDp,
                height: ScreenUtil.screenHeightDp < 700
                    ? 800
                    : ScreenUtil.screenHeightDp * .95,
                decoration: BoxDecoration(
                  image: DecorationImage(
                      image:
                          AssetImage('lib/assets/images/login_background.png'),
                      fit: BoxFit.fill),
                ),
              ),
              Container(
                margin: EdgeInsets.only(
                  top: Platform.isIOS
                      ? ScreenUtil.statusBarHeight + 30
                      : ScreenUtil.statusBarHeight + 10,
                ),
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
      ),
    );
  }

  Widget _buildForm() {
    return Padding(
      padding: const EdgeInsets.all(18.0),
      child: Form(
          key: controller.formKey,
          child: Column(
            children: [
              CuidapetTextformfild(
                label: 'Login',
                controller: controller.loginController,
                validator: (value) {
                  if (value.isEmpty) {
                    return 'Login Obrigatorio.';
                  }
                  return null;
                },
              ),
              SizedBox(
                height: 20,
              ),
              Observer(builder: (_) {
                return CuidapetTextformfild(
                  label: 'Senha',
                  controller: controller.senhaController,
                  obscureText: controller.mostrarSenha,
                  suffixIcon: IconButton(
                    icon: Icon(Icons.lock),
                    onPressed: controller.mostraSenha,
                  ),
                  validator: (value) {
                    if (value.length < 6) {
                      return 'Senha Fraca.';
                    }
                    return null;
                  },
                );
              }),
              Container(
                padding: EdgeInsets.all(10),
                width: ScreenUtil.screenWidthDp,
                height: 60,
                child: RaisedButton(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20)),
                  onPressed: () async {
                    controller.login();
                    // CustomDio.authInstance
                    //     .get('https://viacep.com.br/ws/01001000/json/')
                    //     .then((value) => print('RESULTADO ??: ${value.data}'));
                    //   print('ENTROU');
                    //   final facebooklogin = FacebookLogin();
                    //   final result =
                    //       await facebooklogin.logIn(['public_profile', 'email']);
                    //   print('SAIU');
                    //   print(result.status);
                    //   print(result.errorMessage);
                  },
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
                    // SizedBox(
                    //   height: 100,
                    // ),
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
              FacebookButton(
                onTap: () => controller.facebookLogin(),
              ),
              FlatButton(
                onPressed: () => Modular.link.pushNamed('/cadastro'),
                child: Text('Cadastre-se'),
              )
            ],
          )),
    );
  }
}
