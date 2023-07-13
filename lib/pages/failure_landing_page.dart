import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:second_project/packages/city_module.dart';
import '../packages/location_module.dart';
import '../packages/weather_module.dart';
import '../constants/constants.dart';
import 'package:second_project/components/landing_page_components/transitioning.dart';
import 'package:second_project/components/landing_page_components/search_results.dart';
import 'package:second_project/components/landing_page_components/cities_search_bar.dart';

class SearchInitializationPage extends StatefulWidget {
  const SearchInitializationPage({super.key});

  @override
  State<SearchInitializationPage> createState() =>
      _SearchInitializationPageState();
}

class _SearchInitializationPageState extends State<SearchInitializationPage> {
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
                CitiesSearchBar(
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
                              child: CitiesListResults(
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
                  Future<List<dynamic>> daily3HourList = requestLocation();

                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => PageTransition(
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

  Future<List<dynamic>> requestLocation() async {
    await pos.requestLocationService();
    await pos.requestPermissionLocation();
    await pos.init();
    Future<List<dynamic>> daily3HourList =
        Weather(pos.latitude, pos.longitude).getData();
    return daily3HourList;
  }

  void _getListQuery(text) async {
    List<dynamic> tempQuery = await CityLocator(text).queryCities();

    setState(() {
      currentQueryList = tempQuery;
    });
  }

  //indexChanger is a substitution of stateproviders since i haven't learned that yet
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
