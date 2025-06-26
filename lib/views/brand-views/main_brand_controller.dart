import 'package:e_commerce_admin_app/views/brand-views/add_brand_form_screen.dart';
import 'package:e_commerce_admin_app/views/brand-views/brand_screen.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

class MainBrandController extends GetxController {
  RxInt currentIndex = 0.obs;
  
  RxList<Widget> brandScreen=[
    BrandScreen(),
    AddBrandFormScreen()
  ].obs;

  void toggleSwitch(int index){
    currentIndex.value = index;
  }
}