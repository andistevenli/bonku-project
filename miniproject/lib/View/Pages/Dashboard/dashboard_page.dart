import 'package:flutter/material.dart';
import 'package:miniproject/Model/formatter.dart';
import 'package:miniproject/View/Pages/Customer/create_customer_page.dart';
import 'package:miniproject/View/Pages/Customer/customers_list_page.dart';
import 'package:miniproject/View/View-Model/dashboard_view_model.dart';
import 'package:miniproject/View/Widgets/buttons.dart';
import 'package:miniproject/View/Widgets/loading_animation.dart';
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
  final LoadingAnimation myLoadingAnimation = LoadingAnimation();

  provider(BuildContext context) {
    final provider = Provider.of<DashboardViewModel>(context, listen: false);
    provider.debtSum();
    provider.customerSum();
  }

  @override
  void initState() {
    super.initState();
    provider(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Image.asset(
          'assets/logos/logo_Bonku_landscape.png',
          height: 40,
        ),
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
                  dashboardProvider.debtSum();
                  if (dashboardProvider.totalUtang == null) {
                    return SizedBox(
                      width: MediaQuery.of(context).size.width,
                      height: 150,
                      child: Center(
                        child: myLoadingAnimation.staggeredDotsWave(),
                      ),
                    );
                  }
                  //format uang
                  final int currency = dashboardProvider.totalUtang!;
                  final String uang = myFormatter.formatUang.format(currency);
                  if (dashboardProvider.totalUtang == 0) {
                    return myStatsBox.statsBox(
                      context,
                      'Total utang:',
                      'tidak ada',
                    );
                  } else {
                    return myStatsBox.statsBox(
                      context,
                      'Total utang:',
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
                  dashboardProvider.customerSum();
                  if (dashboardProvider.totalPelanggan == null) {
                    return SizedBox(
                      width: MediaQuery.of(context).size.width,
                      height: 150,
                      child: Center(
                        child: myLoadingAnimation.staggeredDotsWave(),
                      ),
                    );
                  }
                  if (dashboardProvider.totalPelanggan == 0) {
                    return myStatsBox.statsBox(
                      context,
                      'Total pelanggan:',
                      'tidak ada',
                    );
                  } else {
                    return myStatsBox.statsBox(
                      context,
                      'Total pelanggan:',
                      '${dashboardProvider.totalPelanggan} Orang',
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
