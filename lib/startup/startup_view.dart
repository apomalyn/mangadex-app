import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:mangadex/shared/utils/utils.dart';
import 'package:mangadex/shared/widgets/app_config.dart';
import 'package:mangadex/startup/startup_viewmodel.dart';
import 'package:stacked/stacked.dart';

class StartupView extends StatelessWidget {
  const StartupView({super.key});

  @override
  Widget build(BuildContext context) =>
      ViewModelBuilder<StartupViewModel>.nonReactive(
        viewModelBuilder: () => StartupViewModel(router: GoRouter.of(context)),
        onModelReady: (viewModel) => viewModel.handleStartup(),
        builder: (context, viewModel, child) => Scaffold(
          body: SafeArea(
            minimum: const EdgeInsets.all(20),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Hero(
                    tag: 'logo',
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        SizedBox(
                            width: MediaQuery.of(context).size.width * 0.4,
                            child: Image.asset(
                                Utils.imagePath('neko_sleeping_${AppConfig.of(context).environment.name}.png'))),
                        SvgPicture.asset(Utils.imagePath('mangadex_name.svg'),
                            excludeFromSemantics: true,
                            height: MediaQuery.of(context).size.height * 0.07,
                            color:
                                Theme.of(context).textTheme.bodyText1!.color),
                      ],
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.only(top: 70.0),
                    child: CircularProgressIndicator(),
                  )
                ],
              ),
            ),
          ),
        ),
      );
}
