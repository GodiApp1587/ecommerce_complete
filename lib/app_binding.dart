import 'package:get/instance_manager.dart';

import 'src/services/network/api_service.dart';
import 'src/services/network/base_provider.dart';

class AppBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(BaseProvider(), permanent: true);
    Get.put(ApiService(Get.find()), permanent: true);
  }
}
