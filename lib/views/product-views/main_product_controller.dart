import 'package:e_commerce_admin_app/views/product-views/addProduct_form_screen.dart';
import 'package:e_commerce_admin_app/views/product-views/product_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MainProductController extends GetxController{

  RxList<Widget> mainProducts = <Widget>[
    ProductScreen(),
    AddProductFormScreen()
  ].obs;

  RxInt currentIndex = 0.obs;

  void toggleSwitch(int index){
    currentIndex.value = index;
    

  }
}