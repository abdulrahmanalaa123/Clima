import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:second_project/packages/city_module.dart';
import 'packages/location_module.dart';
import 'packages/weather_module.dart';
import 'pages/main_page.dart';
import 'constants/constants.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      home: BaseAnimatedScreen(),
    );
  }
}

class BaseAnimatedScreen extends StatelessWidget {
  BaseAnimatedScreen({super.key});
  Position pos = Position();
  @override
  Widget build(BuildContext context) {
    try {
      pos.requestAccess();
      Future<List<dynamic>> list3Hour =
          Weather(pos.latitude, pos.longitude).getData();

      return AnimatedScreen(
        futureData: list3Hour,
        errorText: 'Check your Internet Connection or Access to location',
      );
    } catch (e) {
      return const MainTextQueryPage();
    }
  }
}

class MainTextQueryPage extends StatefulWidget {
  const MainTextQueryPage({super.key});

  @override
  State<MainTextQueryPage> createState() => _MainTextQueryPageState();
}

class _MainTextQueryPageState extends State<MainTextQueryPage> {
  final myController = TextEditingController();
  late List<dynamic> currentQueryList;
  int chosenQuery = 0;
  //it is reinitialized because it wont reach this unless there happens a problem
  //and the user needs to reinitialize a position
  Position pos = Position();

  @override
  void dispose() {
    myController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    currentQueryList = [];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Constants.primaryThemeColor,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
              child: Container(
            decoration: Constants.buildBoxDecoration(true, true, true),
            child: Column(
              children: [
                const SizedBox(
                  height: 20,
                ),
                CustomSearchBar(
                  myController: myController,
                  onChanged: _getListQuery,
                  queryList: currentQueryList,
                  chosenIndex: chosenQuery,
                  xFunction: _resetQueryList,
                ),
                (currentQueryList.isEmpty) & (myController.text != '')
                    ? const Text(
                        'Make sure you entered your City Name Correctly',
                        style: TextStyle(color: Colors.white),
                      )
                    : Expanded(
                        child: Container(
                          decoration: const BoxDecoration(
                            borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(60),
                              bottomRight: Radius.circular(60),
                            ),
                          ),
                          child: ClipRRect(
                              borderRadius: const BorderRadius.only(
                                bottomLeft: Radius.circular(60),
                                bottomRight: Radius.circular(60),
                              ),
                              child: ListObject(
                                currentQuery: currentQueryList,
                                myController: myController,
                                indexChanger: _indexChanger,
                              )),
                        ),
                      ),
              ],
            ),
          )),
          const SizedBox(
            height: 20,
          ),
          Center(
            child: TextButton(
              onPressed: (() {
                try {
                  pos.requestAccess();
                  pos.init();
                  Future<List<dynamic>> daily3HourList =
                      Weather(pos.latitude, pos.longitude).getData();
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => AnimatedScreen(
                                futureData: daily3HourList,
                                errorText:
                                    'Check your Internet Connection or Access to location',
                              )));
                } catch (e) {
                  Navigator.of(context).pop;
                  SystemNavigator.pop();
                }
              }),
              style: TextButton.styleFrom(backgroundColor: Colors.blue),
              child: const Text(
                'Get Location',
                style: TextStyle(color: Colors.black),
              ),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
        ],
      ),
    );
  }

  void _getListQuery(text) async {
    List<dynamic> tempQuery = await CityLocator(text).queryCities();

    setState(() {
      currentQueryList = tempQuery;
    });
  }

  void _indexChanger(int index) {
    setState(() {
      chosenQuery = index;
    });
  }

  void _resetQueryList() {
    myController.clear();
    myController.text = '';

    setState(() {
      currentQueryList = [];
    });
    FocusScope.of(context).requestFocus(FocusNode());
  }
}

class CustomSearchBar extends StatelessWidget {
  const CustomSearchBar({
    super.key,
    required this.myController,
    required this.onChanged,
    required this.queryList,
    required this.chosenIndex,
    required this.xFunction,
  });

  final TextEditingController myController;
  final void Function(String) onChanged;
  final List<dynamic> queryList;
  final int chosenIndex;
  final void Function() xFunction;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(20),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          border: Border.all(color: Colors.white, width: 2)),
      child: Row(
        children: [
          const Expanded(
            child: Icon(
              Icons.location_city_outlined,
              color: Colors.white,
            ),
          ),
          Expanded(
            flex: 6,
            child: TextField(
              decoration: InputDecoration(
                icon: const Icon(Icons.search),
                iconColor: Colors.white38,
                border: InputBorder.none,
                suffixIcon: myController.text != ''
                    ? GestureDetector(
                        onTap: xFunction,
                        child: const Icon(
                          Icons.close,
                          color: Colors.white,
                        ),
                      )
                    : null,
                hintText: 'Enter your City',
              ),
              controller: myController,
              textDirection: TextDirection.ltr,
              showCursor: true,
              cursorRadius: const Radius.circular(10),
              onChanged: onChanged,
            ),
          ),
          Expanded(
            child: IconButton(
              onPressed: () async {
                final daily3HourList = Weather(
                        queryList[chosenIndex].lat, queryList[chosenIndex].lon)
                    .getData();
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => AnimatedScreen(
                              futureData: daily3HourList,
                              errorText: 'Check your Internet Connection ',
                            )));
              },
              icon: const Icon(Icons.arrow_circle_right_rounded),
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}

class ListObject extends StatelessWidget {
  const ListObject(
      {required this.currentQuery,
      required this.myController,
      required this.indexChanger,
      super.key});
  final List<dynamic> currentQuery;
  final TextEditingController myController;
  final void Function(int index) indexChanger;
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        shrinkWrap: true,
        itemCount: currentQuery.length,
        scrollDirection: Axis.vertical,
        itemBuilder: (BuildContext context, int index) {
          return GestureDetector(
            onTap: () {
              myController.text = currentQuery[index].toString();
              FocusScope.of(context).requestFocus(FocusNode());
              indexChanger(index);
              Future<List<dynamic>> daily3HourList =
                  Weather(currentQuery[index].lat, currentQuery[index].lon)
                      .getData();
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => AnimatedScreen(
                            futureData: daily3HourList,
                            errorText: 'Check your Internet Connection',
                          )));
            },
            child: Container(
              margin: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(50),
                  border: Border.all(color: Constants.glowColor, width: 2),
                  color: Constants.primaryThemeColor,
                  boxShadow: const [
                    BoxShadow(
                        spreadRadius: 6,
                        blurStyle: BlurStyle.normal,
                        blurRadius: 5,
                        color: Colors.black),
                  ]),
              child: ListTile(
                enabled: true,
                contentPadding: const EdgeInsets.all(16),
                leading: Text(
                  currentQuery[index].toString(),
                  style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                      fontSize: 20),
                ),
              ),
            ),
          );
        });
  }
}

class AnimatedScreen extends StatelessWidget {
  const AnimatedScreen(
      {required this.futureData, required this.errorText, super.key});

  final Future<List<dynamic>> futureData;
  final String errorText;
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<dynamic>>(
        future: futureData,
        builder: (BuildContext context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Scaffold(
              backgroundColor: Constants.primaryThemeColor,
              body: Center(
                child: Image(
                  image: AssetImage('assets/loading.gif'),
                  height: 200,
                  width: 200,
                ),
              ),
            );
          } else if (snapshot.hasError) {
            WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
              print(snapshot.error);
              ErrorBox(context, errorText);
            });
            return const MainTextQueryPage();
          } else {
            return FirstPage(weatherList: snapshot.data ?? []);
          }
        });
  }

  Future<dynamic> ErrorBox(BuildContext context, String errorText) async {
    await Future.delayed(const Duration(microseconds: 4));
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(errorText),
          content: const Text('Please retry calling the service'),
          actions: [
            ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text('OK')),
          ],
        );
      },
    );
  }
}
