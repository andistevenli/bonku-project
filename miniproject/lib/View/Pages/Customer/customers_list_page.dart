import 'package:flutter/material.dart';
import 'package:miniproject/Model/formatter.dart';
import 'package:miniproject/View/View-Model/customer_view_model.dart';
import 'package:miniproject/View/Widgets/list_tiles.dart';
import 'package:provider/provider.dart';

class CustomersListPage extends StatefulWidget {
  const CustomersListPage({super.key});
  static const routeName = '/customersListPage';

  @override
  State<CustomersListPage> createState() => _CustomersListPageState();
}

class _CustomersListPageState extends State<CustomersListPage> {
  final ListTiles myListTile = ListTiles();
  final Formatter myFormatter = Formatter();

  provider(BuildContext context) {
    final provider = Provider.of<CustomerViewModel>(context, listen: false);
    provider.getAllCustomers();
  }

  @override
  Widget build(BuildContext context) {
    provider(context);
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
        padding: const EdgeInsets.fromLTRB(24, 24, 24, 0),
        child: Consumer<CustomerViewModel>(
          builder: (context, customerProvider, _) {
            if (customerProvider.daftarPelanggan.isEmpty) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else {
              return ListView.separated(
                physics: const BouncingScrollPhysics(),
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  //format tanggal
                  final DateTime dateTime = DateTime.parse(
                      customerProvider.daftarPelanggan[index]['created_at']);
                  final String tanggal =
                      myFormatter.formatTanggal.format(dateTime);
                  //format mata uang
                  final int currency =
                      customerProvider.daftarPelanggan[index]['batas_utang'];
                  final String uang = myFormatter.formatUang.format(currency);
                  return myListTile.customersListTile(
                    context,
                    customerProvider.daftarPelanggan[index]['nama'],
                    uang,
                    tanggal,
                    customerProvider.daftarPelanggan[index]['id'],
                  );
                },
                separatorBuilder: ((context, index) {
                  return const SizedBox(
                    height: 10,
                  );
                }),
                itemCount: customerProvider.daftarPelanggan.length,
              );
            }
          },
        ),
      ),
    );
  }
}
