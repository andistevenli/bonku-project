import 'package:flutter/material.dart';
import 'package:miniproject/View/Pages/Customer/change_customer_page.dart';
import 'package:miniproject/View/Pages/Customer/customers_list_page.dart';
import 'package:miniproject/View/Pages/Debt/add_debt_page.dart';
import 'package:miniproject/View/Pages/Debt/debt_details_page.dart';
import 'package:miniproject/View/View-Model/debt_view_model.dart';
import 'package:miniproject/View/Widgets/alert_dialogs.dart';
import 'package:miniproject/View/Widgets/buttons.dart';
import 'package:miniproject/View/Widgets/my_colors.dart';
import 'package:provider/provider.dart';
import '../View-Model/customer_view_model.dart';

class ListTiles {
  final MyColors myColors = MyColors();
  final Buttons myButton = Buttons();
  final AlertDialogs myAlertDialog = AlertDialogs();

  ListTile customersListTile(
    BuildContext context,
    String title,
    String formatBatasUtang,
    String formatTanggal,
    int id,
    int batasUtang,
  ) {
    final provider = Provider.of<CustomerViewModel>(context, listen: false);
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
              height: MediaQuery.of(context).size.height * 0.7,
              margin: const EdgeInsets.fromLTRB(24, 24, 24, 24),
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
                        formatTanggal,
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
                        formatBatasUtang,
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
                  myButton.secondaryButton(
                    context: context,
                    onPressedEvent: () {
                      Navigator.pushNamed(
                        context,
                        ChangeCustomerPage.routeName,
                        arguments: ChangeCustomerArguments(
                          idPelanggan: id,
                          namaPelanggan: title,
                          nominalBatasUtang: formatBatasUtang,
                        ),
                      );
                    },
                    icon: Icons.edit,
                    label: 'Ubah Data Pelanggan',
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  myButton.secondaryButton(
                    context: context,
                    onPressedEvent: () {
                      Navigator.pushNamed(
                        context,
                        DebtDetailsPage.routeName,
                        arguments: DebtDetailsArguments(
                          idPelanggan: id,
                          nama: title,
                        ),
                      );
                    },
                    icon: Icons.visibility,
                    label: 'Lihat Utang',
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  myButton.primaryButton(
                    context: context,
                    onPressedEvent: () {
                      Navigator.pushNamed(
                        context,
                        AddDebtPage.routeName,
                        arguments: AddDebtArguments(
                          idPelanggan: id,
                          nama: title,
                          batasUtang: batasUtang,
                        ),
                      );
                    },
                    icon: Icons.add,
                    label: 'Tambah Utang',
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  myButton.tertiaryButton(
                    context: context,
                    onPressedEvent: () {
                      showDialog(
                        barrierDismissible: false,
                        context: context,
                        builder: (context) => myAlertDialog.alertDialog(
                          context,
                          () {
                            provider.deleteCustomer(id);
                            Navigator.popUntil(
                              context,
                              ModalRoute.withName(CustomersListPage.routeName),
                            );
                          },
                        ),
                      );
                    },
                    icon: Icons.delete,
                    label: 'Hapus Data Pelanggan',
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
    int id,
  ) {
    final provider = Provider.of<DebtViewModel>(context, listen: false);
    return ListTile(
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
                  if (provider.daftarUtang!.length == 1) {
                    Navigator.popUntil(context,
                        ModalRoute.withName(CustomersListPage.routeName));
                    provider.deleteDebt(id);
                    provider.deleteCustomerIfNoDebtAnymore(id);
                  } else {
                    provider.deleteDebt(id);
                    Navigator.pop(context);
                  }
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
