import 'package:flutter/material.dart';
import 'package:mountain_app/Models/Escursione.dart';

class TileView extends StatefulWidget {
  final Escursione escursione;

  TileView({super.key, required this.escursione});

  @override
  State<TileView> createState() => _TileViewState();
}

class _TileViewState extends State<TileView> {
  @override
  Widget build(BuildContext context) {
    return Container(
      constraints:
          BoxConstraints(maxHeight: 220, minHeight: 180, maxWidth: 460),
      width: double.infinity,
      child: DecoratedBox(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(24)),
          image: DecorationImage(
            image: AssetImage(widget.escursione.imgPath),
            fit: BoxFit.fitWidth,
          ),
        ),
        child: DecoratedBox(
          decoration: BoxDecoration(
            color: Colors.black26,
            borderRadius: BorderRadius.all(
              Radius.circular(24),
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  organizerImageSection(
                    imgPath: widget.escursione.authorImgPath,
                  ),
                  Spacer(),
                  dateTitleDifficultySection(
                    dataEvento: widget.escursione.data,
                    nomeEvento: widget.escursione.nome,
                    difficolta: widget.escursione.difficolta,
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}

class organizerImageSection extends StatelessWidget {
  final String imgPath;
  const organizerImageSection({
    super.key,
    required this.imgPath,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CircleAvatar(foregroundImage: AssetImage(imgPath)),
        ],
      ),
    );
  }
}

class dateTitleDifficultySection extends StatelessWidget {
  const dateTitleDifficultySection({
    super.key,
    required this.dataEvento,
    required this.nomeEvento,
    required this.difficolta,
  });

  final String dataEvento;
  final String nomeEvento;
  final Difficolta difficolta;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                dataEvento,
                style: TextStyle(
                  fontWeight: FontWeight.w300,
                  color: Colors.white70,
                  fontSize: 17,
                ),
              ),
              Text(
                nomeEvento,
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                  color: Colors.white,
                  fontSize: 23,
                ),
              ),
              Row(
                children: <Widget>[
                  Text(
                    "Difficoltà: ",
                    style: TextStyle(
                      fontWeight: FontWeight.w200,
                      color: Colors.white70,
                      fontSize: 13,
                    ),
                  ),
                  traduceDifficultyToEmoji(difficolta),
                ],
              )
            ],
          ),
        ),
      ],
    );
  }
}

Widget traduceDifficultyToEmoji(Difficolta difficolta) {
  int numElems = 1;

  switch (difficolta) {
    case Difficolta.hard:
      numElems = 3;
      break;
    case Difficolta.medium:
      numElems = 2;
      break;
    default:
      numElems = 1;
  }

  return Row(
    children: List.generate(
      numElems,
      (index) => Icon(
        Icons.directions_walk_rounded,
        color: Colors.red,
      ),
    ),
  );
}
