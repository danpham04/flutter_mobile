import 'package:flutter/material.dart';
import 'package:flutter_mobile/global/app_routes.dart';
import 'package:flutter_mobile/model/user_model.dart';
import 'package:flutter_mobile/provider/provider_home.dart';
import 'package:flutter_mobile/screens/home_screens/home/widgets/button_dig_log.dart';
import 'package:flutter_mobile/screens/home_screens/home/widgets/pading_text_field.dart';
import 'package:flutter_mobile/screens/home_screens/home/widgets/show_dia_log.dart';
import 'package:flutter_mobile/screens/home_screens/home/widgets/text_infor.dart';
import 'package:flutter_mobile/widgets/app_bar_shared.dart';
import 'package:flutter_mobile/widgets/show_messenger.dart';
import 'package:provider/provider.dart';

class CreateInfor extends StatefulWidget {
  const CreateInfor({super.key});

  @override
  State<CreateInfor> createState() => _CreateInforState();
}

class _CreateInforState extends State<CreateInfor> {
  late TextEditingController _controllerName;
  late TextEditingController _controllerGmail;
  late TextEditingController _controllerAddress;
  late TextEditingController _controllerAge;
  late TextEditingController _controllerNationality;
  late TextEditingController _controllerId;
  late final ProviderHome _providerHome;

  @override
  void initState() {
    _controllerName = TextEditingController();
    _controllerGmail = TextEditingController();
    _controllerAddress = TextEditingController();
    _controllerAge = TextEditingController();
    _controllerNationality = TextEditingController();
    _controllerId = TextEditingController();
    // _controllerImg = TextEditingController();
    _providerHome = Provider.of<ProviderHome>(context, listen: false);
    super.initState();
  }

  @override
  void dispose() {
    _controllerName.dispose();
    _controllerGmail.dispose();
    _controllerAddress.dispose();
    _controllerAge.dispose();
    _controllerNationality.dispose();
    _controllerId.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBarShared(
        titleName: 'Create User',
        colors: Colors.blue[300],
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              PadingTextField(
                labelText: "Enter the name you want to add",
                hintText: 'Nhập tên',
                textController: _controllerName,
              ),
              PadingTextField(
                labelText: "Enter the gmail you want to add",
                hintText: 'Nhập gmail',
                textController: _controllerGmail,
              ),
              PadingTextField(
                labelText: "Enter the address you want to add",
                hintText: 'Nhập địa chỉ',
                textController: _controllerAddress,
              ),
              PadingTextField(
                labelText: "Enter the date of birth you want to add",
                hintText: 'Nhập ngày sinh',
                textController: _controllerAge,
              ),
              PadingTextField(
                labelText: "Enter the nationality you want to add",
                hintText: 'Nhập quốc tịch',
                textController: _controllerNationality,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor:
                          const Color.fromARGB(255, 149, 196, 235)),
                  onPressed: () {
                    // await _updateDataUser();
                    _showDialog();
                  },
                  child: const TextInfor(
                    text: 'Add User',
                    colorText: Colors.black,
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  void _showDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return ShowDiaLog(
          content: 'Are you sure you want to create the user?',
          title: 'Create user',
          actions: [
            ButtonDigLog(
              text: 'Cancel',
              onPressed: () => Navigator.of(context).pop(),
            ),
            ButtonDigLog(
              text: 'Create',
              onPressed: () async {
                Navigator.of(context).pop();
                await _updateDataUser();
              },
            )
          ],
        );
      },
    );
  }

  Future<void> _updateDataUser() async {
    UserModel newUser = UserModel(
      image:
          "https://cloudflare-ipfs.com/ipfs/Qmd3W5DuhgHirLHGVixi6V76LhCkZUz6pnFt5AJBiyvHye/avatar/877.jpg",
      name: _controllerName.text,
      mail: _controllerGmail.text,
      address: _controllerAddress.text,
      dateOfBirth: _controllerAge.text,
      nationality: _controllerNationality.text,
      id: _controllerId.text,
    );

    bool success = await _providerHome.createUser(newUser: newUser);

    if (mounted) {
      if (success) {
        showCustomMess(content: _providerHome.messageCreate);
        await Navigator.of(context).pushNamed(AppRoutes.homeScress);
      } else {
        showCustomMess(content: _providerHome.messageCreate);
      }
    }
  }

  showCustomMess({required String content}) {
    ShowMessengers.showMessenger(context: context, content: content);
  }
}
