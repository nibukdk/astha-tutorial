import 'package:flutter/material.dart';

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
        leading: Icon(Icons.person),
        title: Text(
          "This is appbar",
          style: Theme.of(context).textTheme.headline1,
        ),
      ),
      body: SafeArea(
        child: Container(
            padding: const EdgeInsets.all(20),
            color: Theme.of(context).colorScheme.background,
            child:
                Column(mainAxisAlignment: MainAxisAlignment.start, children: [
              Card(
                child: Container(
                  width: 300,
                  height: 200,
                  padding: const EdgeInsets.all(4),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Hi",
                          style: Theme.of(context).textTheme.headline2,
                          textAlign: TextAlign.left,
                        ),
                        Text(
                          "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Eu id lectus in gravida mauris, nascetur. Cras ut commodo consequat leo, aliquet a ipsum nulla.",
                          style: Theme.of(context).textTheme.bodyText1,
                        )
                      ]),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  TextButton(
                    child: const Text("Text Button"),
                    onPressed: () {},
                  ),
                  ElevatedButton(
                    child: Text(
                      "Hi",
                      style: Theme.of(context).textTheme.bodyText1!.copyWith(
                            color: Colors.white,
                          ),
                    ),
                    onPressed: () {},
                  ),
                ],
              )
            ])),
      ),
    );
  }
}
