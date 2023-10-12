import 'package:flutter/material.dart';

class AppMethod{
  static int calculateAge(DateTime dateOfBirth) {
    DateTime currentDate = DateTime.now();
    Duration difference = currentDate.difference(dateOfBirth);
    int year = (difference.inDays / 365).floor();
    int ageInMonths = difference.inDays ~/ 30;
    int remainingDays = difference.inDays % 30;

    if (remainingDays > 16) {
      int ageInMonthsbulat = ageInMonths + 1;
      return ageInMonthsbulat;
    } else {
      return ageInMonths;
    }

    // return('Usia: $year tahun $ageInMonths bulan $remainingDays hari');
  }

  static String indikatorBerat(double bb, double bbMin, double bbMax) {
    if(bb < bbMin) return 'Kurang';
    if(bb > bbMax) return 'Resiko Berat Badan Lebih';
    return 'Normal';
  }

  static String indikatorTinggi(double tb, double tbMin, double tbMax) {
    if(tb < tbMin) return 'Kurang';
    if(tb > tbMax) return 'Tinggi';
    return 'Normal';
  }
}