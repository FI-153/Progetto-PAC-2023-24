import 'package:flutter/foundation.dart';

/**Addred del manager, diverso se la app viene lanciata in modalità debug o viene deployata (cambiare indirizzo del deploy con il proprio) */
String getAddress() {
  if (kDebugMode) {
    String deployAddress = "http://165.227.152.216";
    return "$deployAddress:8085";
  } else {
    return "gateway:8085";
  }
}
