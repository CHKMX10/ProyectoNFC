import 'package:flutter/material.dart';
import 'package:flutter_nfc_kit/flutter_nfc_kit.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';

class LeerTarjetaViewWidget extends StatefulWidget {
  const LeerTarjetaViewWidget({super.key});

  @override
  State<LeerTarjetaViewWidget> createState() => _LeerTarjetaViewWidgetState();
}

class _LeerTarjetaViewWidgetState extends State<LeerTarjetaViewWidget> {
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
  }

  Future<void> _scanNFC() async {
    try {
      var availability = await FlutterNfcKit.nfcAvailability;

      if (availability == NFCAvailability.available) {
        NFCTag tag = await FlutterNfcKit.poll(timeout: Duration(seconds: 15));
        print("Tarjeta detectada: ${tag.type}, ID: ${tag.id}");

        if (tag.type != NFCTagType.unknown) {
          // Si la tarjeta es compatible, navega a 'menuNfcView' y muestra el UID de la tarjeta
          context.pushNamed('menuNfcView');
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                'Tarjeta detectada: UID ${tag.id}',
                style: TextStyle(
                  color: FlutterFlowTheme.of(context).success,
                ),
              ),
              duration: Duration(milliseconds: 2000),
              backgroundColor: FlutterFlowTheme.of(context).secondary,
            ),
          );
        } else {
          // Si no es compatible, muestra un mensaje y permanece en la misma vista
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                'Tarjeta NFC no compatible.',
                style: TextStyle(
                  color: FlutterFlowTheme.of(context).error,
                ),
              ),
              duration: Duration(milliseconds: 3000),
              backgroundColor: FlutterFlowTheme.of(context).secondary,
            ),
          );
        }
        await FlutterNfcKit.finish(); // Termina la sesión NFC
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              'NFC no está disponible en este dispositivo.',
              style: TextStyle(
                color: FlutterFlowTheme.of(context).error,
              ),
            ),
            duration: Duration(milliseconds: 4000),
            backgroundColor: FlutterFlowTheme.of(context).secondary,
          ),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Error al intentar leer NFC: $e',
            style: TextStyle(
              color: FlutterFlowTheme.of(context).error,
            ),
          ),
          duration: Duration(milliseconds: 4000),
          backgroundColor: FlutterFlowTheme.of(context).secondary,
        ),
      );
    }
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
            'Identificar Tarjeta',
            style: FlutterFlowTheme.of(context).headlineMedium.override(
              fontFamily: 'Inter Tight',
              color: Colors.white,
              fontSize: 22.0,
              letterSpacing: 0.0,
            ),
          ),
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
                  height: 206.0,
                  decoration: BoxDecoration(
                    color: Color(0xFFF1F4F8),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(8.0),
                    child: Image.asset(
                      'assets/images/escanImg.png',
                      width: 263.0,
                      height: 283.0,
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(50.0, 0.0, 45.0, 0.0),
                  child: Text(
                    'Por favor, acerque su Tarjeta NFC a la parte posterior de su teléfono.',
                    style: FlutterFlowTheme.of(context).bodyMedium.override(
                      fontFamily: 'Inter',
                      letterSpacing: 0.0,
                    ),
                  ),
                ),
                Padding(
                  padding:
                  EdgeInsetsDirectional.fromSTEB(50.0, 12.0, 50.0, 12.0),
                  child: FFButtonWidget(
                    onPressed: _scanNFC,
                    text: 'Escanear',
                    options: FFButtonOptions(
                      width: double.infinity,
                      height: 48.0,
                      padding:
                      EdgeInsetsDirectional.fromSTEB(24.0, 0.0, 24.0, 0.0),
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
                      borderRadius: BorderRadius.circular(8.0),
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
