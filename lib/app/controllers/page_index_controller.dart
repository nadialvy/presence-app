import 'package:get/get.dart';
import 'package:presence_app/app/routes/app_pages.dart';

class PageIndexController extends GetxController {
  RxInt pageIndex = 0.obs;

  void changePage(i) async {
    print('click index=$i');
    pageIndex.value = i;
    
    switch(i){
      case 1:
        print('ABSEN');
        break;
      case 2:
        Get.offAllNamed(Routes.PROFILE);
        break;
      default:
        Get.offAllNamed(Routes.HOME);
    }
  }
}
