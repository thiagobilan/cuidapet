import 'dart:io';

import 'package:cuida_pet/app/repository/shared_prefs_repository.dart';
import 'package:cuida_pet/app/services/usuario_services.dart';
import 'package:cuida_pet/app/shared/auth_store.dart';
import 'package:cuida_pet/app/shared/components/loader.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';

class HomeDrawer extends Drawer {
  HomeDrawer()
      : super(child: Container(
          child: Observer(
            builder: (_) {
              var user = Modular.get<AuthStore>().usuarioLogado;
              return Column(
                children: [
                  Container(
                    margin:
                        EdgeInsets.only(top: ScreenUtil.statusBarHeight + 5),
                    height: 200,
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        CircleAvatar(
                          backgroundImage: user.imgAvatar != null
                              ? NetworkImage(user.imgAvatar)
                              : null,
                          radius: 100,
                        ),
                        Align(
                          alignment: Alignment.bottomCenter,
                          child: Container(
                            padding: const EdgeInsets.all(12),
                            child: InkWell(
                              onTap: () =>
                                  alterarImagemPerfil() ?? Loader.hide(),
                              child: Container(
                                  child: Text(
                                    'Alterar Imagem',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 15),
                                  ),
                                  color: Colors.white54),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Text(user.email),
                  ListView(
                    shrinkWrap: true,
                    children: [
                      ListTile(
                        onTap: () => Modular.to.pushNamed('/meusagendamentos'),
                        leading: Icon(Icons.receipt),
                        title: Text('Meus Agendamentos'),
                      ),
                      ListTile(
                        onTap: () => Modular.to.pushNamed('/chatLista'),
                        leading: Icon(Icons.chat),
                        title: Text('Chats'),
                      ),
                      ListTile(
                        onTap: () async {
                          var prefs = await SharedPrefsRepository.instance;
                          prefs.logout();
                        },
                        leading: Icon(Icons.exit_to_app),
                        title: Text('Sair'),
                      ),
                    ],
                  )
                ],
              );
            },
          ),
        ));

  static Future<void> alterarImagemPerfil() async {
    var imageFile = await ImagePicker().getImage(source: ImageSource.camera);
    var reference = FirebaseStorage.instance
        .ref()
        .child('/perfil/${DateTime.now().millisecondsSinceEpoch.toString()}');

    var storageTask = await reference.putFile(File(imageFile.path)).onComplete;
    var url = await storageTask.ref.getDownloadURL();
    var novoUsuario = await Modular.get<UsuarioServices>().atualizarImagem(url);
    final prefs = await SharedPrefsRepository.instance;
    await prefs.registerDadosUsuario(novoUsuario);
    Modular.get<AuthStore>().loadUsuario();
  }
}
