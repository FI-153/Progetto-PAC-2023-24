import 'package:flutter/material.dart';
import 'package:mountain_app/Managers/EventsManager.dart';

class LoadingSubscribeEventDetailsView extends StatefulWidget {
  const LoadingSubscribeEventDetailsView({super.key, required this.idEvent});
  final int idEvent;

  @override
  State<LoadingSubscribeEventDetailsView> createState() =>
      _LoginLoadingViewState();
}

class _LoginLoadingViewState extends State<LoadingSubscribeEventDetailsView> {
  late Future<bool> result;

  @override
  void initState() {
    super.initState();
    result = EventsManger().addBooking(widget.idEvent);
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: FutureBuilder<bool>(
          future: result,
          builder: ((context, snapshot) {
            if (snapshot.hasError) {
              print(snapshot.error);
              Future.microtask(() => Navigator.pop(context));
            }

            if (snapshot.hasData) {
              Future.microtask(() => Navigator.pop(context));
            }

            return CircularProgressIndicator();
          })),
    );
  }
}
