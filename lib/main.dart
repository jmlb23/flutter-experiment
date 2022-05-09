import 'package:flutter/material.dart';
import 'package:maisbugs/ui/pages/Detail/stop_element_page.dart';
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
      routes: {
        "/": (context) => Splash(),
        "/stops": (context) => StopListPage(),
      },
      onGenerateRoute: generateRoute,
    );
  }
}
