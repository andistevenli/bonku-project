import 'package:flutter/material.dart';
import 'package:miniproject/View/Pages/Customer/customers_list_page.dart';
import 'package:miniproject/View/Widgets/alert_dialogs.dart';
import 'package:miniproject/View/Widgets/buttons.dart';
import 'package:miniproject/View/Widgets/my_colors.dart';
import 'package:miniproject/View/Widgets/text_form_fields.dart';
import 'package:provider/provider.dart';

import '../../View-Model/customer_view_model.dart';

class ChangeCustomerPage extends StatefulWidget {
  const ChangeCustomerPage({
    super.key,
  });

  static const routeName = '/changeCustomerPage';

  @override
  State<ChangeCustomerPage> createState() => _ChangeCustomerState();
}

class _ChangeCustomerState extends State<ChangeCustomerPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _customerNameController = TextEditingController();
  final TextEditingController _batasUtangController = TextEditingController();

  final TextFormFields myTextFormField = TextFormFields();
  final Buttons myButton = Buttons();
  final MyColors myColors = MyColors();
  final AlertDialogs myAlertDialog = AlertDialogs();

  @override
  void dispose() {
    _customerNameController.dispose();
    _batasUtangController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final args =
        ModalRoute.of(context)!.settings.arguments as ChangeCustomerArguments;

    final provider = Provider.of<CustomerViewModel>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Ubah Data Pelanggan'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(24, 24, 24, 0),
        child: Form(
          key: _formKey,
          child: ListView(
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
                    args.namaPelanggan,
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w700,
                        color: myColors.primaryColor),
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
                    'Batas utang: ',
                    style: TextStyle(
                      color: myColors.subInfoColor,
                    ),
                  ),
                  Text(
                    args.nominalBatasUtang,
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
              const Text(
                'Diubah menjadi:',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                height: 20,
              ),
              myTextFormField.textFormField(
                enabled: true,
                textEditingController: _customerNameController,
                textInputType: TextInputType.name,
                textCapitalization: TextCapitalization.words,
                helperText: 'Ketikkan nama pelanggan yang ingin diganti',
                hintText: 'Contoh: Budi Hartanto',
                labelText: 'Nama Pelanggan',
                icon: Icons.person,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Nama tidak boleh kosong';
                  } else {
                    List<String> word = value.split(' ');
                    for (int i = 0; i < word.length; i++) {
                      if (word[i].substring(0, 1) !=
                          word[i].substring(0, 1).toUpperCase()) {
                        return 'Setiap kata harus huruf kapital';
                      }
                      if (!RegExp(r'^[A-Za-z]+$').hasMatch(word[i])) {
                        return 'hanya boleh diisi alphabet';
                      }
                    }
                  }
                  return null;
                },
              ),
              const SizedBox(
                height: 20,
              ),
              myTextFormField.textFormField(
                enabled: true,
                textEditingController: _batasUtangController,
                textInputType: TextInputType.number,
                textCapitalization: TextCapitalization.none,
                helperText: 'Ketikkan batas utang yang dapat ditolerir',
                hintText: 'Contoh: 50000',
                labelText: 'Batas Utang',
                icon: Icons.attach_money,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Batas utang tidak boleh kosong';
                  } else {
                    if (!RegExp(r'^[0-9]+$').hasMatch(value)) {
                      return 'hanya boleh diisi angka';
                    }
                  }
                  return null;
                },
              ),
              const SizedBox(
                height: 20,
              ),
              myButton.primaryButton(
                context: context,
                onPressedEvent: () {
                  if (_formKey.currentState!.validate()) {
                    showDialog(
                      context: context,
                      barrierDismissible: false,
                      builder: (context) => myAlertDialog.alertDialog(
                        context,
                        () {
                          provider.changeCustomer(
                            args.idPelanggan,
                            _customerNameController.text,
                            int.parse(_batasUtangController.text),
                          );
                          if (context.mounted) {
                            Navigator.popUntil(
                              context,
                              ModalRoute.withName(CustomersListPage.routeName),
                            );
                          }
                        },
                      ),
                    );
                  }
                },
                icon: Icons.edit,
                label: 'Ubah Data Pelanggan',
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ChangeCustomerArguments {
  final int idPelanggan;
  final String namaPelanggan;
  final String nominalBatasUtang;

  ChangeCustomerArguments({
    required this.idPelanggan,
    required this.namaPelanggan,
    required this.nominalBatasUtang,
  });
}
