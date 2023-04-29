import 'package:flutter/material.dart';
import 'package:miniproject/View/Pages/Customer/create_customer.dart';
import 'package:miniproject/View/View-Model/dashboard_view_model.dart';
import 'package:miniproject/View/Widgets/buttons.dart';
import 'package:miniproject/View/Widgets/statistic_box.dart';
import 'package:provider/provider.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});
  static const routeName = '/dashboardPage';

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  Buttons myButton = Buttons();
  StatisticBox myStatsBox = StatisticBox();

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
        actions: [
          IconButton(
            onPressed: () {
              provider(context);
            },
            icon: const Icon(Icons.refresh),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Center(
          child: ListView(
            children: [
              Consumer<DashboardViewModel>(
                builder: (context, dashboardProvider, _) {
                  return myStatsBox.statsBox(
                    context,
                    'Total utang keseluruhan:',
                    'Rp ${dashboardProvider.utang}',
                  );
                },
              ),
              const SizedBox(
                height: 20,
              ),
              Consumer<DashboardViewModel>(
                builder: (context, dashboardProvider, _) {
                  return myStatsBox.statsBox(
                      context,
                      'Total pelanggan yang berutang:',
                      '${dashboardProvider.pelanggan} Orang');
                },
              ),
              const SizedBox(
                height: 20,
              ),
              const Text(
                'Menu',
                style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                height: 20,
              ),
              myButton.primaryButton(
                context: context,
                onPressedEvent: () {
                  //ke halaman lain
                },
                icon: Icons.list,
                label: 'Daftar Pelanggan',
              ),
              const SizedBox(
                height: 20,
              ),
              myButton.secondaryButton(
                context: context,
                onPressedEvent: () {
                  Navigator.pushNamed(context, CreateCustomer.routeName);
                },
                icon: Icons.person_add,
                label: 'Tambah Pelanggan',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
