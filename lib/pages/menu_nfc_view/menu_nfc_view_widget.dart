import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/pages/componentes_n_f_c/confirmacion_eliminar_n_f_c/confirmacion_eliminar_n_f_c_widget.dart';
import '/pages/componentes_n_f_c/informacion_ayuda/informacion_ayuda_widget.dart';
import '/pages/componentes_n_f_c/format_add/format_add_widget.dart';
import '/pages/componentes_n_f_c/editar_tarjeta/editar_tarjeta_widget.dart';

import 'package:flutter/material.dart';
import 'package:flutter_nfc_kit/flutter_nfc_kit.dart';
import 'package:encrypt/encrypt.dart' as encrypt;
import 'dart:convert';
import 'package:crypto/crypto.dart';
import 'package:archive/archive.dart';
import 'package:ndef/ndef.dart' as ndef;

import 'menu_nfc_view_model.dart';
export 'menu_nfc_view_model.dart';

class MenuNfcViewWidget extends StatefulWidget {
  const MenuNfcViewWidget({super.key});

  @override
  State<MenuNfcViewWidget> createState() => _MenuNfcViewWidgetState();
}

class _MenuNfcViewWidgetState extends State<MenuNfcViewWidget> {
  late MenuNfcViewModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();


  Future<void> readFromNFC(BuildContext context) async {
    try {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Buscando Tarjeta NFC...'),
          duration: Duration(seconds: 10),
          backgroundColor: FlutterFlowTheme.of(context).primary,
        ),
      );

      NFCTag tag = await FlutterNfcKit.poll(timeout: Duration(seconds: 10));
      ScaffoldMessenger.of(context).hideCurrentSnackBar();

      if (tag.ndefAvailable == true) {
        List<ndef.NDEFRecord> records = await FlutterNfcKit.readNDEFRecords();

        if (records.isNotEmpty) {
          for (var record in records) {
            if (record is ndef.TextRecord) {
              String jsonString = record.text ?? '';
              if (jsonString.isNotEmpty) {
                try {
                  Map<String, dynamic> jsonData = jsonDecode(jsonString);

                  const pin = "252024";
                  final uid = tag.id!;
                  final combinedKey = "$uid$pin";
                  final hashKey = sha256.convert(utf8.encode(combinedKey)).toString();
                  final key = encrypt.Key.fromUtf8(hashKey.substring(0, 32));
                  final iv = encrypt.IV.fromUtf8(hashKey.substring(32, 48));

                  final encrypter = encrypt.Encrypter(encrypt.AES(key));

                  final encryptedCompressedData = jsonData['data'] as String;
                  final compressedData = encrypter.decrypt64(encryptedCompressedData, iv: iv);
                  final jsonStringData = decompressData(compressedData);

                  final decryptedData = jsonDecode(jsonStringData);

                  // Muestra el bottom sheet para editar los datos
                  await showModalBottomSheet(
                    isScrollControlled: true,
                    backgroundColor: Colors.transparent,
                    enableDrag: false,
                    context: context,
                    builder: (context) {
                      return GestureDetector(
                        onTap: () => FocusScope.of(context).unfocus(),
                        child: Padding(
                          padding: MediaQuery.viewInsetsOf(context),
                          child: EditarTarjetaWidget(tarjetaData: decryptedData),
                        ),
                      );
                    },
                  ).then((value) {
                    if (value != null) {
                      // Maneja los datos actualizados
                      print("Datos actualizados: $value");
                    }
                  });

                } catch (e) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Error al leer los datos.'),
                      backgroundColor: Colors.red,
                    ),
                  );
                }
              }
            }
          }
        }
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('La tarjeta no es compatible con NDEF.'),
            backgroundColor: Colors.red,
          ),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error al leer la tarjeta NFC.'),
          backgroundColor: Colors.red,
        ),
      );
    } finally {
      await FlutterNfcKit.finish();
    }
  }

  String decompressData(String data) {
    final compressed = base64.decode(data); // Decodifica desde Base64
    final decompressed = GZipDecoder().decodeBytes(compressed); // Descomprime los bytes
    return utf8.decode(decompressed); // Convierte los bytes a string
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => MenuNfcViewModel());
  }

  @override
  void dispose() {
    _model.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        key: scaffoldKey,
        backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
        appBar: AppBar(
          backgroundColor: FlutterFlowTheme.of(context).primary,
          automaticallyImplyLeading: false,
          leading: FlutterFlowIconButton(
            borderColor: Colors.transparent,
            borderRadius: 30.0,
            borderWidth: 1.0,
            buttonSize: 60.0,
            icon: Icon(
              Icons.arrow_back_rounded,
              color: Colors.white,
              size: 30.0,
            ),
            onPressed: () async {
              Navigator.pop(context);
            },
          ),
          title: Text(
            'Controla tu Tarjeta',
            style: FlutterFlowTheme.of(context).headlineMedium.override(
              fontFamily: 'Inter Tight',
              color: Colors.white,
              fontSize: 22.0,
              letterSpacing: 0.0,
            ),
          ),
          actions: [],
          centerTitle: true,
          elevation: 2.0,
        ),
        body: SafeArea(
          top: true,
          child: Align(
            alignment: AlignmentDirectional(0.0, 0.0),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  width: 198.0,
                  height: 143.0,
                  decoration: BoxDecoration(
                    color: Color(0xFFF1F4F8),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10.0),
                    child: Image.asset(
                      'assets/images/tarjeta.png',
                      width: 263.0,
                      height: 232.0,
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
                Align(
                  alignment: AlignmentDirectional(0.0, 0.0),
                  child: FFButtonWidget(
                    onPressed: () async {
                      await showModalBottomSheet(
                        isScrollControlled: true,
                        backgroundColor: Colors.transparent,
                        enableDrag: false,
                        context: context,
                        builder: (context) {
                          return GestureDetector(
                            onTap: () => FocusScope.of(context).unfocus(),
                            child: Padding(
                              padding: MediaQuery.viewInsetsOf(context),
                              child: InformacionAyudaWidget(),
                            ),
                          );
                        },
                      ).then((value) => safeSetState(() {}));

                      await showModalBottomSheet(
                        isScrollControlled: true,
                        backgroundColor: Colors.transparent,
                        enableDrag: false,
                        context: context,
                        builder: (context) {
                          return GestureDetector(
                            onTap: () => FocusScope.of(context).unfocus(),
                            child: Padding(
                              padding: MediaQuery.viewInsetsOf(context),
                              child: FormatAddWidget(),
                            ),
                          );
                        },
                      ).then((value) => safeSetState(() {}));


                      context.pushNamed('LlenarTarjetaView');
                    },
                    text: 'Añadir información',
                    icon: Icon(
                      Icons.add,
                      size: 15.0,
                    ),
                    options: FFButtonOptions(
                      width: 230.0,
                      height: 52.0,
                      padding:
                      EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 0.0),
                      iconAlignment: IconAlignment.end,
                      iconPadding:
                      EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 0.0),
                      color: FlutterFlowTheme.of(context).primary,
                      textStyle:
                      FlutterFlowTheme.of(context).titleSmall.override(
                        fontFamily: 'Inter Tight',
                        color: Colors.white,
                        letterSpacing: 0.0,
                      ),
                      elevation: 3.0,
                      borderSide: BorderSide(
                        color: Colors.transparent,
                        width: 1.0,
                      ),
                      borderRadius: BorderRadius.circular(40.0),
                    ),
                  ),
                ),
                Align(
                  alignment: AlignmentDirectional(0.0, 0.0),
                  child: FFButtonWidget(
                    onPressed: () async { //accion editar
                      await readFromNFC(context);
                    },
                    text: 'Modificar Tarjeta',
                    icon: Icon(
                      Icons.edit,
                      size: 15.0,
                    ),
                    options: FFButtonOptions(
                      width: 230.0,
                      height: 52.0,
                      padding:
                      EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 0.0),
                      iconAlignment: IconAlignment.end,
                      iconPadding:
                      EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 0.0),
                      color: FlutterFlowTheme.of(context).primary,
                      textStyle:
                      FlutterFlowTheme.of(context).titleSmall.override(
                        fontFamily: 'Inter Tight',
                        color: Colors.white,
                        letterSpacing: 0.0,
                      ),
                      elevation: 3.0,
                      borderSide: BorderSide(
                        color: Colors.transparent,
                        width: 1.0,
                      ),
                      borderRadius: BorderRadius.circular(40.0),
                    ),
                  ),
                ),
                Align(
                  alignment: AlignmentDirectional(0.0, 0.0),
                  child: FFButtonWidget(
                    onPressed: () async {
                      await showModalBottomSheet(
                        isScrollControlled: true,
                        backgroundColor: Colors.transparent,
                        enableDrag: false,
                        context: context,
                        builder: (context) {
                          return GestureDetector(
                            onTap: () => FocusScope.of(context).unfocus(),
                            child: Padding(
                              padding: MediaQuery.viewInsetsOf(context),
                              child: InformacionAyudaWidget(),
                            ),
                          );
                        },
                      ).then((value) => safeSetState(() {}));
                      context.pushNamed('verDatosNfcView');
                    },
                    text: 'Visualizar Información',
                    icon: Icon(
                      Icons.remove_red_eye,
                      size: 15.0,
                    ),
                    options: FFButtonOptions(
                      width: 230.0,
                      height: 52.0,
                      padding:
                      EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 0.0),
                      iconAlignment: IconAlignment.end,
                      iconPadding:
                      EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 0.0),
                      color: FlutterFlowTheme.of(context).primary,
                      textStyle:
                      FlutterFlowTheme.of(context).titleSmall.override(
                        fontFamily: 'Inter Tight',
                        color: Colors.white,
                        letterSpacing: 0.0,
                      ),
                      elevation: 3.0,
                      borderSide: BorderSide(
                        color: Colors.transparent,
                        width: 1.0,
                      ),
                      borderRadius: BorderRadius.circular(40.0),
                    ),
                  ),
                ),
                Align(
                  alignment: AlignmentDirectional(0.0, 0.0),
                  child: FFButtonWidget(
                    onPressed: () async {

                      await showModalBottomSheet(
                        isScrollControlled: true,
                        backgroundColor: Colors.transparent,
                        enableDrag: false,
                        context: context,
                        builder: (context) {
                          return GestureDetector(
                            onTap: () => FocusScope.of(context).unfocus(),
                            child: Padding(
                              padding: MediaQuery.viewInsetsOf(context),
                              child: InformacionAyudaWidget(),
                            ),
                          );
                        },
                      ).then((value) => safeSetState(() {}));

                      await showModalBottomSheet(
                        isScrollControlled: true,
                        backgroundColor: Colors.transparent,
                        enableDrag: false,
                        context: context,
                        builder: (context) {
                          return GestureDetector(
                            onTap: () => FocusScope.of(context).unfocus(),
                            child: Padding(
                              padding: MediaQuery.viewInsetsOf(context),
                              child: ConfirmacionEliminarNFCWidget(),
                            ),
                          );
                        },
                      ).then((value) => safeSetState(() {}));
                    },
                    text: 'Formatear',
                    icon: Icon(
                      Icons.delete,
                      size: 15.0,
                    ),
                    options: FFButtonOptions(
                      width: 230.0,
                      height: 52.0,
                      padding:
                      EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 0.0),
                      iconAlignment: IconAlignment.end,
                      iconPadding:
                      EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 0.0),
                      color: FlutterFlowTheme.of(context).error,
                      textStyle:
                      FlutterFlowTheme.of(context).titleSmall.override(
                        fontFamily: 'Inter Tight',
                        color: Colors.white,
                        letterSpacing: 0.0,
                      ),
                      elevation: 3.0,
                      borderSide: BorderSide(
                        color: Colors.transparent,
                        width: 1.0,
                      ),
                      borderRadius: BorderRadius.circular(40.0),
                    ),
                  ),
                ),
              ].divide(SizedBox(height: 20.0)),
            ),
          ),
        ),
      ),
    );
  }
}
