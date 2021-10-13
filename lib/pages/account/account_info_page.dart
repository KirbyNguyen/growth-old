import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'package:growth/models/account_type.dart';
import 'package:growth/styles/text_field_style.dart';
import 'package:growth/providers/app_theme_provider.dart';
import 'package:growth/components/account_type_modal.dart';

class AccountInfoPage extends HookWidget {
  const AccountInfoPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments;

    final _useAppThemeState = useProvider(appThemeStateProvider);

    final _useAccountFormKey =
        useState<GlobalKey<FormState>>(GlobalKey<FormState>());

    final _useNameTextController =
        useTextEditingController.fromValue(TextEditingValue.empty);

    final _useTypeTextController =
        useTextEditingController.fromValue(TextEditingValue.empty);
    var _useAccountType = useState<AccountType?>(null);

    final _useCurrencyTextController =
        useTextEditingController.fromValue(TextEditingValue.empty);

    final _useBalanceTextController =
        useTextEditingController.fromValue(TextEditingValue.empty);

    final _useColorTextController =
        useTextEditingController.fromValue(TextEditingValue.empty);


    return Scaffold(
      appBar: AppBar(
        title: const Text("Account"),
      ),
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height * 0.80,
          padding: const EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 0.0),
          child: Form(
            key: _useAccountFormKey.value,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                // Name text field
                TextFormField(
                  controller: _useNameTextController,
                  decoration:
                      TextFieldDecoration.textField(_useAppThemeState).copyWith(
                    hintText: "Name",
                    prefixIcon: const Icon(Icons.drive_file_rename_outline),
                  ),
                ),
                // Type text field
                GestureDetector(
                  onTap: () async {
                    // Set the account type and
                    // change corresponding text controller
                    _useAccountType.value =
                        await AccountTypeModal().showModal(context);

                    _useTypeTextController.text = _useAccountType.value != null
                        ? _useAccountType.value!.name
                        : "";
                  },
                  child: Container(
                    color: Colors.transparent,
                    child: IgnorePointer(
                      child: TextFormField(
                        controller: _useTypeTextController,
                        decoration:
                            TextFieldDecoration.textField(_useAppThemeState)
                                .copyWith(
                          hintText: "Type",
                          prefixIcon: _useAccountType.value == null
                              ? const Icon(Icons.help)
                              : Icon(
                                  IconData(_useAccountType.value!.iconPoint,
                                      fontFamily:
                                          _useAccountType.value!.iconFamily),
                                ),
                        ),
                      ),
                    ),
                  ),
                ),
                // Currency text field
                TextFormField(
                  controller: _useCurrencyTextController,
                  decoration:
                      TextFieldDecoration.textField(_useAppThemeState).copyWith(
                    hintText: "Currency",
                    prefixIcon: const Icon(Icons.paid),
                  ),
                ),
                // Balance text field
                TextFormField(
                  controller: _useBalanceTextController,
                  decoration:
                      TextFieldDecoration.textField(_useAppThemeState).copyWith(
                    hintText: "Balance",
                    prefixIcon: const Icon(Icons.paid),
                  ),
                ),
                // Color text field
                TextFormField(
                  controller: _useColorTextController,
                  decoration:
                      TextFieldDecoration.textField(_useAppThemeState).copyWith(
                    hintText: "Color",
                  ),
                ),
                // Submit button
                ElevatedButton(
                  onPressed: () {},
                  child: const Text("CREATE"),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
