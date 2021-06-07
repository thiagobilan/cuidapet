import 'package:cuida_pet/app/models/agendamento_model.dart';
import 'package:cuida_pet/app/shared/theme_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:intl/intl.dart';
import 'meusagendamentos_controller.dart';

class MeusagendamentosPage extends StatefulWidget {
  const MeusagendamentosPage({Key key}) : super(key: key);

  @override
  _MeusagendamentosPageState createState() => _MeusagendamentosPageState();
}

class _MeusagendamentosPageState
    extends ModularState<MeusagendamentosPage, MeusagendamentosController> {
  //use 'controller' variable to access controller
  var dateFormat = DateFormat('dd/MM/yyyy');
  @override
  void initState() {
    super.initState();
    controller.buscarAgendamento();
  }

  var status = {
    'P': 'Pendente',
    'CN': 'Confirmada',
    'F': 'Finalizada',
    'C': 'Cancelada'
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Histórico de Agendamentos'),
      ),
      body: FutureBuilder<List<AgendamentoModel>>(
        future: controller.agendamentosFuture,
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
                  child: Text('Erro ao buscar os agendamentos!'),
                );
              }
              if (!snapshot.hasData) {
                return Center(
                  child: Text('Nenhum Agendamento Encontrado'),
                );
              }
              var agendamentos = snapshot.data;
              return ListView.builder(
                itemCount: agendamentos.length,
                itemBuilder: (context, index) {
                  var agendamento = agendamentos[index];
                  return Container(
                    padding: const EdgeInsets.all(15),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            dateFormat.format(agendamento.dataAgendamento),
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 15),
                          ),
                        ),
                        Card(
                          child: Column(
                            children: [
                              ListTile(
                                leading: CircleAvatar(
                                  backgroundImage:
                                      NetworkImage(agendamento.fornecedor.logo),
                                ),
                                title: Text(agendamento.nome),
                                subtitle: Text(status[agendamento.status]),
                              ),
                              Divider(),
                              ListView.builder(
                                physics: NeverScrollableScrollPhysics(),
                                shrinkWrap: true,
                                itemCount: agendamento.servicos.length,
                                itemBuilder: (context, index) {
                                  var servico = agendamento.servicos[index];
                                  return ListTile(
                                    leading: Icon(
                                      Icons.looks_one,
                                      color: ThemeUtils.primaryColor,
                                    ),
                                    title: Text(servico.nome),
                                    subtitle: Text(
                                        'R\$ ${servico.valor.toStringAsFixed(2)}'),
                                  );
                                },
                              ),
                              Divider(),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 8.0),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      'Total',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 15),
                                    ),
                                    Text(
                                      'R\$ ${controller.calcularTotal(agendamento.servicos).toStringAsFixed(2)}',
                                      style: TextStyle(
                                          color: Colors.red, fontSize: 15),
                                    ),
                                    Text(
                                      'Total de serviços',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 15),
                                    ),
                                    Text(agendamento.servicos.length.toString(),
                                        style: TextStyle(
                                            color: Colors.blue, fontSize: 15)),
                                  ],
                                ),
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                  );
                },
              );
              break;
            default:
              return Container();
          }
        },
      ),
    );
  }
}
