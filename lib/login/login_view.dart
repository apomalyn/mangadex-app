import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:mangadex/login/login_viewmodel.dart';
import 'package:mangadex/login/widgets/password_field.dart';
import 'package:mangadex/shared/constant/app_theme.dart';
import 'package:mangadex/shared/utils/utils.dart';
import 'package:mangadex/shared/widgets/base_scaffold.dart';
import 'package:stacked/stacked.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final _focusNode = FocusScopeNode();

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) => ViewModelBuilder<
          LoginViewModel>.reactive(
      viewModelBuilder: () => LoginViewModel(
          appLocalizations: AppLocalizations.of(context)!,
          router: GoRouter.of(context)),
      builder: (context, viewModel, child) => BaseScaffold(
            resizeToAvoidBottomInset: false,
            isLoading: viewModel.isBusy,
            body: Padding(
                padding: const EdgeInsets.fromLTRB(20.0, 50.0, 20.0, 50.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      flex: 1,
                      child: Padding(
                        padding: const EdgeInsets.only(top: 40),
                        child: Hero(
                          tag: 'logo',
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SizedBox(
                                  width: MediaQuery.of(context).size.width * 0.3,
                                  child: Image.asset(
                                      Utils.imagePath('neko_sleeping.png'))),
                              SvgPicture.asset(
                                  Utils.imagePath('mangadex_name.svg'),
                                  excludeFromSemantics: true,
                                  height:
                                      MediaQuery.of(context).size.height * 0.05,
                                  color: Theme.of(context)
                                      .textTheme
                                      .bodyText1!
                                      .color),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 2,
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(bottom: 8.0),
                            child: AutofillGroup(
                              child: Form(
                                key: _formKey,
                                onChanged: () {
                                  setState(() {
                                    _formKey.currentState?.validate();
                                  });
                                },
                                child: FocusScope(
                                  node: _focusNode,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      TextFormField(
                                        autofillHints: const [
                                          AutofillHints.username
                                        ],
                                        initialValue: viewModel.username,
                                        validator: viewModel.usernameValidator,
                                        textInputAction: TextInputAction.next,
                                        decoration: InputDecoration(
                                          labelText:
                                              AppLocalizations.of(context)!
                                                  .login_username_field_label,
                                          labelStyle: const TextStyle(
                                              color: Colors.white54),
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 20,
                                      ),
                                      PasswordField(
                                          validator:
                                              viewModel.passwordValidator,
                                          onEditionComplete: () {
                                            TextInput.finishAutofillContext();
                                          },
                                          labelText:
                                              AppLocalizations.of(context)!
                                                  .login_password_field_label),
                                      const SizedBox(
                                        height: 40,
                                      ),
                                      SizedBox(
                                        width: double.infinity,
                                        child: ElevatedButton(
                                            onPressed: viewModel.canSubmit
                                                ? () => viewModel.authenticate()
                                                : null,
                                            style: ButtonStyle(
                                                backgroundColor:
                                                    MaterialStateProperty.all(
                                                        viewModel.canSubmit
                                                            ? AppTheme.orange
                                                            : Colors.white38),
                                                shadowColor: MaterialStateProperty.all(
                                                    AppTheme.orange),
                                                padding: MaterialStateProperty.all(
                                                    const EdgeInsets.all(16))),
                                            child: Text(
                                                AppLocalizations.of(context)!
                                                    .login_submit,
                                                style: Theme.of(context)
                                                    .primaryTextTheme
                                                    .headline5)),
                                      ),
                                      const SizedBox(height: 20),
                                      TextButton(
                                          onPressed: () {},
                                          child: Text(
                                            AppLocalizations.of(context)!
                                                .login_forgot_username_password,
                                            style: const TextStyle(
                                                color: AppTheme.orange),
                                          ))
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                )),
          ));
}
