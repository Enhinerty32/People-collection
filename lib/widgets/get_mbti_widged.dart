import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class MbtiWidget extends StatelessWidget {
  final String mbtiType;

  MbtiWidget({required this.mbtiType});
  final Map<String, Map<String, String>> mbtiData = {
    "INTJ": {
      "title": "Arquitecto",
      "description":
          "Los Arquitectos son pensadores de estrategia e imaginación, con un plan para todo.",
      "image":
          "https://www.16personalities.com/static/images/types/headers/architect-mobile.svg",
    },
    "INTP": {
      "title": "Lógico",
      "description":
          "Los Lógicos son inventores de innovación con una sed insaciable de conocimiento.",
      "image":
          "https://www.16personalities.com/static/images/types/headers/logician-desktop2.svg",
    },
    "ENTJ": {
      "title": "Comandante",
      "description":
          "Los Comandantes son líderes audaces, imaginativos y tenaces, siempre buscando un camino – o construyendo un camino.",
      "image":
          "https://www.16personalities.com/static/images/types/headers/commander-mobile.svg",
    },
    "ENTP": {
      "title": "Innovador",
      "description":
          "Los Innovadores son pensadores curiosos y flexibles que no pueden resistir un desafío intelectual.",
      "image":
          "https://www.16personalities.com/static/images/types/headers/debater-mobile.svg",
    },
    "INFJ": {
      "title": "Abogado",
      "description":
          "Los Abogados son visionarios silenciosos y con frecuencia actúan como idealistas incansables que inspiran a otros.",
      "image":
          "https://www.16personalities.com/static/images/types/headers/advocate-mobile.svg",
    },
    "INFP": {
      "title": "Mediador",
      "description":
          "Los Mediadores son personas poéticas, bondadosas y altruistas, siempre listas para ayudar a una buena causa.",
      "image":
          "https://www.16personalities.com/static/images/types/headers/mediator-mobile.svg",
    },
    "ENFJ": {
      "title": "Protagonista",
      "description":
          "Los Protagonistas son optimistas que inspiran y toman acción fácilmente para hacer lo que creen que es correcto.",
      "image":
          "https://www.16personalities.com/static/images/types/headers/protagonist-mobile.svg",
    },
    "ENFP": {
      "title": "Activista",
      "description":
          "Los Activistas son espíritus libres, entusiastas, creativos y sociables, que siempre encuentran una razón para sonreír.",
      "image":
          "https://www.16personalities.com/static/images/types/headers/campaigner-mobile.svg",
    },
    "ISTJ": {
      "title": "Logista",
      "description":
          "Los Logistas son individuos prácticos y conscientes de los hechos, no se puede dudar de su confiabilidad.",
      "image":
          "https://www.16personalities.com/static/images/types/headers/logistician-mobile.svg",
    },
    "ISFJ": {
      "title": "Defensor",
      "description":
          "Los Defensores son defensores cálidos y muy dedicados, siempre listos para proteger a sus seres queridos.",
      "image":
          "https://www.16personalities.com/static/images/types/headers/defender-mobile.svg",
    },
    "ESTJ": {
      "title": "Ejecutivo",
      "description":
          "Los Ejecutivos son excelentes organizadores, insuperables en la gestión de cosas – o personas.",
      "image":
          "https://www.16personalities.com/static/images/types/headers/executive-mobile.svg",
    },
    "ESFJ": {
      "title": "Cónsul",
      "description":
          "Los Cónsules son individuos muy cariñosos, sociables, con conciencia comunitaria y siempre dispuestos a ayudar.",
      "image":
          "https://www.16personalities.com/static/images/types/headers/consul-mobile.svg",
    },
    "ISTP": {
      "title": "Virtuoso",
      "description":
          "Los Virtuosos son experimentadores prácticos e innovadores, maestros de todo tipo de herramientas.",
      "image":
          "https://www.16personalities.com/static/images/types/headers/virtuoso-mobile.svg",
    },
    "ISFP": {
      "title": "Aventurero",
      "description":
          "Los Aventureros son flexibles y encantadores, siempre listos para explorar y experimentar algo nuevo.",
      "image":
          "https://www.16personalities.com/static/images/types/headers/adventurer-mobile.svg",
    },
    "ESTP": {
      "title": "Emprendedor",
      "description":
          "Los Emprendedores son personas inteligentes, enérgicas y muy perceptivas – realmente disfrutan de vivir al límite.",
      "image":
          "https://www.16personalities.com/static/images/types/headers/entrepreneur-mobile.svg",
    },
    "ESFP": {
      "title": "Animador",
      "description":
          "Los Animadores son personas espontáneas, enérgicas y entusiastas – la vida al lado de ellos nunca es aburrida.",
      "image":
          "https://www.16personalities.com/static/images/types/headers/entertainer-mobile.svg",
    },
  };

  @override
  Widget build(BuildContext context) {
      
       if (mbtiType.isEmpty ||mbtiType==null ) {
      return Center(child: Text("Tipo MBTI no encontrado"));
    }
    final String baseType = mbtiType.substring(0, 4);
    
       if (baseType.isEmpty ) {
      return Center(child: Text("Tipo MBTI no encontrado"));
    }
    final data = mbtiData[baseType];
    print("assets/mbti/${baseType}.jpg");

    if (data == null ) {
      return Center(child: Text("Tipo MBTI no encontrado"));
    }

    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            //  Image(width: 300,image: AssetImage("assets/mbti/${data["image"]}.jpg")),
            ClipRRect(
              borderRadius:
                  BorderRadius.circular(12), // Ajusta el radio de las esquinas
              child: Image.asset(
                "assets/mbti/${baseType}.jpg",
                fit: BoxFit.cover,
              ),
            ),
            // Image.network(data["image"]!, height: 100),
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text(
                  data["title"]!,
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                ),
                Text(
                  mbtiType,
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                ),
              ],
            ),

            SizedBox(height: 8),
            Text(
              data["description"]!,
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 16, color: Colors.grey[700]),
            ),
          ],
        ),
      ),
    );
  }
}
