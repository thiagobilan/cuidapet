import 'package:cuida_pet/app/modules/home/components/home_drawer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:cuida_pet/app/models/categoria_model.dart';
import 'package:cuida_pet/app/models/fornecedor_busca_model.dart';
import 'package:cuida_pet/app/modules/home/components/estabelecimento_card.dart';
import 'package:cuida_pet/app/modules/home/components/estabelecimento_item_list.dart';
import 'package:cuida_pet/app/modules/home/components/home_appbar.dart';
import 'package:cuida_pet/app/shared/theme_utils.dart';

import 'home_controller.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends ModularState<HomePage, HomeController> {
  HomeAppbar _appBar;
  _HomePageState() {
    _appBar = HomeAppbar(controller);
  }

  //use 'controller' variable to access controller
  final categoriasIcons = {
    'P': Icons.pets,
    'V': Icons.local_hospital,
    'C': Icons.store_mall_directory
  };
  final _estabelecimentoPageController = PageController(initialPage: 0);

  @override
  void initState() {
    super.initState();
    controller.initPage();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: HomeDrawer(),
      backgroundColor: Colors.grey[100],
      appBar: _appBar,
      body: RefreshIndicator(
        onRefresh: () => controller.buscarEstabelecimentos(),
        child: SingleChildScrollView(
          physics: AlwaysScrollableScrollPhysics(),
          child: Container(
            width: ScreenUtil.screenWidthDp,
            // height: ScreenUtil.screenHeightDp,
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
      ),
    );
  }

  _buildEndereco() {
    return Container(
      padding: const EdgeInsets.all(20),
      child: Column(
        children: [
          Text('Estabelecimentos próximos de'),
          Observer(builder: (_) {
            return Text(
              controller.enderecoSelecionado?.endereco ?? '',
              style: TextStyle(fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            );
          }),
        ],
      ),
    );
  }

  _buildCategoria() {
    return Observer(builder: (_) {
      return FutureBuilder<List<CategoriaModel>>(
        future: controller.categoriasFuture,
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.none:
              return Container();
              break;
            case ConnectionState.waiting:
            case ConnectionState.active:
              return Center(
                child: CircularProgressIndicator(),
              );
              break;
            case ConnectionState.done:
              if (snapshot.hasError) {
                return Center(
                  child: Text('Erro ao Buscar Categorias.'),
                );
              }
              if (snapshot.hasData) {
                var cats = snapshot.data;
                return Container(
                  height: 130,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    shrinkWrap: true,
                    itemCount: cats.length,
                    itemBuilder: (context, index) {
                      return InkWell(
                        onTap: () =>
                            controller.filtrarPorCategoria(cats[index].id),
                        child: Container(
                          margin: const EdgeInsets.all(20),
                          child: Column(
                            children: [
                              Observer(builder: (_) {
                                return CircleAvatar(
                                  radius: 30,
                                  backgroundColor:
                                      controller.categoriaSelecionada ==
                                              cats[index].id
                                          ? ThemeUtils.primaryColor
                                          : ThemeUtils.primaryColorLight,
                                  child: Icon(
                                    categoriasIcons[cats[index].tipo],
                                    color: Colors.black,
                                    size: 30,
                                  ),
                                );
                              }),
                              SizedBox(
                                height: 10,
                              ),
                              Text(cats[index].nome)
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                );
              } else {
                return Container();
              }
              break;
            default:
              return Container();
          }
        },
      );
    });
  }

  _buildEstabelecimentos() {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(15.0),
          child: Observer(builder: (_) {
            return Row(
              children: [
                Text('Estabelecimentos'),
                Spacer(),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: InkWell(
                    child: Icon(
                      Icons.view_headline,
                      color: controller.pageSelecionda == 0
                          ? Colors.black
                          : Colors.grey,
                    ),
                    onTap: () {
                      _estabelecimentoPageController.previousPage(
                          duration: Duration(milliseconds: 200),
                          curve: Curves.ease);
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: InkWell(
                    child: Icon(
                      Icons.view_comfy,
                      color: controller.pageSelecionda == 1
                          ? Colors.black
                          : Colors.grey,
                    ),
                    onTap: () {
                      _estabelecimentoPageController.nextPage(
                          duration: Duration(milliseconds: 200),
                          curve: Curves.ease);
                    },
                  ),
                ),
              ],
            );
          }),
        ),
        Expanded(
            child: PageView(
          onPageChanged: (pagina) =>
              controller.alterarPaginaSelecionada(pagina),
          controller: _estabelecimentoPageController,
          physics: NeverScrollableScrollPhysics(),
          children: [
            _buildEstabelecimentosLista(),
            _buildEstabelecimentosGrid(),
          ],
        ))
      ],
    );
  }

  _buildEstabelecimentosLista() {
    return Observer(builder: (_) {
      return FutureBuilder<List<FornecedorBuscaModel>>(
        future: controller.estabelecimentosFuture,
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.none:
              return Container();
              break;
            case ConnectionState.waiting:
            case ConnectionState.active:
              return Center(child: CircularProgressIndicator());
              break;
            case ConnectionState.done:
              if (snapshot.hasError) {
                return Center(
                  child: Text('Erro ao buscar estabelecimentos'),
                );
              }
              if (snapshot.hasData) {
                var fornecs = snapshot.data;
                return ListView.separated(
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: fornecs.length,
                  separatorBuilder: (context, index) => Divider(
                    color: Colors.transparent,
                  ),
                  itemBuilder: (context, index) {
                    return EstabelecimentoItemList(fornecs[index]);
                  },
                );
              } else {
                return Container();
              }
              break;
            default:
              return Container();
          }
        },
      );
    });
  }

  _buildEstabelecimentosGrid() {
    return Observer(builder: (_) {
      return FutureBuilder<List<FornecedorBuscaModel>>(
        future: controller.estabelecimentosFuture,
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.none:
              return Container();
              break;
            case ConnectionState.waiting:
            case ConnectionState.active:
              return Center(child: CircularProgressIndicator());
              break;
            case ConnectionState.done:
              if (snapshot.hasError) {
                return Center(
                  child: Text('Erro ao buscar estabelecimentos'),
                );
              }
              if (snapshot.hasData) {
                var fornecs = snapshot.data;
                return GridView.builder(
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: fornecs.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 1.1,
                  ),
                  itemBuilder: (context, index) {
                    return EstabelecimentoCard(fornecs[index]);
                  },
                );
              } else {
                return Container();
              }
              break;
            default:
              return Container();
          }
        },
      );
    });
  }
}
