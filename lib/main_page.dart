import 'gfuncs.dart';
import 'appstate.dart';
import 'items_list.dart';
import 'spage.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MainPage extends StatelessWidget {
  //const MainPage({super.key, required this.title}); final String title = 'Installed Kernels';

  const MainPage({super.key});

  @override
  Widget build(BuildContext context) {
    var appState = context.watch<AppState>();

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Expanded(
            flex: 3,
            child: ItemsListView(),
          ),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              const SizedBox(width: 10),
              SizedBox(
                  width: appState.sbw(),
                  height: 90,
                  child: Align(
                      alignment: Alignment.center,
                      child: Text(appState.timerText,
                          style: TextStyle(
                              fontSize: 44, fontWeight: FontWeight.bold))))
            ],
          ),
          //Spacer(flex: 1),
        ],
      ),
    );
  }
}

class MyMainPage extends StatefulWidget {
  const MyMainPage({super.key});

  @override
  State<MyMainPage> createState() => _MyMainPageState();
}

class _MyMainPageState extends State<MyMainPage> {
  var selectedIndex = 0;
  int? seconds;
  var start = false;
  dynamic secs;

  @override
  Widget build(BuildContext context) {
    var colorScheme = Theme.of(context).colorScheme;

    Widget page;
    switch (selectedIndex) {
      case 0:
        page = MainPage();
        break;
      case 1:
        page = SPage();
        break;
      default:
        throw UnimplementedError('no widget for $selectedIndex');
    }

    var mainArea = ColoredBox(
      color: colorScheme.surfaceVariant,
      child: AnimatedSwitcher(
        duration: Duration(milliseconds: 200),
        child: page,
      ),
    );

    var appState = Provider.of<AppState>(context, listen: true);

    //cl(appState.scontroller);    cl(appState.scontroller.hasClients);
    // var appState = context.watch<AppState>();
    // if (appState.scontroller['position'] != null)
    return Scaffold(
      body: LayoutBuilder(
        builder: (context, constraints) {
          // Use a more mobile-friendly layout with BottomNavigationBar // on narrow screens.
          return Column(
            children: [
              Expanded(child: mainArea),
              BottomNavigationBar(
                type: BottomNavigationBarType.fixed,
                items: [
                  BottomNavigationBarItem(
                    icon: Icon(Icons.remove),
                    label: '-5',
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.add),
                    label: '+5',
                  ),
                ],
                currentIndex: selectedIndex,
                onTap: (value) {
                  setState(() {
                    //                      cl(value);
                    if (value == 0) {
                      appState.add(-5);
                    }
                    if (value == 1) {
                      appState.add(5);
                    }
                  });
                },
              ),
              BottomNavigationBar(
                type: BottomNavigationBarType.fixed,
                items: [
                  BottomNavigationBarItem(
                    icon: appState.geticon(),
                    label: appState.getbt(),
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.arrow_back),
                    label: 'Prev',
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.arrow_forward),
                    label: 'Next',
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.refresh),
                    label: 'Reset',
                  ),
                ],
                currentIndex: selectedIndex,
                onTap: (value) {
                  setState(() {
                    //                      cl(value);
                    if (value == 0) {
                      appState.startPause();
                      /* Timer.periodic(
                            //var _timer =
                            const Duration(seconds: 1),
                            handleTimer);
                        start = true;*/
                    }
                    if (value == 1) {
                      appState.prev();
                    }
                    if (value == 2) {
                      appState.next();
                    }
                    if (value == 3) {
                      appState.reset();
                    }
                  });
                },
              ),
            ],
          );
        },
      ),
    );
  }
}

/*
class _MyMainPageState extends State<MyMainPage> {
  int _counter = 0; // dynamic title;
  final String title = 'Installed Kernels';
  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    var colorScheme = Theme.of(context).colorScheme;

    var appState = Provider.of<AppState>(context, listen: true);

    return const Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            flex: 3,
            child: ItemsListView(),
          ),
          //Spacer(flex: 1),
        ],
      ),
    );
  }
}*/
