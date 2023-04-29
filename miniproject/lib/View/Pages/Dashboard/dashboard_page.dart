import 'package:flutter/material.dart';
import 'package:miniproject/View/Pages/Dashboard/dashboard_view_model.dart';
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

  // final supabase = Supabase.instance.client;

  // Future totalUtang() async {
  //   int total = 0;
  //   final List<dynamic> daftarSemuaUtang =
  //       await supabase.from('transaksi').select('utang');
  //   for (int i = 0; i < daftarSemuaUtang.length; i++) {
  //     total += int.parse(daftarSemuaUtang[i]
  //         .toString()
  //         .substring(8, daftarSemuaUtang[i].toString().length - 1));
  //   }
  //   return total;
  // }

  @override
  Widget build(BuildContext context) {
    Provider.of<DashboardViewModel>(context, listen: false);

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
                  return FutureBuilder(
                    future: dashboardProvider.totalUtang(),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        return myStatsBox.statsBox(
                            context,
                            'Total utang keseluruhan:',
                            'Rp ${snapshot.data.toString()}');
                      } else {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      }
                    },
                  );
                },
              ),
              const SizedBox(
                height: 20,
              ),
              Consumer<DashboardViewModel>(
                builder: (context, dashboardProvider, _) {
                  return FutureBuilder(
                    future: dashboardProvider.totalPelanggan(),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        return myStatsBox.statsBox(
                            context,
                            'Total pelanggan yang berutang:',
                            '${snapshot.data.toString()} Orang');
                      } else {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      }
                    },
                  );
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
                  //ke halaman lain
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
