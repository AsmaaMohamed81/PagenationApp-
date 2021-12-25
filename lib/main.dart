import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pagination/data/api/dio_consumer.dart';
import 'package:pagination/data/repositories/home_repository.dart';
import 'package:pagination/ui/cubit/home/home_cubit.dart';
import 'package:pagination/ui/home/home.dart';
import 'package:pagination/utils/routes.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]).then((_) {
    run();
  });
}

void run() async {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => HomeCubit(
                homeRepository: HomeRepository(dioConsumer: DioConsumer())),
            child: Container(),
          )
        ],
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: ' App',
          routes: routes,
        ));
  }
}
