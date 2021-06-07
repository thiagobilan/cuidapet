import 'package:cuida_pet/app/repository/shared_prefs_repository.dart';
import 'package:cuida_pet/app/shared/auth_store.dart';
import 'package:cuida_pet/app/shared/theme_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      final authStore = Modular.get<AuthStore>();
      final isLogged = await authStore.isLogged();
      if (isLogged) {
        await authStore.loadUsuario();
        Modular.to.pushNamedAndRemoveUntil('/home', (_) => false);
      } else {
        Modular.to.pushNamedAndRemoveUntil('/login', (_) => false);
      }
    });
  }

  Future<void> sair() async {
    var prefs = await SharedPrefsRepository.instance;
    prefs.logout();
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context);
    ThemeUtils.init(context);
    return Scaffold(
      body: Container(
        child: Center(
            child: Image(
          image: AssetImage('lib/assets/images/3.0x/logo.png'),
        )),
      ),
    );
  }
}
