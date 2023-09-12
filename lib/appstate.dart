// ignore_for_file: non_constant_identifier_names

import 'gfuncs.dart';
import 'list.dart'; //import 'package:audioplayers_linux/audioplayers_linux.dart'; //import 'dart:collection'; // dart:async library
import 'dart:async'; // dart:async library
import 'package:flutter/material.dart';

class AppState extends ChangeNotifier {
  var kernels_list = KernelsList();
  bool started = false;
  bool pause = false;
  var state = 'ready';
  dynamic timer;
  late ScrollController scontroller;
  //int? secs;
  dynamic secs;
  String timerText = 'Ready';
  //dynamic current;
  //Map<String, String> current;
  //late Map<String, Object>? current;
  dynamic current;
  late List<Map<String, Object>> itemslist;
  late List<String> clist;
  // dynamic itemslist;
  var checkedIs = [];
  var curi = -1;
  AppState() {
    //clist = ['Horse', 'Cow', 'Camel', 'Sheep', 'Goat']; //    cl(list);
    clist = []; //    cl(list);
    itemslist = kernels_list.itemslist; //    cl(history.length);
    secs = 0;
    current = null;
    scontroller = ScrollController(
      //initialScrollOffset: 9999999,
      onAttach: _handlePositionAttach,
    ); //    scontroller.jumpTo(scontroller.position.maxScrollExtent); //curi.toDouble()
  }

  final GlobalKey<AnimatedListState> clistKey = GlobalKey<AnimatedListState>();
  void _addItem() {
    final int index = clist.length; //    int index = 1;
    clist.insert(index, 'index');
    clistKey.currentState?.insertItem(index);
  }

  void _removeItem() {
    cl(clistKey);
    cl(clistKey.currentState);
    cl(clist);
    cl(clist.length);
    //final int index = clist.length - 1;
    const int index = 0;
    cl(clist.length);
    if (clist.isEmpty) return;
    clist.remove(clist[index]);
    clistKey.currentState
        ?.removeItem(index, (context, animation) => Container());

    /// what I'm supposed to do here
    //_list.removeAt(_index);
  }

  void _handlePositionAttach(ScrollPosition position) {}

  getc(i) {
    //    cl('started');    cl(started);
    if (!started) {
      return Colors.blue;
    }
    if (i == curi) {
      return Colors.tealAccent;
    }
    return (itemslist[i]['checked'] == true ? Colors.green : Colors.blue);
  }

  getlt(i) {
    if (checkedIs.contains(i))
      return " " + itemslist[i]['n'].toString();
    else
      return ' ' + itemslist[i]['n'].toString();
  }

  void next() {
    // _removeItem();
    _addItem();
    /* static AudioPlayer player = new AudioPlayer();
    const alarmAudioPath = "welcome.ogg";
    player.play(alarmAudioPath);*/
    if (!started) started = true;
    if (timer != null) timer.cancel(); //    started = false;
    if (curi < 0) curi = 0;
    if (current == null) current = itemslist[curi];
    checkedIs.add(curi); //    cl(checkedIs);
    current['checked'] = true;
    curi++; //    cl(curi);    cl(itemslist.length);
    if (curi == itemslist.length) {
      finish();
      notifyListeners();
      itemslist = kernels_list.itemslist; //
      curi = 0;
      current = itemslist[curi];
      secs = current['t'];
      return;
    }
    current = itemslist[curi];
    secs = current['t']; //    cl(secs);    return;
    timerText = secs.toString();
    timer = Timer.periodic(const Duration(seconds: 1), handleTimer);

    //scontroller.jumpTo(scontroller.position.maxScrollExtent); //curi.toDouble()

    notifyListeners(); //startPause();
  }

  void finish() {
    started = false;
    state = 'finished';
    timerText = 'Finished!';
  }

  void startPause() {
    if (started) {
      timer.cancel();
      if (pause) {
        pause = false;
        timer = Timer.periodic(const Duration(seconds: 1), handleTimer);
      } else {
        pause = true;
      }
      //started = false;
    } else {
      curi = 0;
      current = itemslist[curi];
      secs = itemslist[curi]['t'];
      timerText = secs.toString();
      started = true;
      timer = Timer.periodic(const Duration(seconds: 1), handleTimer);
    }
    notifyListeners();
  }

  getbt() {
    if (started) {
      if (pause)
        return 'Start';
      else
        return 'Pause';
    } else {
      return 'Start';
    }
  }

  double sbw() {
    if (!started) {
      if (state == 'ready') return 130;
      if (state == 'finished') return 180;
    }
    if (curi < 0)
      return 130;
    else
      return 60;
  }

  geticon() {
    if (started) {
      if (pause)
        return Icon(Icons.play_arrow);
      else
        return Icon(Icons.pause);
    } else {
      return Icon(Icons.play_arrow);
    }
  }

  void pause0() {
    started = false;
    timer.cancel();
  }

  void prev() {
    //    cl('started');    cl(started);
    if (!started) return;
    if (timer != null) timer.cancel(); //started = false;
    checkedIs.remove(curi);
    current['checked'] = false;
    curi--;
    if (curi < 0) {
      curi = 0;
      notifyListeners();
      startPause();
      return;
    } //   cl('curi');    cl(curi);
    current = itemslist[curi]; //    cl(curi);    cl(current);
    checkedIs.remove(curi);
    current['t'] = current['td'];
    current['checked'] = false;
    secs = current['td']; //    cl(secs);    return;
    timerText = secs.toString();

    //double scrollTo = scontroller.position.maxScrollExtent;    scontroller.jumpTo(scrollTo);

    notifyListeners();
    startPause();
  }

  void reset() {
    started = false;
    if (timer != null) {
      timer.cancel();
      timer = null;
    }
    checkedIs = [];
    kernels_list = KernelsList();
    itemslist = kernels_list.itemslist; //    cl(history.length);
    current = null;
    secs = 0;
    curi = -1;
    timerText = 'Ready';
    //double scrollTo = scontroller.position.maxScrollExtent;    scontroller.jumpTo(scrollTo); //curi.toDouble()
    notifyListeners();
  }

  void add(addsecs) {
    //cl(current['t']);
    if (current == null) return;
    current['t'] += addsecs;
    if (current['t'] < 0) current['t'] = 0;
    secs += addsecs;
    if (secs < 0) secs = 0;
  }

  void handleTimer(timer) {
    //cl('timer'); cl(timer);    cl(secs);    cl(current['t']);
    //secs = itemslist[curi]['secs'];
    if (secs >= 2) {
      secs--;
      current['t']--;
      timerText = secs.toString();
      notifyListeners();
      return;
    }
    current['t']--;
    if (current['t'] < 0) current['t'] = 0;
    timer.cancel();
    next();
  }

  void checked(index) {
    itemslist[index]['checked'] = true;
    notifyListeners();
  }
}
