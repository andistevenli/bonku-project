import 'package:flutter/material.dart';
import 'package:miniproject/Model/formatter.dart';
import 'package:miniproject/View/View-Model/customer_view_model.dart';
import 'package:miniproject/View/Widgets/list_tiles.dart';
import 'package:provider/provider.dart';
import 'package:lottie/lottie.dart';
import '../../Widgets/loading_animation.dart';

class CustomersListPage extends StatefulWidget {
  const CustomersListPage({super.key});
  static const routeName = '/customersListPage';

  @override
  State<CustomersListPage> createState() => _CustomersListPageState();
}

class _CustomersListPageState extends State<CustomersListPage> {
  final ListTiles myListTile = ListTiles();
  final Formatter myFormatter = Formatter();
  final LoadingAnimation myLoadingAnimation = LoadingAnimation();

  provider(BuildContext context) {
    final provider = Provider.of<CustomerViewModel>(context, listen: false);
    provider.readCustomers();
  }

  @override
  void initState() {
    super.initState();
    provider(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Daftar Pelanggan'),
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
        child: Consumer<CustomerViewModel>(
          builder: (context, customerProvider, _) {
            customerProvider.readCustomers();
            if (customerProvider.daftarPelanggan == null) {
              return Center(
                child: myLoadingAnimation.stretchedDots(),
              );
            }
            if (customerProvider.daftarPelanggan!.isEmpty) {
              return Center(
                child: Lottie.asset('assets/lotties/85023-no-data.json'),
              );
            } else {
              return ListView.separated(
                physics: const BouncingScrollPhysics(),
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  //format tanggal
                  final DateTime dateTime = DateTime.parse(
                      customerProvider.daftarPelanggan![index].createdAt!);
                  final String tanggal =
                      myFormatter.formatTanggal.format(dateTime);
                  //format mata uang
                  final int currency =
                      customerProvider.daftarPelanggan![index].batasUtang!;
                  final String uang = myFormatter.formatUang.format(currency);
                  return myListTile.customersListTile(
                    context,
                    customerProvider.daftarPelanggan![index].nama!,
                    uang,
                    tanggal,
                    customerProvider.daftarPelanggan![index].id!,
                    customerProvider.daftarPelanggan![index].batasUtang!,
                  );
                },
                separatorBuilder: ((context, index) {
                  return const SizedBox(
                    height: 10,
                  );
                }),
                itemCount: customerProvider.daftarPelanggan!.length,
              );
            }
          },
        ),
      ),
    );
  }
}
