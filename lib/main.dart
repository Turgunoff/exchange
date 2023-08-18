import 'package:exchange/models/coinModel.dart';
import 'package:exchange/services/apiService.dart';

import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Home(),
    );
  }
}

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          "Exchange",
          style: TextStyle(
            fontSize: 26,
          ),
        ),
      ),
      body: FutureBuilder(
        future: ApiService().getPosts(),
        builder: (context, AsyncSnapshot<List<CoinModel>> snapshot) {
          if (snapshot.hasError) {
            print('Error');
          } else if (snapshot.hasData) {
            var data = snapshot.data;
            return ListView.builder(
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: SizedBox(
                    height: 70,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Expanded(
                          flex: 4,
                          child: Row(
                            children: [
                              Text(
                                data[index].ccyNmUz,
                                style: const TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.w500),
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                          flex: 5,
                          child: Row(
                            children: [
                              Expanded(
                                child: Row(
                                  children: [
                                    Text(data[index].rate.toString(),
                                        style: const TextStyle(fontSize: 16)),
                                  ],
                                ),
                              ),
                              Expanded(
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Transform.rotate(
                                      angle: double.parse(data[index].diff) < 0
                                          ? 3.14 / 2
                                          : 3.14,
                                      child: Icon(
                                          double.parse(data[index].diff) < 0
                                              ? Icons.show_chart_outlined
                                              : Icons.show_chart_outlined,
                                          color:
                                              double.parse(data[index].diff) < 0
                                                  ? Colors.red
                                                  : Colors.green),
                                    ),
                                    Text(
                                        double.parse(data[index].diff) < 0
                                            ? data[index].diff.toString()
                                            : '+${data[index].diff}',
                                        style: TextStyle(
                                            fontSize: 16,
                                            color:
                                                double.parse(data[index].diff) <
                                                        0
                                                    ? Colors.red
                                                    : Colors.green)),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                );
              },
              itemCount: data!.length,
            );
          }
          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }
}
