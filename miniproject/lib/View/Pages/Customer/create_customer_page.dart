import 'package:flutter/material.dart';
import 'package:miniproject/View/View-Model/customer_view_model.dart';
import 'package:miniproject/View/Widgets/alert_dialogs.dart';
import 'package:miniproject/View/Widgets/buttons.dart';
import 'package:miniproject/View/Widgets/text_form_fields.dart';
import 'package:provider/provider.dart';

import '../../Widgets/snack_bars.dart';

class CreateCustomerPage extends StatefulWidget {
  const CreateCustomerPage({super.key});
  static const routeName = '/createCustomerPage';

  @override
  State<CreateCustomerPage> createState() => _CreateCustomerPageState();
}

class _CreateCustomerPageState extends State<CreateCustomerPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _namaPelangganController =
      TextEditingController();
  final TextEditingController _batasUtangController = TextEditingController();
  final TextEditingController _utangController = TextEditingController();
  final TextEditingController _deskripsiController = TextEditingController();
  final TextFormFields myTextformfield = TextFormFields();
  final Buttons myButton = Buttons();
  final AlertDialogs myAlertDialog = AlertDialogs();
  final SnackBars mySnackBar = SnackBars();

  @override
  void dispose() {
    _namaPelangganController.dispose();
    _batasUtangController.dispose();
    _utangController.dispose();
    _deskripsiController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<CustomerViewModel>(context, listen: false);
    provider.readCustomers();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tambah Data Pelanggan'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(24, 24, 24, 0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              const Text(
                'Informasi Pelanggan:',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                height: 20,
              ),
              myTextformfield.textFormField(
                enabled: true,
                textEditingController: _namaPelangganController,
                textInputType: TextInputType.name,
                textCapitalization: TextCapitalization.words,
                helperText: 'Ketikkan nama pelanggan yang ingin dibuat',
                hintText: 'Contoh: Budi Hartanto',
                labelText: 'Nama Pelanggan',
                icon: Icons.person,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Nama tidak boleh kosong';
                  } else {
                    for (int i = 0; i < provider.daftarPelanggan!.length; i++) {
                      if (value == provider.daftarPelanggan![i].nama) {
                        return 'Nama ini sudah pernah ditambahkan';
                      }
                    }
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
              myTextformfield.textFormField(
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
              const Text(
                'Utang Awal:',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                height: 20,
              ),
              myTextformfield.textFormField(
                enabled: true,
                textEditingController: _utangController,
                textInputType: TextInputType.number,
                textCapitalization: TextCapitalization.none,
                helperText: 'Ketikkan nominal utang awal',
                hintText: 'Contoh: 10000',
                labelText: 'Utang',
                icon: Icons.attach_money,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Utang tidak boleh kosong';
                  } else {
                    if (int.parse(_utangController.text) >
                        int.parse(_batasUtangController.text)) {
                      return 'tidak boleh melebihi batas utang';
                    }
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
              myTextformfield.textFormField(
                enabled: true,
                textEditingController: _deskripsiController,
                textInputType: TextInputType.text,
                textCapitalization: TextCapitalization.sentences,
                helperText: 'Ketikkan deskripsi utang (nama barang/transaksi)',
                hintText: 'Contoh: Rokok Gudang Gula',
                labelText: 'Deskripsi',
                icon: Icons.description,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Deskripsi tidak boleh kosong';
                  }
                  return null;
                },
              ),
              const SizedBox(
                height: 20,
              ),
              myButton.primaryButton(
                context: context,
                onPressedEvent: () async {
                  if (_formKey.currentState!.validate()) {
                    showDialog(
                      context: context,
                      barrierDismissible: false,
                      builder: (context) => myAlertDialog.alertDialog(
                        context,
                        () {
                          provider.createCustomer(
                            _namaPelangganController.text,
                            int.parse(_batasUtangController.text),
                            _deskripsiController.text,
                            int.parse(_utangController.text),
                          );
                          if (context.mounted) {
                            Navigator.popUntil(
                              context,
                              ModalRoute.withName('/'),
                            );
                            ScaffoldMessengerState().hideCurrentSnackBar();
                            ScaffoldMessenger.of(context).showSnackBar(
                              mySnackBar.successSnackBar(
                                  content:
                                      'Data pelanggan berhasil ditambahkan',
                                  label: 'Mantap'),
                            );
                          }
                        },
                        'Data pelanggan tidak jadi ditambahkan',
                      ),
                    );
                  }
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
