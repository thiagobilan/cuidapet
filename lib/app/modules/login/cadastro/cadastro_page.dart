import 'dart:io';

import 'package:cuida_pet/app/shared/theme_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'cadastro_controller.dart';

class CadastroPage extends StatefulWidget {
  const CadastroPage({Key key}) : super(key: key);

  @override
  _CadastroPageState createState() => _CadastroPageState();
}

class _CadastroPageState
    extends ModularState<CadastroPage, CadastroController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Cadastrar Usuário',
          style: TextStyle(
            fontSize: 18,
            color: ThemeUtils.primaryColor,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      backgroundColor: ThemeUtils.primaryColor,
      body: Container(
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
                    image: AssetImage('lib/assets/images/login_background.png'),
                    fit: BoxFit.fill),
              ),
            ),
            Container(
              width: double.infinity,
              child: SingleChildScrollView(
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
          key: controller.formKey,
          child: Column(
            children: [
              TextFormField(
                controller: controller.loginController,
                decoration: InputDecoration(
                  labelText: 'E-mail',
                  labelStyle: TextStyle(fontSize: 15),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(50),
                    gapPadding: 0,
                  ),
                ),
                validator: (value) {
                  if (value.isEmpty) {
                    return 'Login Obrigatorio.';
                  } else if (!value.contains('@')) {
                    return 'Login precisa ser um e-mail valido.';
                  }

                  return null;
                },
              ),
              SizedBox(
                height: 20,
              ),
              Observer(
                builder: (_) {
                  return TextFormField(
                    controller: controller.senhaController,
                    obscureText: controller.esconderSenha ? false : true,
                    decoration: InputDecoration(
                      labelText: 'Senha',
                      labelStyle: TextStyle(fontSize: 15),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(50),
                        gapPadding: 0,
                      ),
                      suffixIcon: IconButton(
                        icon: Icon(Icons.lock),
                        onPressed: controller.mostrarSenha,
                      ),
                    ),
                    validator: (value) {
                      if (value.length < 6) {
                        return 'Senha Fraca.';
                      }
                      return null;
                    },
                  );
                },
              ),
              SizedBox(
                height: 20,
              ),
              Observer(builder: (_) {
                return TextFormField(
                  controller: controller.confirmaSenhaController,
                  obscureText: controller.esconderConfirmaSenha ? false : true,
                  decoration: InputDecoration(
                    labelText: 'Confirmar Senha',
                    labelStyle: TextStyle(fontSize: 15),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(50),
                      gapPadding: 0,
                    ),
                    suffixIcon: IconButton(
                      icon: Icon(Icons.lock),
                      onPressed: controller.mostrarConfirmaSenha,
                    ),
                  ),
                  validator: (value) {
                    if (value != controller.senhaController.text) {
                      return 'Senha e confirma senha não são iguais.';
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
                  onPressed: () => controller.cadastrarUsuario(),
                  child: Text(
                    'Cadastrar',
                    style: TextStyle(fontSize: 20, color: Colors.white),
                  ),
                  color: ThemeUtils.primaryColor,
                ),
              ),
            ],
          )),
    );
  }
}
