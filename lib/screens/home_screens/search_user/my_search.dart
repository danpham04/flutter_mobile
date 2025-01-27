import 'package:flutter/material.dart';
import 'package:flutter_mobile/global/app_routes.dart';
import 'package:flutter_mobile/provider/provider_home.dart';
import 'package:flutter_mobile/screens/home_screens/home/widgets/infor_user.dart';
import 'package:flutter_mobile/widgets/app_bar_shared.dart';
import 'package:provider/provider.dart';

class MySearch extends StatefulWidget {
  const MySearch({
    super.key,
  });

  @override
  State<MySearch> createState() => _MySearchState();
}

class _MySearchState extends State<MySearch> {
  late TextEditingController _controllerSearch;
  late String text;
  @override
  void initState() {
    _controllerSearch = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _controllerSearch.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<ProviderHome>(context);
    return Scaffold(
      appBar: AppBarShared(
        leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.of(context).pop();
              // Navigator.of(context).pushNamed(AppRoutes.homeScress);
            }),
        titleName: 'Search User',
        colors: Colors.black,
        colorBack: const Color.fromARGB(255, 129, 185, 231),
        actions: [
          IconButton(
            icon: const Icon(Icons.menu),
            onPressed: () => _filterDataUser(context),
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: TextField(
              onChanged: (value) {
                if (value == '') {
                  provider.clearSearchUser();
                } else {
                  // provider.searchUser(value: value);
                  provider.getData(key: provider.key, value: value);
                }
              },
              controller: _controllerSearch,
              decoration: InputDecoration(
                prefixIcon: const Icon(Icons.search),
                suffixIcon: IconButton(
                  onPressed: () {
                    _controllerSearch.clear();
                    provider.clearSearchUser();
                  },
                  icon: IconButton(
                    onPressed: () {
                      text = _controllerSearch.text;
                      if (text.isEmpty) {
                        Navigator.of(context).pushNamed(AppRoutes.homeScress);
                      } else {
                        _controllerSearch.text = '';
                      }
                    },
                    icon: const Icon(Icons.clear),
                  ),
                ),
                hintText: 'Search.....',
                border: const OutlineInputBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(20),
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            child: Consumer<ProviderHome>(
              builder: (context, providers, child) {
                if (providers.searchUserData.isEmpty) {
                  if (_controllerSearch.text == '') {
                    return Center(
                      child: Text(
                          'Please enter a search term with type ${provider.key}.'),
                    );
                  } else if (providers.checkValue == true &&
                      providers.checkSearchUser == false) {
                    return const Center(
                      child: Text('No value!'),
                    );
                  } else {
                    return Center(
                      child: Text(providers.messageSearch),
                    );
                  }
                }
                return ListView.builder(
                  itemCount: providers.searchUserData.length,
                  itemBuilder: (context, index) {
                    final users = providers.searchUserData[index];
                    return InforUser(users: users);
                  },
                );
              },
            ),
          )
        ],
      ),
    );
  }

  void _filterDataUser(BuildContext context) {
    final providerHome = Provider.of<ProviderHome>(context, listen: false);
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setSearch) {
            return AlertDialog(
              title: const Text('You want to search'),
              content: SingleChildScrollView(
                child: SizedBox(
                  width: 250,
                  height: 280,
                  child: ListView.builder(
                    itemCount: providerHome.listTilte.length,
                    itemBuilder: (BuildContext context, int index) {
                      return RadioListTile(
                        value: providerHome.listTilte[index].toLowerCase(),
                        title: Text(providerHome.listTilte[index]),
                        groupValue: providerHome.key,
                        onChanged: (value) {
                          providerHome.setKey(value as String);
                          providerHome.clearSearchUser();
                          // providerHome.getData(
                          //     key: providerHome.key,
                          //     value: _controllerSearch.text);
                          Navigator.pop(context);
                        },
                      );
                    },
                  ),
                ),
              ),
              actions: [
                TextButton(
                  style: ButtonStyle(
                      backgroundColor: WidgetStateProperty.all<Color>(
                          const Color.fromARGB(255, 120, 178, 226))),
                  child: const Text(
                    'Close',
                    style: TextStyle(color: Colors.black),
                  ),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ],
            );
          },
        );
      },
    );
  }
}
