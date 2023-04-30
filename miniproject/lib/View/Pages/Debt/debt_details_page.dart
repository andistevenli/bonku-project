import 'package:flutter/material.dart';
import 'package:miniproject/View/Pages/Customer/customers_list_page.dart';
import 'package:miniproject/View/View-Model/debt_view_model.dart';
import 'package:miniproject/View/Widgets/list_tiles.dart';
import 'package:miniproject/View/Widgets/my_colors.dart';
import 'package:provider/provider.dart';

import '../../../Model/formatter.dart';

class DebtDetailsPage extends StatefulWidget {
  const DebtDetailsPage({super.key});
  static const routeName = '/debtDetailsPage';

  @override
  State<DebtDetailsPage> createState() => _DebtDetailsState();
}

class _DebtDetailsState extends State<DebtDetailsPage> {
  final ListTiles myListTile = ListTiles();
  final MyColors myColors = MyColors();
  final Formatter myFormatter = Formatter();

  provider(BuildContext context, int id) {
    final provider = Provider.of<DebtViewModel>(context, listen: false);
    provider.getAllTransactions(id);
    provider.totalUtang(id);
  }

  @override
  Widget build(BuildContext context) {
    final args =
        ModalRoute.of(context)!.settings.arguments as DebtDetailsArguments;
    provider(context, args.idPelanggan);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Detail Utang'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(24, 24, 24, 0),
        child: ListView(
          physics: const NeverScrollableScrollPhysics(),
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  'Atas nama',
                  style: TextStyle(color: myColors.subInfoColor),
                ),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  args.nama,
                  style: const TextStyle(
                      fontSize: 18, fontWeight: FontWeight.w700),
                ),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Total utang:',
                  style: TextStyle(color: myColors.subInfoColor),
                ),
                const SizedBox(
                  width: 20,
                ),
                Consumer<DebtViewModel>(builder: (context, debtProvider, _) {
                  debtProvider.totalUtang(args.idPelanggan);
                  if (debtProvider.utang == null) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  //ubah format uang
                  final int currency = debtProvider.utang!;
                  final String utang = myFormatter.formatUang.format(currency);
                  return Text(
                    utang,
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: myColors.primaryColor,
                    ),
                  );
                }),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            Text(
              'Ketuk pada barang yang ingin dilunaskan:',
              style: TextStyle(color: myColors.subInfoColor),
            ),
            const SizedBox(
              height: 20,
            ),
            Consumer<DebtViewModel>(builder: (context, debtProvider, _) {
              debtProvider.getAllTransactions(args.idPelanggan);
              if (debtProvider.daftarUtang == null) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
              return ListView.separated(
                physics: const BouncingScrollPhysics(),
                shrinkWrap: true,
                itemCount: debtProvider.daftarUtang!.length,
                itemBuilder: (context, index) {
                  //ubah format uang
                  final int currency =
                      debtProvider.daftarUtang![index]['utang'];
                  final String utang = myFormatter.formatUang.format(currency);
                  //ubah format tanggal
                  final DateTime dateTime = DateTime.parse(
                      debtProvider.daftarUtang![index]['created_at']);
                  final String tanggal =
                      myFormatter.formatTanggal.format(dateTime);
                  return myListTile.debtDetailsListTile(
                    context,
                    debtProvider.daftarUtang![index]['deskripsi'],
                    utang,
                    tanggal,
                    debtProvider.daftarUtang![index]['id_pelanggan'],
                  );
                },
                separatorBuilder: (context, index) {
                  return const SizedBox(
                    height: 10,
                  );
                },
              );
            }),
          ],
        ),
      ),
    );
  }
}

class DebtDetailsArguments {
  final int idPelanggan;
  final String nama;

  DebtDetailsArguments({
    required this.idPelanggan,
    required this.nama,
  });
}
