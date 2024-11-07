import 'package:app_rutas_comsi/Models/history_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map_marker_popup/flutter_map_marker_popup.dart';

class HistoryItem extends StatefulWidget {
  const HistoryItem({super.key, required this.data, required this.popupController});

  final HistoryModel data;
  final PopupController popupController;


  @override
  State<HistoryItem> createState() => _HistoryItemState();
}

class _HistoryItemState extends State<HistoryItem> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        SizedBox(
          height: 178,
          width: 300,
          child: Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(25.0),
                color: Colors.grey[200],
                border: Border.all(color: Color(0xffd5d5d5))
              //border: Border.all(color: Colors.black)
            ),
            child: Padding(
              padding: EdgeInsets.all(20.0),
              child: Column(
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          "Información",
                          textAlign: TextAlign.center,
                          style: TextStyle(fontSize: 22),
                        ),
                      )
                    ],
                  ),
                  SizedBox(height: 10,),
                  Expanded(
                      child: Column(
                        children: [
                          Align(
                            alignment: Alignment.centerLeft,
                            child: RichText(
                                text: TextSpan(
                                    children: [
                                      TextSpan(
                                        text: "Fecha y hora: ",
                                          style: TextStyle(color: Colors.black)
                                        //style: txtTheme.displayMedium!.copyWith(color: Colors.black),
                                      ),
                                      TextSpan(
                                        text: widget.data.fecha_pc,
                                          style: TextStyle(color: Colors.black)
                                          //style: txtTheme.bodySmall!.copyWith(color: Colors.black)
                                      )
                                    ]
                                )
                            ),
                          ),
                          Align(
                            alignment: Alignment.centerLeft,
                            child: RichText(
                              //textAlign: TextAlign.left,
                                text: TextSpan(
                                    children: [
                                      TextSpan(
                                        text: "Latitud: ",
                                          style: TextStyle(color: Colors.black)
                                        //style: txtTheme.displayMedium!.copyWith(color: Colors.black),
                                      ),
                                      TextSpan(
                                          text: widget.data.latitud,
                                          style: TextStyle(color: Colors.black)
                                          //style: txtTheme.bodySmall!.copyWith(color: Colors.black)
                                      )
                                    ]
                                )
                            ),
                          ),
                          Align(
                            alignment: Alignment.centerLeft,
                            child: RichText(
                                text: TextSpan(
                                    children: [
                                      TextSpan(
                                          text: "Longitud: ",
                                          style: TextStyle(color: Colors.black)
                                          //style: txtTheme.displayMedium!.copyWith(color: Colors.black)
                                      ),
                                      TextSpan(
                                          text: widget.data.longitud,
                                          style: TextStyle(color: Colors.black)
                                          //style: txtTheme.bodySmall!.copyWith(color: Colors.black)
                                      )
                                    ]
                                )
                            ),
                          ),
                          SizedBox(height: 15,),
                          Align(
                            alignment: Alignment.bottomLeft,
                            child: InkWell(
                              onTap: () {
                                widget.popupController.hideAllPopups();
                              },
                              child: Text("Cerrar", style: TextStyle(color: Colors.red)),
                            ),
                          ),
                        ],
                      )
                  )
                ],
              ),
            ),
          ),
        ),
        Container(
          //color: Colors.yellowAccent,
            padding: EdgeInsets.zero,
            child: Image.asset('assets/images/downgris1.png', width: 50, height: 20, fit: BoxFit.fitHeight,)
        )
      ],
    );
  }
}
