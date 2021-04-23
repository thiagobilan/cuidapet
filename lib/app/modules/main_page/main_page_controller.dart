import 'package:mobx/mobx.dart';

part 'main_page_controller.g.dart';

class MainPageController = _MainPageControllerBase with _$MainPageController;

abstract class _MainPageControllerBase with Store {
  @observable
  int value = 0;

  @action
  void increment() {
    value++;
  }
}
