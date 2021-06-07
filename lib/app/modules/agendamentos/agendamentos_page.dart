import 'package:cuida_pet/app/models/fornecedor_servicos_model.dart';
import 'package:cuida_pet/app/shared/components/cuidapet_textformfild.dart';
import 'package:cuida_pet/app/shared/theme_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_calendar_carousel/flutter_calendar_carousel.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'agendamentos_controller.dart';

class AgendamentosPage extends StatefulWidget {
  final int estabelecimento;
  final List<FornecedorServicosModel> servicos;
  const AgendamentosPage({
    Key key,
    @required this.estabelecimento,
    @required this.servicos,
  }) : super(key: key);

  @override
  _AgendamentosPageState createState() => _AgendamentosPageState();
}

class _AgendamentosPageState
    extends ModularState<AgendamentosPage, AgendamentosController> {
  //use 'controller' variable to access controller

  @override
  Widget build(BuildContext context) {
    var formatReal = NumberFormat.currency(locale: 'pt', symbol: 'R\$');
    return Scaffold(
      body: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            excludeHeaderSemantics: true,
            title: Text('Escolha uma data'),
            backgroundColor: Colors.transparent,
          ),
          SliverList(
            delegate: SliverChildListDelegate(
              [
                Observer(
                  builder: (_) {
                    return CalendarCarousel(
                      iconColor: ThemeUtils.primaryColor,
                      pageScrollPhysics: NeverScrollableScrollPhysics(),
                      customGridViewPhysics: NeverScrollableScrollPhysics(),
                      locale: 'pt_BR',
                      headerTextStyle: TextStyle(
                          color: ThemeUtils.primaryColor, fontSize: 25),
                      height: 420,
                      selectedDateTime: controller.dataSelecionada,
                      onDayPressed: (day, _) {
                        controller.alterarData(day);
                      },
                    );
                  },
                ),
                FlatButton(
                  onPressed: () async {
                    var horario = await showTimePicker(
                        context: context,
                        initialTime: controller.horarioSelecionada);
                    controller.alterarHorario(horario);
                  },
                  textColor: ThemeUtils.primaryColor,
                  child: Column(
                    children: [
                      Text('Selecione um horario'),
                      Observer(builder: (_) {
                        return Text(
                            controller.horarioSelecionada.format(context));
                      }),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: Text(
                    'Serviços',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
                    ),
                  ),
                ),
                ListView.builder(
                  physics: NeverScrollableScrollPhysics(),
                  padding: EdgeInsets.symmetric(horizontal: 15),
                  shrinkWrap: true,
                  itemCount: widget.servicos.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      title: Text(widget.servicos[index].nome),
                      subtitle:
                          Text(formatReal.format(widget.servicos[index].valor)),
                    );
                  },
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                  child: Text(
                    'Dados para Reserva',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
                    ),
                  ),
                ),
                Form(
                  key: controller.formKey,
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: CuidapetTextformfild(
                          label: 'Seu Nome',
                          controller: controller.nomeController,
                          validator: (value) {
                            if (value.isEmpty) {
                              return 'Nome Obrigatorio';
                            }
                            return null;
                          },
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: CuidapetTextformfild(
                          label: 'Nome do Pet',
                          controller: controller.petController,
                          validator: (value) {
                            if (value.isEmpty) {
                              return 'Nome do Pet Obrigatorio';
                            }
                            return null;
                          },
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(bottom: 20),
                  padding: const EdgeInsets.all(10),
                  width: ScreenUtil.screenWidthDp,
                  child: RaisedButton(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20)),
                    onPressed: () => controller.salvarAgendamento(
                        estabelecimento: widget.estabelecimento,
                        servicos: widget.servicos),
                    color: ThemeUtils.primaryColor,
                    child: Text('Agendar',
                        style: TextStyle(
                          fontSize: 20,
                          color: Colors.white,
                        )),
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
