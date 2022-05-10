import 'package:flutter/material.dart';
import 'package:maisbugs/ui/pages/Stops/Detail/stop_element_page.dart';
import 'package:maisbugs/ui/pages/splash.dart';
import 'package:maisbugs/ui/pages/Stops/stop_list_page.dart';

void main() => runApp(App());

class App extends StatelessWidget {
  App();

  Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case "/stops/:id":
        var args = settings.arguments as StopElementPageArgs;
        return MaterialPageRoute(
            settings:
                RouteSettings(name: "/stops/${args.id}", arguments: args.id),
            builder: (build) => StopElementPage(args.title));
      default:
        return MaterialPageRoute(builder: (build) => Container());
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Mais Bus",
      theme: ThemeData(
          colorScheme: ColorScheme(
              brightness: Brightness.light,
              primary: Colors.purple,
              secondary: Colors.purpleAccent,
              onPrimary: Colors.black,
              onSecondary: Colors.black,
              error: Colors.redAccent,
              background: Colors.white,
              onBackground: Colors.black,
              onError: Colors.white,
              onSurface: Colors.black,
              surface: Colors.purple)),
      darkTheme: ThemeData(
          colorScheme: ColorScheme(
              brightness: Brightness.dark,
              primary: Colors.purple,
              secondary: Colors.purpleAccent,
              onPrimary: Colors.white,
              onSecondary: Colors.white,
              error: Colors.red,
              background: Colors.black,
              onBackground: Colors.white,
              onError: Colors.white,
              onSurface: Colors.white,
              surface: Colors.deepPurple)),
      themeMode: ThemeMode.system,
      routes: {
        "/": (context) => Splash(),
        "/stops": (context) => StopListPage(),
      },
      onGenerateRoute: generateRoute,
    );
  }
}
