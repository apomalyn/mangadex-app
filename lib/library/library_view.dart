import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mangadex/library/library_viewmodel.dart';
import 'package:mangadex/reading_list/reading_list_view.dart';
import 'package:mangadex/shared/widgets/base_scaffold.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:stacked/stacked.dart';

class LibraryView extends StatefulWidget {
  const LibraryView({super.key});

  @override
  State<LibraryView> createState() => _LibraryViewState();
}

class _LibraryViewState extends State<LibraryView>
    with SingleTickerProviderStateMixin {
  @override
  Widget build(BuildContext context) =>
      ViewModelBuilder<LibraryViewModel>.reactive(
          viewModelBuilder: () => LibraryViewModel(
              appLocalizations: AppLocalizations.of(context)!,
              router: GoRouter.of(context)),
          onModelReady: (viewModel) => viewModel.initState(this),
          builder: (context, viewModel, child) => BaseScaffold(
              showBottomBar: true,
              appBar: AppBar(
                  automaticallyImplyLeading: false,
                  title: Text(AppLocalizations.of(context)!.library),
                  bottom: TabBar(
                      controller: viewModel.tabController,
                      tabs: viewModel.tabs)),
              body: TabBarView(
                controller: viewModel.tabController,
                children: [
                  const ReadingListView(),
                  Center(
                    child: Text(AppLocalizations.of(context)!.library_history),
                  ),
                  Center(
                    child: Text(AppLocalizations.of(context)!.library_offline),
                  )
                ],
              )));
}
