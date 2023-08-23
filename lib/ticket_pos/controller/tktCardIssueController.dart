import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TicketCardIssueController extends GetxController{
  TextEditingController txtAmount = TextEditingController();
RxBool isTapedOnlist =false.obs;
RxBool isTapedOncard =false.obs;
RxBool foc = false.obs;
RxString customer_city=''.obs;
RxString customer_mobile=''.obs;
RxString customer_name=''.obs;
RxString customer_dob=''.obs;
RxString customer_email=''.obs;

}