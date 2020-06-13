import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:housie_bloc/blocs/caller_bloc/caller_bloc.dart';
import 'package:housie_bloc/models/models.dart';
import 'package:housie_bloc/screens/caller.dart';
import 'package:housie_bloc/screens/home_page.dart';
import 'package:housie_bloc/utils/dbhelper.dart';
import 'package:housie_bloc/widgets/widgets.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final appDocumentDir = await getApplicationDocumentsDirectory();
  Hive.init(appDocumentDir.path);
  var box = await Hive.openBox('caller_data');
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: BlocProvider<CallerBloc>(
      create: (context) {
        return CallerBloc(box)..add(LoadData());
      },
      child: HomePage(),
    ),
  ));
}

