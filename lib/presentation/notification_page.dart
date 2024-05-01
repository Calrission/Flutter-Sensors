import 'package:flutter/material.dart';
import 'package:sensor_project/domain/notification_use_case.dart';

class NotificationPage extends StatefulWidget {
  const NotificationPage({super.key});

  @override
  State<NotificationPage> createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {

  late NotificationUseCase useCase;
  var isGrantPermission = false;
  var isLoading = true;

  @override
  void initState() {
    super.initState();
    init();
  }

  void init() async {
    useCase = NotificationUseCase((message) => showMessageDialog(context, message));
    await useCase.init();
    var value = await useCase.requestPermission();
    setState(() {
      isGrantPermission = value;
      isLoading = false;
    });
  }

  void showMessageDialog(BuildContext context, String message){
    showDialog(context: context, builder: (_) => AlertDialog(title: Text(message)));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: (isLoading) 
          ? const Text("Загрузка...")
          : (isGrantPermission) 
            ? Column(
              mainAxisSize: MainAxisSize.min,
              children: [
              FilledButton(
                onPressed: () {
                  useCase.pushNotification();
                },
                child: const Text("Push"),
              ),
              FilledButton(
                onPressed: () {
                  useCase.pushScheduleNotification();
                },
                child: const Text("Push after 5 seconds"),
              ),
              ],
            )
            : const Text("Разрешения не выданы")
      ),
    );
  }
}