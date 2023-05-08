import 'package:flutter/material.dart';
import 'package:miniproject/Model/formatter.dart';
import 'package:miniproject/View/View-Model/customer_view_model.dart';
import 'package:miniproject/View/Widgets/buttons.dart';
import 'package:miniproject/View/Widgets/list_tiles.dart';
import 'package:miniproject/View/Widgets/my_colors.dart';
import 'package:miniproject/View/Widgets/text_form_fields.dart';
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
  final TextFormFields myTextFormField = TextFormFields();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _seachTextEditingController =
      TextEditingController();
  final Buttons myButton = Buttons();
  final MyColors myColor = MyColors();
  bool active = false;

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
              _seachTextEditingController.clear();
              active = false;
            },
            icon: const Icon(Icons.refresh),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: ListView(
          physics: const BouncingScrollPhysics(),
          children: [
            Form(
              key: _formKey,
              child: Consumer<CustomerViewModel>(
                builder: (context, customerProvider, _) {
                  return Row(
                    children: [
                      myTextFormField.searchTextFormField(
                        width:
                            MediaQuery.of(context).size.width - (24 * 2) - 90,
                        enabled: true,
                        textEditingController: _seachTextEditingController,
                        validator: (value) {
                          List<String> word = value!.split(' ');
                          for (int i = 0; i < word.length; i++) {
                            if (!RegExp(r'^[A-Za-z]+$').hasMatch(word[i])) {
                              return 'hanya boleh diisi alphabet';
                            }
                          }
                          return null;
                        },
                        onChangedEvent: (value) {
                          if (_formKey.currentState!.validate()) {
                            if (value.isEmpty) {
                              active = false;
                              customerProvider.readCustomers();
                            } else {
                              active = true;
                              customerProvider.readCustomersBySearch(
                                  _seachTextEditingController.text);
                            }
                          }
                        },
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      myButton.textButton(
                        active: active,
                        width: 80,
                        color: myColor.detailTextColor,
                        label: 'Hapus',
                        onPressedEvent: active
                            ? () {
                                _seachTextEditingController.clear();
                                customerProvider.readCustomers();
                                active = false;
                              }
                            : null,
                      ),
                    ],
                  );
                },
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Consumer<CustomerViewModel>(
              builder: (context, customerProvider, _) {
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
                  return Material(
                    color: Colors.white,
                    child: ListView.separated(
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        //format tanggal
                        final DateTime dateTime = DateTime.parse(
                            customerProvider
                                .daftarPelanggan![index].createdAt!);
                        final String tanggal =
                            myFormatter.formatTanggal.format(dateTime);
                        //format mata uang
                        final int currency = customerProvider
                            .daftarPelanggan![index].batasUtang!;
                        final String uang =
                            myFormatter.formatUang.format(currency);
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
                    ),
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
