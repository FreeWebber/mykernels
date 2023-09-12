import 'appstate.dart';
import 'gfuncs.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class _ItemsListViewState extends State<ItemsListView> {
  /// Needed so that [AppState] can tell [AnimatedList] below to animate // new items.
  static const Gradient _maskingGradient = LinearGradient(
    // This gradient goes from fully transparent to fully opaque black...
    colors: [Colors.transparent, Colors.black],
    // ... from the top (transparent) to half (0.5) of the way to the bottom.
    stops: [0.0, 0.5],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
  );

  List<Widget> get_unchecked() {
    final appState = context.watch<AppState>();
    List<Widget> ret = [];

    //for (var i = appState.itemslist.length - 1; i > -1; i--) {
    for (var i = 0; i < appState.itemslist.length; i++) {
      if (appState.itemslist[i]['checked'] == true) continue;
      ret.add(ListTile(
          title: SizedBox(
              child: Container(
                  //margin: EdgeInsets.only(top: 4),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Row(children: [
                    Text(' '),
                    Icon(
                      Icons.radio_button_unchecked,
                      size: 28.0,
                      color: appState.getc(i),
                    ),
                    Container(
                        alignment: Alignment.centerLeft,
                        width: 160,
                        child: Text(
                          appState.getlt(i), // + ' ⭕',
                          style: TextStyle(
                              fontSize: 24,
                              color: appState.getc(i)), //Colors.blue[900])
                          semanticsLabel: appState.itemslist[i]['n'].toString(),
                        )),
                    Container(
                        alignment: Alignment.center,
                        child: Text(
                            ' ' +
                                appState.itemslist[i]['t'].toString() +
                                '/' +
                                appState.itemslist[i]['td'].toString(),
                            style: TextStyle(
                                fontSize: 24,
                                color: appState.getc(i)), //Colors.blue[900])
                            semanticsLabel:
                                appState.itemslist[i]['t'].toString()))
                  ])))));
    }
    //if (appState.scontroller.hasClients)      appState.scontroller          .jumpTo(appState.scontroller.position.maxScrollExtent);
    return ret;
  }

  @override
  Widget build(BuildContext context) {
    final appState = context.watch<AppState>();
    //appState.itemslistListKey = _key;
    var theme = Theme.of(context);

    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Expanded(
          // Make better use of wide windows with a grid.
          child: GridView(
              reverse: true,
              padding: const EdgeInsets.only(bottom: 14),
              controller: appState.scontroller,
              gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                maxCrossAxisExtent: 900,
                childAspectRatio: 8,
                mainAxisSpacing: 6,
              ),
              children: get_unchecked())),
    ]);
  }
}

class ItemsListView extends StatefulWidget {
  const ItemsListView({super.key});

  @override
  State<ItemsListView> createState() => _ItemsListViewState();
}
