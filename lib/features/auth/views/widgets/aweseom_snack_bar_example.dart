import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/material.dart';
import 'package:mahu_home_services_app/features/auth/views/widgets/custom_snack_bar.dart';

class AweseomSnackBarExample extends StatelessWidget {
  const AweseomSnackBarExample({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ElevatedButton(
              child: const Text('Show Awesome SnackBar'),
              onPressed: () {
                const snackBar = SnackBar(
                  /// need to set following properties for best effect of awesome_snackbar_content
                  elevation: 0,
                  behavior: SnackBarBehavior.floating,
                  backgroundColor: Colors.transparent,
                  content: AwesomeSnackbarContent(
                    color: Colors.amber,
                    title: 'On Snap!',
                    message:
                        'This is an example error message that will be shown in the body of snackbar!',
                    contentType: ContentType.success,
                  ),
                );

                ScaffoldMessenger.of(context)
                  ..hideCurrentSnackBar()
                  ..showSnackBar(
                    snackBar,
                  );
              },
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              child: const Text('Show Awesome Material Banner'),
              onPressed: () {
                const materialBanner = MaterialBanner(
                  /// need to set following properties for best effect of awesome_snackbar_content
                  elevation: 0,
                  backgroundColor: Colors.transparent,
                  forceActionsBelow: true,
                  content: AwesomeSnackbarContent(
                    title: 'Oh Hey!!',
                    message:
                        'This is an example error message that will be shown in the body of materialBanner!',

                    /// change contentType to ContentType.success, ContentType.warning or ContentType.help for variants
                    contentType: ContentType.success,
                    // to configure for material banner
                    inMaterialBanner: true,
                    color: Colors.white,
                  ),
                  actions: [SizedBox.shrink()],
                );

                ScaffoldMessenger.of(context)
                  ..hideCurrentMaterialBanner()
                  ..showMaterialBanner(materialBanner);
              },
            ),
            ElevatedButton(
              onPressed: () {
                showCustomSnackBar(
                  context: context,
                  message: 'This is a custom SnackBar!',
                  type: SnackBarType.failure,
                );
              },
              child: const Text('Show SnackBar'),
            ),
          ],
        ),
      ),
    );
  }
}

