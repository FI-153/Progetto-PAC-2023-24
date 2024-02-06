import 'package:flutter/material.dart';
import 'package:mountain_app/Managers/EventsManager.dart';
import 'package:mountain_app/Views/LottieAnimations/ErrorView.dart';
import 'package:mountain_app/Views/LottieAnimations/SuccessView.dart';

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
              Future.microtask(
                () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: ((context) {
                      return ErrorView(popLevel: 2);
                    }),
                  ),
                ),
              );
            }

            if (snapshot.hasData) {
              Future.microtask(
                () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: ((context) {
                      return SuccessView(text: "Prenotazione inviata!");
                    }),
                  ),
                ),
              );
            }

            return CircularProgressIndicator();
          })),
    );
  }
}
