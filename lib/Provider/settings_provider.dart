import 'package:flutter/material.dart';
import 'package:flutter_font_icons/flutter_font_icons.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

class SettingsProvider {
 IconData getIconForPlatform(String url) {
  if (url.contains('facebook.com')) {
    return FontAwesome.facebook;
  } else if (url.contains('instagram.com')) {
    return FontAwesome.instagram;
  } else if (url.contains('x.com') || url.contains('twitter.com')) {
    return FontAwesome.twitter;
  } else if (url.contains('google.com')) {
    return FontAwesome.google;
  }  else if (url.contains('youtube.com')) {
    return FontAwesome.youtube;
  } else if (url.contains('snapchat.com')) {
    return FontAwesome.snapchat;
  } else if (url.contains('linkedin.com')) {
    return FontAwesome.linkedin;
  } else if (url.contains('pinterest.com')) {
    return FontAwesome.pinterest;
  } else if (url.contains('reddit.com')) {
    return FontAwesome.reddit;
  } else {
    return Icons.link; // Si no es ninguna de estas plataformas, muestra un ícono genérico
  }
}


 Future <void> launchURL(String url) async {
    final Uri _url = Uri.parse(url); // Convierte el String a Uri
    if (!await launchUrl(_url)) {
      throw 'No se pudo abrir la URL: $url';
    }
  }


  
  void showNotePopup({required BuildContext context, required String title, required String content}) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return SingleChildScrollView(
          child: Dialog(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
            child: Container(
              
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(title, style: TextStyle(fontWeight: FontWeight.bold)),
                  const SizedBox(height: 10),
                  Text(content, textAlign: TextAlign.center),
                  const SizedBox(height: 10),
                  TextButton(
                    onPressed: () => Get.back(),
                    child: const Text("Cerrar"),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

 
}