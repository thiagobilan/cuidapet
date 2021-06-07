import 'package:flutter_modular/flutter_modular_test.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:cuida_pet/app/modules/agendamentos/agendamentos_controller.dart';
import 'package:cuida_pet/app/modules/agendamentos/agendamentos_module.dart';

void main() {
  initModule(AgendamentosModule());
  // AgendamentosController agendamentos;
  //
  setUp(() {
    //     agendamentos = AgendamentosModule.to.get<AgendamentosController>();
  });

  group('AgendamentosController Test', () {
    //   test("First Test", () {
    //     expect(agendamentos, isInstanceOf<AgendamentosController>());
    //   });

    //   test("Set Value", () {
    //     expect(agendamentos.value, equals(0));
    //     agendamentos.increment();
    //     expect(agendamentos.value, equals(1));
    //   });
  });
}
