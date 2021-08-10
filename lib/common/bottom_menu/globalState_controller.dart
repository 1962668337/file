import 'package:get/get.dart';

class GlobalStateController extends GetxController {
  MainState state = MainState();

  changeBottomBarIndex(int index) {
    state.bottombarIindex.value = index;
    print(state.bottombarIindex.value);
  }
}

class MainState {
  var bottombarIindex = 0.obs;
}
