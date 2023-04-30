import 'package:flutter/material.dart';
import 'package:miniproject/View/Widgets/buttons.dart';
import 'package:miniproject/View/Widgets/my_colors.dart';

class ListTiles {
  final MyColors myColors = MyColors();
  final Buttons btn = Buttons();

  ListTile customersListTile(
    BuildContext context,
    String title,
    String batasUtang,
    String tanggal,
  ) {
    return ListTile(
      visualDensity: const VisualDensity(vertical: 3),
      title: Text(
        title,
        style: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold,
        ),
      ),
      subtitle: const Text('Ketuk untuk melihat lebih detail'),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      tileColor: myColors.listTileBgColor,
      onTap: () {
        showModalBottomSheet(
          isScrollControlled: true,
          context: context,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(30),
              topRight: Radius.circular(30),
            ),
          ),
          builder: (context) {
            return Container(
              height: MediaQuery.of(context).size.height * 0.6,
              margin: const EdgeInsets.fromLTRB(24, 20, 24, 30),
              child: Column(
                children: [
                  const Icon(Icons.keyboard_double_arrow_down,
                      color: Colors.grey),
                  const SizedBox(
                    height: 20,
                  ),
                  Text(
                    'Atas nama',
                    style: TextStyle(color: myColors.subInfoColor),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    title,
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w700,
                        color: myColors.primaryColor),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        'Dibuat tanggal: ',
                        style: TextStyle(
                          color: myColors.subInfoColor,
                        ),
                      ),
                      Text(
                        tanggal,
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        'Batas Utang: ',
                        style: TextStyle(
                          color: myColors.subInfoColor,
                        ),
                      ),
                      Text(
                        batasUtang,
                        style: TextStyle(
                          fontSize: 18,
                          color: myColors.detailTextColor,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  btn.secondaryButton(
                    context: context,
                    onPressedEvent: () {
                      // Navigator.pushNamed(
                      //   context,
                      //   ChangeCustomer.routeName,
                      //   arguments: ChangeCustomerArguments(
                      //       namaPelanggan: title,
                      //       nominalBatasUtang: batasUtang),
                      // );
                    },
                    icon: Icons.edit,
                    label: 'Ubah Pelanggan',
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  btn.secondaryButton(
                    context: context,
                    onPressedEvent: () {
                      // Navigator.pushNamed(
                      //   context,
                      //   DebtDetails.routeName,
                      //   arguments: DebtDetailsArguments(
                      //     nama: title,
                      //     totalUtang: utang,
                      //   ),
                      // );
                    },
                    icon: Icons.visibility,
                    label: 'Lihat Detail Utang',
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  btn.primaryButton(
                    context: context,
                    onPressedEvent: () {
                      // Navigator.pushNamed(
                      //   context,
                      //   AddDebt.routeName,
                      //   arguments: AddDebtArguments(nama: title),
                      // );
                    },
                    icon: Icons.add,
                    label: 'Tambah Utang',
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }

  ListTile debtDetailsListTile(
    BuildContext context,
    String title,
    String utang,
    String subtitle,
  ) {
    return ListTile(
      visualDensity: const VisualDensity(vertical: 3),
      title: Text(
        title,
      ),
      subtitle: Text(
        subtitle,
        style: TextStyle(
          color: myColors.detailTextColor,
        ),
      ),
      trailing: Text(
        utang,
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(14),
      ),
      tileColor: myColors.listTileBgColor,
      onTap: () {
        showDialog(
          barrierDismissible: false,
          context: context,
          builder: (context) => AlertDialog(
            title: Text(
              'Konfirmasi Pelunasan',
              style: TextStyle(color: myColors.primaryColor),
            ),
            content: Text('$title\n$utang\n\n$subtitle\n\nMau dilunasin ?'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text('Tidak'),
              ),
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text('Iya'),
              ),
            ],
          ),
        );
      },
    );
  }
}
