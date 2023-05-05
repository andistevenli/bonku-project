import 'package:flutter/material.dart';
import 'package:miniproject/View/View-Model/debt_view_model.dart';
import 'package:miniproject/View/Widgets/list_tiles.dart';
import 'package:miniproject/View/Widgets/my_colors.dart';
import 'package:provider/provider.dart';
import '../../../Model/formatter.dart';
import '../../Widgets/loading_animation.dart';

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
  final LoadingAnimation myLoadingAnimation = LoadingAnimation();

  provider(BuildContext context, int id) {
    final provider = Provider.of<DebtViewModel>(context, listen: false);
    provider.readDebt(id);
    provider.debtSum(id);
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
        actions: [
          IconButton(
            onPressed: () {
              provider(context, args.idPelanggan);
            },
            icon: const Icon(Icons.refresh),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(24),
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
                  debtProvider.debtSum(args.idPelanggan);
                  if (debtProvider.utang.isEmpty) {
                    return Center(
                      child: myLoadingAnimation.fourRotatingDots(),
                    );
                  }
                  //ubah format uang
                  final int currency = debtProvider.totalUtang;
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
              debtProvider.readDebt(args.idPelanggan);
              if (debtProvider.daftarUtang == null ||
                  debtProvider.daftarUtang!.isEmpty) {
                return Center(
                  child: myLoadingAnimation.fourRotatingDots(),
                );
              }
              return ListView.separated(
                physics: const BouncingScrollPhysics(),
                shrinkWrap: true,
                itemCount: debtProvider.daftarUtang!.length,
                itemBuilder: (context, index) {
                  //ubah format uang
                  final int currency = debtProvider.daftarUtang![index].utang!;
                  final String utang = myFormatter.formatUang.format(currency);
                  //ubah format tanggal
                  final DateTime dateTime = DateTime.parse(
                      debtProvider.daftarUtang![index].createdAt!);
                  final String tanggal =
                      myFormatter.formatTanggal.format(dateTime);
                  return myListTile.debtDetailsListTile(
                    context,
                    debtProvider.daftarUtang![index].deskripsi!,
                    utang,
                    tanggal,
                    debtProvider.daftarUtang![index].idPelanggan!,
                    debtProvider.daftarUtang![index].id!,
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
