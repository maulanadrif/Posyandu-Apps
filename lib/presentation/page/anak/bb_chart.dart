// Example of a numeric combo chart with two series rendered as lines, and a
/// third rendered as points along the top line with a different color.
///
/// This example demonstrates a method for drawing points along a line using a
/// different color from the main series color. The line renderer supports
/// drawing points with the "includePoints" option, but those points will share
/// the same color as the line.
import 'package:community_charts_flutter/community_charts_flutter.dart'
    as charts;
import 'package:flutter/material.dart';
import 'package:posyandu_apps/config/constant/app_constant.dart';

class BBChart extends StatelessWidget {
  final List<charts.Series> seriesList;

  BBChart(
    this.seriesList,
  );

  /// Creates a [LineChart] with sample data and no transition.
  factory BBChart.withSampleData(double berat, double bbMin, double bbMax) {
    return new BBChart(
      _createSampleData(berat, bbMin, bbMax),
      // Disable animations for image tests.
    );
  }

  @override
  Widget build(BuildContext context) {
    return new charts.NumericComboChart(
      List.from(seriesList),
      // Configure the default renderer as a line renderer. This will be used
      // for any series that does not define a rendererIdKey.
      defaultRenderer: new charts.LineRendererConfig(),
      // Custom renderer configuration for the point series.
      customSeriesRenderers: [
        new charts.PointRendererConfig(
            // ID used to link series to this renderer.
            customRendererId: 'customPoint')
      ],
    );
  }

  /// Create one series with sample hard coded data.
  static List<charts.Series<LinearSales, int>> _createSampleData(
      double berat, double bbMin, double bbMax) {
    final desktopSalesData = [
      new LinearSales(0, bbMin),
      // new LinearSales(1, 2.5),
      // new LinearSales(1, 3.3),
      new LinearSales(2, bbMax),
    ];

    final mobileSalesData = [
      new LinearSales(1, berat),
    ];

    return [
      new charts.Series<LinearSales, int>(
        id: 'Desktop',
        colorFn: (_, __) => charts.MaterialPalette.blue.shadeDefault,
        domainFn: (LinearSales sales, _) => sales.year,
        measureFn: (LinearSales sales, _) => sales.sales,
        data: desktopSalesData,
      ),
      new charts.Series<LinearSales, int>(
          id: 'Mobile',
          colorFn: (_, __) => charts.MaterialPalette.green.shadeDefault,
          domainFn: (LinearSales sales, _) => sales.year,
          measureFn: (LinearSales sales, _) => sales.sales,
          data: mobileSalesData)
        // Configure our custom point renderer for this series.
        ..setAttribute(charts.rendererIdKey, 'customPoint'),
    ];
  }
}

/// Sample linear data type.
class LinearSales {
  final int year;
  final double sales;

  LinearSales(this.year, this.sales);
}
