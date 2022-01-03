import 'package:exercise_3/model/slot.dart';
import 'package:exercise_3/service/impl/slot_service_impl.dart';
import 'package:exercise_3/ui/add_exam.dart';
import 'package:flutter/material.dart';

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'FinkiCSE Exams Scheduler',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.indigo,
      ),
      home: const MyHomePage(title: 'Finki Exams Scheduler'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final SlotService _slotService = SlotService();
  int _counter = 0;
  static const userAvatarUrl = "https://e7.pngegg.com/pngimages/613/636/png-clipart-computer-icons-user-profile-male-avatar-avatar-heroes-logo-thumbnail.png";

  void addSlot(var slot) {
    setState(() {
      _slotService.addSlot(slot);
    });
  }

  @override
  void initState() {
    super.initState();

    _slotService.addSlot(Slot(
        description: "Discrete Mathematics 1 Exam",
        location: "Building 1",
        roomId: "Lab235",
        startTime: DateTime.now()));
    _slotService.addSlot(Slot(
        description: "Information Security Midterm",
        location: "Building 2",
        roomId: "Lab215",
        startTime: DateTime.now()));
    _slotService.addSlot(Slot(
        description: "OOP Exam",
        location: "Campus 1",
        roomId: "LAB-01",
        startTime: DateTime.now()));
    _slotService.addSlot(Slot(
        description: "Team Projects Midterm",
        location: "Campus 1",
        roomId: "Lab-02",
        startTime: DateTime.now()));
  }

  @override
  Widget build(BuildContext context) {
    List<Slot> slots = _slotService.getSlots();
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      drawer: Drawer(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(
                  height: 20,
                ),
                Padding(padding: EdgeInsets.fromLTRB(0, 30.0, 0, 0)),
                CircleAvatar(
                  backgroundImage: NetworkImage(userAvatarUrl),
                  radius: 40,
                ),
                SizedBox(
                  height: 20,
                ),
                Text("Profesor A", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),),
                Divider(
                  height: 80,
                ),
              ],
            ),
            Container(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
              child: ElevatedButton(
                  onPressed: () => {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    AddSlot(addSlot: addSlot))),
                      },
                  child: Row(
                    children: [
                      Container(
                        margin: EdgeInsets.only(right: 20.0),
                        child: Icon(Icons.add),
                      ),
                      Text("Schedule new exam")],
                  )),
            ),
          ],
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Expanded(
            child: ListView.separated(
              padding: const EdgeInsets.all(8),
              itemCount: slots.length,
              itemBuilder: (BuildContext context, int index) {
                var currentSlot = slots[index];
                return Container(
                  height: 50,
                  child: Column(children: [
                    Text(
                      currentSlot.description,
                      style: TextStyle(fontSize: 20),
                    ),
                    Row(children: [
                      Text(currentSlot.location),
                      VerticalDivider(
                        width: 10,
                      ),
                      Text(currentSlot.startTime.toString()),
                      VerticalDivider(
                        width: 10,
                      ),
                      Text(currentSlot.roomId),
                      VerticalDivider(
                        width: 10,
                      ),
                    ])
                  ]),
                );
              },
              separatorBuilder: (BuildContext context, int index) =>
                  const Divider(),
            ),
          )
        ],
      ),
    );
  }
}
