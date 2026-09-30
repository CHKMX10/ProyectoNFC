import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_nfc_kit/flutter_nfc_kit.dart';
import 'package:ndef/ndef.dart' as ndef;

class ConfirmacionEliminarNFCWidget extends StatefulWidget {
  const ConfirmacionEliminarNFCWidget({super.key});

  @override
  State<ConfirmacionEliminarNFCWidget> createState() =>
      _ConfirmacionEliminarNFCWidgetState();
}

class _ConfirmacionEliminarNFCWidgetState
    extends State<ConfirmacionEliminarNFCWidget> {

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
      height: 300.0,
      decoration: BoxDecoration(
        color: FlutterFlowTheme.of(context).info,
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
                '¿Está seguro de que desea eliminar la información de la tarjeta NFC? Esta acción no se puede deshacer.',
                textAlign: TextAlign.center,
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
              text: 'Eliminar',
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
            Padding(
              padding: EdgeInsetsDirectional.fromSTEB(0.0, 16.0, 0.0, 0.0),
              child: FFButtonWidget(
                onPressed: () async {
                  Navigator.pop(context);
                },
                text: 'Cancelar',
                options: FFButtonOptions(
                  width: double.infinity,
                  height: 60.0,
                  padding: EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 0.0),
                  iconPadding:
                  EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 0.0),
                  color: Colors.white,
                  textStyle: FlutterFlowTheme.of(context).titleSmall.override(
                    fontFamily: 'Lexend Deca',
                    color: Color(0xFF57636C),
                    fontSize: 16.0,
                    letterSpacing: 0.0,
                    fontWeight: FontWeight.normal,
                  ),
                  elevation: 0.0,
                  borderSide: BorderSide(
                    color: Colors.transparent,
                    width: 0.0,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
