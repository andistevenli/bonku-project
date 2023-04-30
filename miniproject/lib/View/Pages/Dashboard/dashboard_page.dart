import 'package:flutter/material.dart';
import 'package:miniproject/Model/formatter.dart';
import 'package:miniproject/View/Pages/Customer/create_customer_page.dart';
import 'package:miniproject/View/Pages/Customer/customers_list_page.dart';
import 'package:miniproject/View/View-Model/dashboard_view_model.dart';
import 'package:miniproject/View/Widgets/buttons.dart';
import 'package:miniproject/View/Widgets/statistic_box.dart';
import 'package:provider/provider.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  final Buttons myButton = Buttons();
  final StatisticBox myStatsBox = StatisticBox();
  final Formatter myFormatter = Formatter();

  provider(BuildContext context) {
    final provider = Provider.of<DashboardViewModel>(context, listen: false);
    provider.totalUtang();
    provider.totalPelanggan();
  }

  @override
  Widget build(BuildContext context) {
    provider(context);
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('KASBONKU'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Center(
          child: ListView(
            children: [
              Consumer<DashboardViewModel>(
                builder: (context, dashboardProvider, _) {
                  dashboardProvider.totalUtang();
                  dashboardProvider.totalPelanggan();
                  if (dashboardProvider.utang == null) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  //format uang
                  final int currency = dashboardProvider.utang!;
                  final String uang = myFormatter.formatUang.format(currency);
                  if (dashboardProvider.utang == 0) {
                    return myStatsBox.statsBox(
                      context,
                      'Total utang keseluruhan',
                      'tidak ada',
                    );
                  } else {
                    return myStatsBox.statsBox(
                      context,
                      'Total utang keseluruhan:',
                      uang,
                    );
                  }
                },
              ),
              const SizedBox(
                height: 20,
              ),
              Consumer<DashboardViewModel>(
                builder: (context, dashboardProvider, _) {
                  dashboardProvider.totalUtang();
                  dashboardProvider.totalPelanggan();
                  if (dashboardProvider.pelanggan == null) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  if (dashboardProvider.pelanggan == 0) {
                    return myStatsBox.statsBox(
                      context,
                      'Total pelanggan yang berutang',
                      'tidak ada',
                    );
                  } else {
                    return myStatsBox.statsBox(
                      context,
                      'Total pelanggan yang berutang:',
                      '${dashboardProvider.pelanggan} Orang',
                    );
                  }
                },
              ),
              const SizedBox(
                height: 20,
              ),
              const Text(
                'Menu',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                height: 20,
              ),
              myButton.primaryButton(
                context: context,
                onPressedEvent: () {
                  Navigator.pushNamed(context, CustomersListPage.routeName);
                },
                icon: Icons.visibility,
                label: 'Lihat Daftar Pelanggan',
              ),
              const SizedBox(
                height: 20,
              ),
              myButton.secondaryButton(
                context: context,
                onPressedEvent: () {
                  Navigator.pushNamed(context, CreateCustomerPage.routeName);
                },
                icon: Icons.person_add,
                label: 'Tambah Data Pelanggan',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
