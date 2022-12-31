import 'package:flutter/material.dart';
import 'package:gallery_saver/gallery_saver.dart';

import '../../shared/translations/toolbar.i18n.dart';
import '../services/image.utils.dart';
import 'image-tap-wrapper.dart';
import 'simple-dialog-item.dart';

// TODO: TEST ON MOBILE
// Dialog for image read only that can save the image or zoom on the image.
class OptionMenuForReadOnlyImage extends StatelessWidget {
  final String imageUrl;
  final Widget child;

  const OptionMenuForReadOnlyImage({
    required this.imageUrl,
    required this.child,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => GestureDetector(
        onTap: () => showDialog(
          context: context,
          builder: (context) => _dialog(
            children: [
              _saveDialogItem(context),
              _zoomDialogItem(context),
            ],
          ),
        ),
        child: child,
      );

  Widget _dialog({required List<Widget> children}) => Padding(
        padding: const EdgeInsets.fromLTRB(50, 0, 50, 0),
        child: SimpleDialog(
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(10),
            ),
          ),
          children: children,
        ),
      );

  Widget _saveDialogItem(BuildContext context) => SimpleDialogItem(
        icon: Icons.save,
        color: Colors.greenAccent,
        text: 'Save'.i18n,
        onPressed: () {
          final _imageUtils = ImageUtils();

          final _imageUrl = _imageUtils.appendFileExtensionToImageUrl(
            imageUrl,
          );
          GallerySaver.saveImage(_imageUrl).then(
            (_) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('Saved'.i18n),
                ),
              );
              Navigator.pop(context);
            },
          );
        },
      );

  Widget _zoomDialogItem(BuildContext context) => SimpleDialogItem(
        icon: Icons.zoom_in,
        color: Colors.cyanAccent,
        text: 'Zoom'.i18n,
        onPressed: () {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => ImageTapWrapper(
                imageUrl: imageUrl,
              ),
            ),
          );
        },
      );
}
