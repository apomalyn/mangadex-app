import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:mangadex/shared/models/manga.dart';

class MangaTile extends StatelessWidget {
  final Manga manga;

  final String coverUrl;

  const MangaTile({super.key, required this.manga, required this.coverUrl});

  @override
  Widget build(BuildContext context) => Card(
        child: Stack(
          alignment: AlignmentDirectional.bottomStart,
          children: [
            CachedNetworkImage(
                imageUrl: coverUrl, fit: BoxFit.cover, width: double.infinity),
            Container(
                decoration: const BoxDecoration(boxShadow: [
                  BoxShadow(
                      color: Colors.black54,
                      blurRadius: 10,
                      blurStyle: BlurStyle.normal,
                      spreadRadius: 0.1,
                      offset: Offset(-1, -1)),
                ]),
                width: double.infinity,
                child: Text(manga.attributes.title.values.first))
          ],
        ),
      );
}
