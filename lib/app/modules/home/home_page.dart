import 'package:cuida_pet/app/repository/shared_prefs_repository.dart';
import 'package:cuida_pet/app/shared/auth_store.dart';
import 'package:cuida_pet/app/shared/theme_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'home_controller.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends ModularState<HomePage, HomeController> {
  //use 'controller' variable to access controller

  @override
  void initState() {
    super.initState();
    controller.initPage();
  }

  @override
  Widget build(BuildContext context) {
    var _appBar = PreferredSize(
      preferredSize: const Size(double.infinity, 100),
      child: AppBar(
        backgroundColor: Colors.grey[100],
        title: Padding(
          padding: const EdgeInsets.only(bottom: 10),
          child: Text(
            'CuidaPet',
            style: TextStyle(
              color: Colors.white,
            ),
          ),
        ),
        actions: [
          IconButton(
              icon: Icon(Icons.location_on),
              onPressed: () => Modular.link.pushNamed('/enderecos'))
          // onPressed: () => print('ENTR AQUI'))
        ],
        elevation: 0,
        flexibleSpace: Stack(
          children: [
            Container(
              height: 95,
              width: double.infinity,
              color: ThemeUtils.primaryColor,
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                width: ScreenUtil.screenWidthDp * .9,
                child: Material(
                  borderRadius: BorderRadius.circular(30),
                  elevation: 4,
                  child: TextFormField(
                    decoration: InputDecoration(
                      filled: true,
                      suffixIcon: Padding(
                        padding: const EdgeInsets.only(right: 20),
                        child: Icon(
                          Icons.search,
                          size: 30,
                        ),
                      ),
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30),
                          borderSide: BorderSide(color: Colors.grey[200])),
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30),
                          borderSide: BorderSide(color: Colors.grey[200])),
                      fillColor: Colors.white,
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30),
                          borderSide: BorderSide(color: Colors.grey[200])),
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
        centerTitle: true,
      ),
    );
    var scaffold = Scaffold(
      drawer: Drawer(),
      backgroundColor: Colors.grey[100],
      appBar: _appBar,
      body: SingleChildScrollView(
        child: Container(
          width: ScreenUtil.screenWidthDp,
          height: ScreenUtil.screenHeightDp -
              (_appBar.preferredSize.height + ScreenUtil.statusBarHeight),
          child: Column(
            children: <Widget>[
              _buildEndereco(),
              _buildCategoria(),
              Expanded(child: _buildEstabelecimentos()),
            ],
          ),
        ),
      ),
    );
    return scaffold;
  }

  _buildEndereco() {
    return Container(
      padding: const EdgeInsets.all(20),
      child: Column(
        children: [
          Text('Estabelecimentos próximos de'),
          Text(
            'Av Paulista 1000',
            style: TextStyle(fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  _buildCategoria() {
    return Container(
      height: 130,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        shrinkWrap: true,
        itemCount: 3,
        itemBuilder: (context, index) {
          return Container(
            margin: const EdgeInsets.all(20),
            child: Column(
              children: [
                CircleAvatar(
                  radius: 30,
                  backgroundColor: ThemeUtils.primaryColorLight,
                  child: Icon(
                    Icons.pets,
                    color: Colors.black,
                    size: 30,
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Text('xxxx')
              ],
            ),
          );
        },
      ),
    );
  }

  _buildEstabelecimentos() {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(15.0),
          child: Row(
            children: [
              Text('Estabelecimentos'),
              Spacer(),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Icon(Icons.view_headline),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Icon(Icons.view_comfy),
              ),
            ],
          ),
        ),
        Expanded(
            child: PageView(
          children: [
            _buildEstabelecimentosLista(),
            _buildEstabelecimentosGrid(),
          ],
        ))
      ],
    );
  }

  _buildEstabelecimentosLista() {
    return ListView.separated(
      physics: NeverScrollableScrollPhysics(),
      itemCount: 3,
      separatorBuilder: (context, index) => Divider(
        color: Colors.transparent,
      ),
      itemBuilder: (context, index) {
        return Container(
          margin: const EdgeInsets.symmetric(horizontal: 10),
          child: Stack(
            children: [
              Container(
                margin: const EdgeInsets.only(left: 30),
                width: ScreenUtil.screenWidthDp,
                height: 80,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(5),
                ),
                child: Row(
                  children: [
                    Container(
                      margin: const EdgeInsets.only(left: 50),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text('PetShop X'),
                          SizedBox(height: 10),
                          Row(
                            children: [
                              Icon(
                                Icons.location_on,
                                size: 16,
                                color: Colors.grey[500],
                              ),
                              Text('20Km de distância')
                            ],
                          )
                        ],
                      ),
                    ),
                    Spacer(),
                    Container(
                      margin: const EdgeInsets.all(10),
                      child: CircleAvatar(
                        backgroundColor: ThemeUtils.primaryColor,
                        maxRadius: 15,
                        child: Icon(
                          Icons.arrow_forward_ios,
                          color: Colors.white,
                          size: 15,
                        ),
                      ),
                    )
                  ],
                ),
              ),
              Container(
                  margin: const EdgeInsets.only(top: 5),
                  width: 70,
                  height: 70,
                  decoration: BoxDecoration(
                    color: Colors.transparent,
                    border: Border.all(
                      color: Colors.transparent,
                      width: 1,
                    ),
                    borderRadius: BorderRadius.circular(100),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(3.0),
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border.all(
                          width: 5,
                          color: Colors.grey[100],
                        ),
                        color: Colors.grey,
                        borderRadius: BorderRadius.circular(100),
                        image: DecorationImage(
                          image: NetworkImage(
                              'https://media.istockphoto.com/vectors/petshop-design-with-cat-and-dog-vector-id1041835006'),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ))
            ],
          ),
        );
      },
    );
  }

  _buildEstabelecimentosGrid() {
    return GridView.builder(
      physics: NeverScrollableScrollPhysics(),
      itemCount: 4,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 1.1,
      ),
      itemBuilder: (context, index) {
        return Stack(
          children: [
            Card(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20)),
              elevation: 5,
              margin: const EdgeInsets.only(
                top: 40,
                left: 10,
                right: 10,
              ),
              child: Container(
                width: double.infinity,
                height: 120,
                child: Padding(
                  padding: const EdgeInsets.only(top: 40.0, bottom: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Text('Pet X',
                          style: ThemeUtils.theme.textTheme.subtitle2),
                      Text('20 km de Distância'),
                    ],
                  ),
                ),
              ),
            ),
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              child: CircleAvatar(
                radius: 40,
                backgroundColor: Colors.grey[200],
              ),
            ),
            Positioned(
              top: 5,
              left: 0,
              right: 0,
              child: CircleAvatar(
                radius: 35,
                backgroundImage: NetworkImage(
                    'https://media.istockphoto.com/vectors/petshop-design-with-cat-and-dog-vector-id1041835006'),
              ),
            ),
          ],
        );
      },
    );
  }
}
