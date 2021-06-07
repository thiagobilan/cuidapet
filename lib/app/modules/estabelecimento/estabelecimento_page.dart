import 'package:cuida_pet/app/models/fornecedor_model.dart';
import 'package:cuida_pet/app/models/fornecedor_servicos_model.dart';
import 'package:cuida_pet/app/shared/theme_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';

import 'estabelecimento_controller.dart';

class EstabelecimentoPage extends StatefulWidget {
  final int estabelecimentoId;
  const EstabelecimentoPage({
    Key key,
    @required this.estabelecimentoId,
  }) : super(key: key);

  @override
  _EstabelecimentoPageState createState() => _EstabelecimentoPageState();
}

class _EstabelecimentoPageState
    extends ModularState<EstabelecimentoPage, EstabelecimentoController> {
  //use 'controller' variable to access controller
  @override
  void initState() {
    super.initState();
    controller.initPage(widget.estabelecimentoId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: Observer(builder: (_) {
        return AnimatedOpacity(
          duration: Duration(milliseconds: 300),
          opacity: controller.servicosSelecionados.isNotEmpty ? 1 : 0,
          child: FloatingActionButton.extended(
            backgroundColor: ThemeUtils.primaryColor,
            onPressed: () => Modular.to.pushNamed('/agendamento', arguments: {
              'estabelecimentoId': widget.estabelecimentoId,
              'servicosSelecionados': controller.servicosSelecionados
            }),
            icon: Icon(Icons.schedule),
            label: Text('Fazer Agendamento'),
          ),
        );
      }),
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
    return FutureBuilder(
      future: controller.fornecedorFuture,
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
              return Center(child: Text('Erro ao buscar dado do fornecedor'));
            }
            if (snapshot.hasData) {
              FornecedorModel f = snapshot.data;
              return CustomScrollView(
                slivers: [
                  SliverAppBar(
                    pinned: true,
                    expandedHeight: 300,
                    backgroundColor: Colors.white,
                    flexibleSpace: FlexibleSpaceBar(
                      title: Text(f.nome),
                      centerTitle: true,
                      stretchModes: [
                        StretchMode.zoomBackground,
                        StretchMode.fadeTitle
                      ],
                      background: Image.network(f.logo),
                    ),
                  ),
                  Observer(builder: (_) {
                    return SliverList(
                      delegate: SliverChildListDelegate(
                        [
                          Divider(
                            thickness: 1,
                            color: ThemeUtils.primaryColor,
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              'Informações do Estabelecimento',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 15,
                              ),
                            ),
                          ),
                          ListTile(
                            onTap: () {
                              Clipboard.setData(ClipboardData(text: f.endereco))
                                  .then((_) {
                                Get.snackbar('Copia', 'Endereço Copiado');
                              });
                            },
                            leading:
                                Icon(Icons.location_city, color: Colors.black),
                            title: Text(f.endereco),
                          ),
                          ListTile(
                            onTap: () async {
                              if (await canLaunch('tel:${f.telefone}')) {
                                await launch('tel:${f.telefone}');
                              } else {
                                await Clipboard.setData(
                                        ClipboardData(text: f.endereco))
                                    .then((_) {
                                  Get.snackbar('Copia', 'Telefone Copiado');
                                });
                              }
                            },
                            leading:
                                Icon(Icons.local_phone, color: Colors.black),
                            title: Text(f.telefone),
                          ),
                          Divider(
                            thickness: 1,
                            color: ThemeUtils.primaryColor,
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              'Serviços (${controller.servicosSelecionados.length} selecionado${controller.servicosSelecionados.length > 1 ? 's' : ''})',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 15,
                              ),
                            ),
                          ),
                          _buildServicos()
                        ],
                      ),
                    );
                  }),
                ],
              );
            }
            return Center(child: Text('Nenhum Dado Encontrado'));

            break;
          default:
            return Container();
        }
      },
    );
  }

  Widget _buildServicos() {
    var formatReal = NumberFormat.currency(locale: 'pt_BR', symbol: 'R\$');
    return FutureBuilder<List<FornecedorServicosModel>>(
        future: controller.fornecedorServicosFuture,
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
                return Center(child: Text('Erro ao buscar dado do fornecedor'));
              }
              if (snapshot.hasData) {
                List<FornecedorServicosModel> f = snapshot.data;
                return ListView.builder(
                  physics: NeverScrollableScrollPhysics(),
                  padding: EdgeInsets.only(
                    bottom: controller.servicosSelecionados.isNotEmpty ? 60 : 0,
                  ),
                  shrinkWrap: true,
                  itemCount: f.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      leading: CircleAvatar(
                        child: Icon(Icons.pets),
                      ),
                      title: Text(f[index].nome),
                      subtitle: Text(formatReal.format(f[index].valor)),
                      trailing: IconButton(
                        onPressed: () =>
                            controller.adicionarOuRemoverServico(f[index]),
                        icon: controller.servicosSelecionados.contains(f[index])
                            ? Icon(
                                Icons.remove_circle,
                                color: Colors.red,
                                size: 30,
                              )
                            : Icon(
                                Icons.add_circle,
                                color: ThemeUtils.primaryColor,
                                size: 30,
                              ),
                      ),
                    );
                  },
                );
              }
              return Center(child: Text('Nenhum Dado Encontrado'));

              break;
            default:
              return Container();
          }
        });
  }
}
