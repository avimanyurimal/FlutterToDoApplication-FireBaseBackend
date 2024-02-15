import 'package:firebase_core/firebase_core.dart';
// import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:gap/gap.dart';
// import 'package:todo/common/show_model.dart';
import 'package:todoapp/firebase_options.dart';
import 'package:todoapp/view/home_page.dart';
// import 'package:todo/widget/Card_todo_widget.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(
    ProviderScope(
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Project',
        theme: ThemeData(),
        home: HomePage(),
      ),
    ),
  );
}
