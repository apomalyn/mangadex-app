import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:go_router/go_router.dart';
import 'package:mangadex/reading_list/reading_list_tab_viewmodel.dart';
import 'package:mangadex/shared/widgets/loading.dart';
import 'package:stacked/stacked.dart';

class ReadingListTabView extends StatefulWidget {
  const ReadingListTabView({super.key});

  @override
  State<ReadingListTabView> createState() => _ReadingListTabViewState();
}

class _ReadingListTabViewState extends State<ReadingListTabView> {
  @override
  Widget build(BuildContext context) =>
      ViewModelBuilder<ReadingListTabViewModel>.reactive(
        viewModelBuilder: () => ReadingListTabViewModel(
            appLocalizations: AppLocalizations.of(context)!,
            router: GoRouter.of(context)),
        initialiseSpecialViewModelsOnce: true,
        builder: (context, viewModel, child) => SafeArea(
          minimum: const EdgeInsets.only(top: 20.0),
          child: RefreshIndicator(
            onRefresh: () => viewModel.refreshList(),
            child: Stack(
              children: [
                Column(
                  children: [
                    ToggleButtons(
                        borderRadius:
                            const BorderRadius.all(Radius.circular(25)),
                        onPressed: viewModel.onListTogglePress,
                        isSelected: viewModel.activeLists,
                        children: viewModel.listTitles
                            .map<Widget>((title) => Padding(
                                  padding: const EdgeInsets.only(
                                      left: 8.0, right: 8.0),
                                  child: Text(title),
                                ))
                            .toList(growable: false)),
                    Expanded(
                      child: ListView.builder(
                          padding: const EdgeInsets.only(top: 4.0, bottom: 2.0),
                          itemCount: viewModel.mangas.length,
                          itemBuilder: (BuildContext context, int index) =>
                              ListTile(
                                  title: Text(viewModel.mangas[index].attributes
                                      .title.values.first))),
                    )
                  ],
                ),
                if (viewModel.isBusy)
                  const Loading()
              ],
            ),
          ),
        ),
      );
}
