import 'package:flutter/widgets.dart';
import 'package:flutter/material.dart';
import 'dart:typed_data';
import 'package:nfc_manager/nfc_manager.dart';
import 'package:nfc_manager/platform_tags.dart';
import 'package:flutter_nfc_kit/flutter_nfc_kit.dart';

import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'package:ndef/ndef.dart' as ndef;

import 'format_add_model.dart';
export 'format_add_model.dart';
import 'package:ndef/ndef.dart';

class FormatAddWidget extends StatefulWidget {
  const FormatAddWidget({super.key});

  @override
  State<FormatAddWidget> createState() => _FormatAddWidgetState();
}

class _FormatAddWidgetState extends State<FormatAddWidget> {
  late FormatAddModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => FormatAddModel());
  }

  @override
  void dispose() {
    _model.maybeDispose();
    super.dispose();
  }


  Future<void> formatNFCWithEmptyJSON() async {
    try {
      // Iniciar la sesión NFC
      NFCTag tag = await FlutterNfcKit.poll(timeout: Duration(seconds: 10));

      // Verificar si la tarjeta es compatible con NDEF
      if (tag.ndefAvailable == true) {
        // Crear un JSON vacío
        String emptyJSON = '';

        // Crear el registro NDEF con el JSON vacío
        var record = ndef.TextRecord(
          text: emptyJSON,
          language: 'en',
        );

        // Escribir en la tarjeta
        await FlutterNfcKit.writeNDEFRecords([record]);
        print("Tarjeta NFC formateada exitosamente.");

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              'Tarjeta NFC formateada exitosamente.',
              style: TextStyle(color: Colors.white),
            ),
            backgroundColor: Colors.green,
          ),
        );
      } else {
        print("La tarjeta no ha sido formateada.");
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              'La tarjeta no ha sido formateada.'
                  'Intente nuevamente',
              style: TextStyle(color: Colors.white),
            ),
            backgroundColor: Colors.red,
          ),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Error al formatear la tarjeta NFC. $e',
            style: TextStyle(color: Colors.white),
          ),
          backgroundColor: Colors.red,
        ),
      );
    } finally {
      await FlutterNfcKit.finish();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 230.0,
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            blurRadius: 5.0,
            color: Color(0x3B1D2429),
            offset: Offset(
              0.0,
              -3.0,
            ),
          )
        ],
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(0.0),
          bottomRight: Radius.circular(0.0),
          topLeft: Radius.circular(16.0),
          topRight: Radius.circular(16.0),
        ),
      ),
      child: Padding(
        padding: EdgeInsets.all(20.0),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            Align(
              alignment: AlignmentDirectional(0.0, 0.0),
              child: Text(
                'Para asegurar que su tarjeta se grabe exitosamente, debe formatear primero su tarjeta NFC.',
                textAlign: TextAlign.justify,
                style: FlutterFlowTheme.of(context).titleLarge.override(
                  fontFamily: 'Inter Tight',
                  color: FlutterFlowTheme.of(context).primary,
                  fontSize: 18.0,
                  letterSpacing: 0.0,
                ),
              ),
            ),
            Divider(
              thickness: 2.0,
              color: FlutterFlowTheme.of(context).alternate,
            ),
            FFButtonWidget(
              onPressed: () async {
                await formatNFCWithEmptyJSON();
                Navigator.pop(context);
              },
              text: 'Formatear',
              options: FFButtonOptions(
                width: double.infinity,
                height: 60.0,
                padding: EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 0.0),
                iconPadding: EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 0.0),
                color: FlutterFlowTheme.of(context).error,
                textStyle: FlutterFlowTheme.of(context).bodyLarge.override(
                  fontFamily: 'Inter',
                  letterSpacing: 0.0,
                ),
                elevation: 2.0,
                borderSide: BorderSide(
                  color: Colors.transparent,
                  width: 1.0,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
