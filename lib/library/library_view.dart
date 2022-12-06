import 'package:flutter/material.dart';
import 'package:mangadex/shared/widgets/base_scaffold.dart';

class LibraryView extends StatelessWidget {
  const LibraryView({super.key});

  @override
  Widget build(BuildContext context) => const BaseScaffold(
      showBottomBar: true,
      body: Center(
        child: Text("Libary"),
      ));
}
