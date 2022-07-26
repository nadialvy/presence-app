import 'package:get/get.dart';
import 'package:presence_app/app/controllers/page_index_controller.dart';


class HomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PageIndexController>(
      () => PageIndexController(),
    );
  }
}
