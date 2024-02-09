import 'package:flutter/foundation.dart';

String getAddress() {
  if (kDebugMode) {
    print("debug");
    return "http://165.227.152.216:8085";
  } else {
    print("deoply");
    return "gateway:8085";
  }
}
