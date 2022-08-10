import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../main.dart';
import '../model/user_model.dart';
import '../widget/search_widget.dart';
import 'home_page.dart';



class MarketView extends StatefulWidget {
  const MarketView({Key? key}) : super(key: key);

  @override
  _MarketViewState createState() => _MarketViewState();
}

class _MarketViewState extends State<MarketView> {
  List<User> user = [];
  String query = '';
  Timer? debouncer;

  @override
  void initState() {
    super.initState();

    init();
  }

  @override
  void dispose() {
    debouncer?.cancel();
    super.dispose();
  }

  void debounce(
      VoidCallback callback, {
        Duration duration = const Duration(milliseconds: 1000),
      }) {
    if (debouncer != null) {
      debouncer!.cancel();
    }

    debouncer = Timer(duration, callback);
  }

  Future init() async {
    // final user = await UserApi.(query);

    setState(() => this.user = user);
  }
  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(
      title: Text(MyApp.title),
      centerTitle: true,
    ),
    body: Column(
      children: <Widget>[
        buildSearch(),
        Expanded(
          child:HomePage(),
        )
      ],
    ),
  );

  Widget buildSearch() => SearchWidget(
    text: query,
    hintText: 'Search here...',
    onChanged: searchBook,
  );

  Future searchBook(String query) async => debounce(() async {
    // final user = await userApi.fetchUser(query);

    if (!mounted) return;

    setState(() {
      this.query = query;
      this.user = user;
    });
  });

  Widget buildMarket(User user) => ListTile(
    leading: Image.network(
      user.data.first .lastName,
      fit: BoxFit.cover,
      width: 50,
      height: 50,
    ),
    title: Text(user.data.first.firstName),
    subtitle: Text(user.data.first.lastName),
  );
}
