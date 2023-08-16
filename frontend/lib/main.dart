import "package:flutter/material.dart";
import "package:flutter/services.dart";

import "page_main/p_main.dart";
import "page_apply/p_apply.dart";

int currentPageIndex = 0;

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
      .then((v) => runApp(const MyApp()));
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    final controller = PageController(initialPage: currentPageIndex);

    void update() {
      setState(() {});
    }

    return MaterialApp(
        title: "오성고 급식 앱",
        home: Scaffold(
          body: Column(
            children: [buildPageView(controller, update)],
          ),
          bottomNavigationBar: buildBottomNavigationBar(controller, update),
        ));
  }

  BottomNavigationBar buildBottomNavigationBar(
      PageController controller, void Function() update) {
    return BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.blue,
        currentIndex: currentPageIndex,
        selectedItemColor: Colors.amber,
        unselectedItemColor: Colors.white12,
        onTap: (index) {
          setState(() {
            currentPageIndex = index;
          });
          controller.jumpToPage(index);
          update();
        },
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "home"),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: "apply"),
          BottomNavigationBarItem(
              icon: Icon(Icons.settings), label: "settings"),
        ]);
  }

  Expanded buildPageView(PageController controller, void Function() update) {
    return Expanded(
        child: PageView(
      controller: controller,
      onPageChanged: (index) {
        setState(() {
          currentPageIndex = index;
        });
        update();
      },
      children: const [
        MainPageWidget(),
        ApplyPageWidget(),
        Center(
          child: Text("Settings"),
        ),
      ],
    ));
  }
}