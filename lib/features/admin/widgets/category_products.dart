import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;

import '../models/sales.dart';

class CategoryProductsChart extends StatelessWidget {
  const CategoryProductsChart({Key? key, required this.seriesList}) : super(key: key);
final List<charts.Series<Sales,String>> seriesList;
  @override
  Widget build(BuildContext context) {
    return charts.BarChart(
      seriesList,animate: true,
    );
  }
}
