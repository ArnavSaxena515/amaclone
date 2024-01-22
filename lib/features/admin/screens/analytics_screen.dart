import 'package:amaclone/constants/loading_widget.dart';
import 'package:amaclone/features/admin/services/admin_services.dart';
import 'package:amaclone/features/admin/widgets/category_products.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flutter/material.dart';

import '../models/sales.dart';

class AnalyticsScreen extends StatefulWidget {
  const AnalyticsScreen({Key? key}) : super(key: key);

  @override
  State<AnalyticsScreen> createState() => _AnalyticsScreenState();
}

class _AnalyticsScreenState extends State<AnalyticsScreen> {
  late AdminServices adminServices;
  int? totalSales;
  List<Sales>? earnings;

  @override
  void initState() {
    adminServices = AdminServices(context: context);
    getEarnings();
    super.initState();
  }

  void getEarnings() async {
    var earningData = await adminServices.getEarnings();
    totalSales = earningData['totalEarnings'];
    earnings = earningData['sales'];

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return earnings == null || totalSales == null ? const LoadingWidget() :
    Column(
      children: [
        Text('\$$totalSales',
          style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),

        SizedBox(
          height: 250,
          child: CategoryProductsChart(seriesList: [
            charts.Series(
                id: 'Sales', data: earnings!, domainFn: (Sales sales,_)=>sales.label,
                measureFn: (Sales sales,_)=>sales.earning)
          ]),
        )
      ],
    );
  }
}
