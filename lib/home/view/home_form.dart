import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ichatbot/chat/chat.dart';
import 'package:ichatbot/common/widgets/base_page.dart';
import 'package:ichatbot/l10n/l10n.dart';
import 'package:loading_indicator/loading_indicator.dart';
import 'package:ms_undraw/ms_undraw.dart';

class HomeForm extends BasePage {
  const HomeForm({Key? key}) : super(key);

  @override
  Widget widget(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const _WelcomeText(),
        const SizedBox(
          height: 60,
        ),
        UnDraw(
          height: 200,
          width: 200,
          color: Theme.of(context).primaryColor,
          illustration: UnDrawIllustration.chatting,
          placeholder: LoadingIndicator(
            indicatorType: Indicator.ballPulse,
            colors: [Theme.of(context).primaryColor],
            backgroundColor: Colors.white10,
            pathBackgroundColor: Colors.black,
          ),
          errorWidget: const Icon(
            Icons.error_outline,
            color: Colors.red,
            size: 50,
          ),
        ),
        const SizedBox(
          height: 60,
        ),
        Center(child: _StartButton()),
      ],
    );
  }
}

class _WelcomeText extends StatelessWidget {
  const _WelcomeText({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final theme = Theme.of(context);
    return Text(l10n.welcomeMessage, style: theme.textTheme.headline4);
  }
}

class _StartButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 210,
      height: 50,
      child: ElevatedButton(
        key: const Key('homeForm_start_elevatedButton'),
        onPressed: () {
          context.read<ChatCubit>().resetChat();
          Navigator.of(context).push<void>(
            MaterialPageRoute(
              builder: (context) => const ChatPage(),
            ),
          );
        },
        style: ElevatedButton.styleFrom(
          shape: const StadiumBorder(),
          primary: Theme.of(context).primaryColor,
        ),
        child: const Text(
          'Start',
          style: TextStyle(
            fontSize: 17,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
