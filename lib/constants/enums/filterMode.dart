import 'package:get/get.dart';

enum FilterMode{
  today,
  yesterday,
  thisMonth,
  fromto,
  all
}

extension FilterExtension on FilterMode {
  String get filterString {

    switch (this) {
      case FilterMode.fromto:
        return 'From-To';
      case FilterMode.yesterday:
        return 'Yesterday';
      case FilterMode.today:
        return 'Today';
      case FilterMode.thisMonth:
        return 'ThisMonth';
      case FilterMode.all:
        return 'All';
      default:
        return "";
    }

  }
}

enum DateMode{
  from,to
}