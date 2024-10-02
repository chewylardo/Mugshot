import 'package:flutter/material.dart';
import 'package:mugshot/pages/PerfilPersonal.dart';
import 'package:mugshot/models/Producto.dart';
import 'package:url_launcher/url_launcher.dart';
import 'dart:async'; 
//import 'package:flutter_svg/flutter_svg.dart';




class Tienda extends StatelessWidget {
   Tienda({super.key});


    



  @override
  Widget build(BuildContext context) {



    List<Producto> enVenta = [];
 

    Producto producto1 = Producto('assets/pngs/cafetera.png','cafetera', 329990, 'https://www.mercadolibre.cl/cafetera-krups-essential-ea8108-super-automatica-negra-expreso-220v/p/MLC19321246?pdp_filters=item_id:MLC1030886028#is_advertising=true&searchVariation=MLC19321246&position=1&search_layout=stack&type=pad&tracking_id=beb4430f-9e22-4389-8703-e09d71f86981&is_advertising=true&ad_domain=VQCATCORE_LST&ad_position=1&ad_click_id=ZThiODNkNzUtODU0ZC00NzYwLTk2MjEtNWNkZTQ5MjU3Mjlm');
    Producto producto2 = Producto('assets/pngs/filtro.png','filtro', 6434, 'https://www.mercadolibre.cl/bolsa-de-papel-de-filtro-de-cafe-portatil-de-50-piezas-para/p/MLC29435670#searchVariation%3DMLC29435670%26position%3D14%26search_layout%3Dstack%26type%3Dproduct%26tracking_id%3D3f56267d-3ba1-4a46-a56c-915d1831a021');
    Producto producto3 = Producto('assets/pngs/Tamper.png','Tamper', 13946, 'https://articulo.mercadolibre.cl/MLC-1484032833-tamper-cafe-espresso-barista-con-escala-cubierta-protectora-_JM#is_advertising=true&position=10&search_layout=stack&type=pad&tracking_id=6882ff6a-cb83-4a1f-8eee-10354d7c313d&is_advertising=true&ad_domain=VQCATCORE_LST&ad_position=10&ad_click_id=MWVhZDViNTMtMTdhZi00MDUzLTk3YzgtNjMyMzdlNzRjODk5');
    


    enVenta.add(producto1);
     enVenta.add(producto2);
      enVenta.add(producto3);
  

    void _launchUrl(String myUrl) async {
    final Uri url = Uri.parse(myUrl);
    if (!await launchUrl(url)) {
      throw 'Could not launch $url';
    }
  }


    var scaffold6 = Scaffold(
      appBar: AppBar(
        title: const Text('Productos a la venta'),
      ),
      body: Center(
      
      child: ListView.builder(
       
        padding: const EdgeInsets.all(16.0),
        itemCount: enVenta.length, 
        itemBuilder: (context, index) {
          return Card(
            elevation: 3,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            margin: const EdgeInsets.symmetric(vertical: 10.0),
            child: SizedBox(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  
                  children: [
                     Image(image:AssetImage(enVenta[index].png)),
                    SizedBox(height: 20),
                    Text(
                       enVenta[index].nombre,
                       style: Theme.of(context).textTheme.headlineMedium,
                      
                    ),
                    Text(
                      'precio: ' + enVenta[index].precio.toString(),
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: <Widget>[
                        TextButton(
                          child: const Text('link a la pagina'),
                          onPressed: () {
                            _launchUrl(enVenta[index].pagina);
                          },
                        ),
                        const SizedBox(width: 8),
                       
                      ],
                    )
                  ],
                ),
              ),
            ),
          );
        },
      ),
    ), 
      persistentFooterButtons: const <Widget>[
       
      ]
    );

    var scaffold5 = scaffold6;
    var scaffold4 = scaffold5;
    var scaffold3 = scaffold4;
    var scaffold2 = scaffold3;
    var scaffold = scaffold2;
    return scaffold;

  }
}



