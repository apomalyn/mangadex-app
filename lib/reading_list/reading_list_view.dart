import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:go_router/go_router.dart';
import 'package:mangadex/reading_list/reading_list_viewmodel.dart';
import 'package:stacked/stacked.dart';

class ReadingListView extends StatefulWidget {
  const ReadingListView({super.key});

  @override
  State<ReadingListView> createState() => _ReadingListViewState();
}

class _ReadingListViewState extends State<ReadingListView> {

  @override
  Widget build(BuildContext context) =>
      ViewModelBuilder<ReadingListViewModel>.reactive(
        viewModelBuilder: () => ReadingListViewModel(
            appLocalizations: AppLocalizations.of(context)!,
            router: GoRouter.of(context)),
        builder: (context, viewModel, child) => SafeArea(
          minimum: const EdgeInsets.only(top: 20.0),
          child: Column(
            children: [
              ToggleButtons(
                  borderRadius: const BorderRadius.all(Radius.circular(25)),
                  onPressed: viewModel.onListTogglePress,
                  isSelected: viewModel.activeLists,
                  children: viewModel.listTitles
                      .map<Widget>((title) => Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(title),
                          ))
                      .toList(growable: false))
            ],
          ),
        ),
      );
}
