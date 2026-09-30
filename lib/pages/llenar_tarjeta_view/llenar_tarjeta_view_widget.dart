import '/backend/backend.dart';
import '/flutter_flow/flutter_flow_choice_chips.dart';
import '/flutter_flow/flutter_flow_drop_down.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/flutter_flow/form_field_controller.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:archive/archive.dart';
import 'package:flutter_nfc_kit/flutter_nfc_kit.dart';
import 'package:encrypt/encrypt.dart' as encrypt;
import 'package:crypto/crypto.dart';
import 'package:ndef/ndef.dart' as ndef;

import 'llenar_tarjeta_view_model.dart';
export 'llenar_tarjeta_view_model.dart';

class LlenarTarjetaViewWidget extends StatefulWidget {
  const LlenarTarjetaViewWidget({super.key});

  @override
  State<LlenarTarjetaViewWidget> createState() =>
      _LlenarTarjetaViewWidgetState();
}

Future<void> writeToNFC(BuildContext context, Map<String, dynamic> jsonData) async {
  try {
    // Iniciar la sesión NFC
    NFCTag tag = await FlutterNfcKit.poll(timeout: Duration(seconds: 15));
    print("Tarjeta detectada: ${tag.type}, ID: ${tag.id}");

    // Verificar si la tarjeta tiene un UID válido
    if (tag.id == null || tag.id!.isEmpty) {
      throw Exception("No se pudo obtener el UID de la tarjeta NFC.");
    }

    const pin = "252024"; // PIN definido por el usuario
    final uid = tag.id!;
    final combinedKey = "$uid$pin"; // Concatenar UID y PIN
    final hashKey = sha256.convert(utf8.encode(combinedKey)).toString(); // Generar un hash SHA-256
    final key = encrypt.Key.fromUtf8(hashKey.substring(0, 32)); // Tomar los primeros 32 caracteres para AES
    final iv = encrypt.IV.fromUtf8(hashKey.substring(32, 48)); // Tomar los siguientes 16 caracteres para IV

    // Inicializar el cifrador
    final encrypter = encrypt.Encrypter(encrypt.AES(key));

    // Comprime el JSON
    String jsonString = jsonEncode(jsonData);
    final compressedData = compressData(jsonString);

    // Cifrar los datos comprimidos
    final encryptedCompressedData = encrypter.encrypt(compressedData, iv: iv).base64;

    // Crear un mapa con los datos cifrados
    Map<String, dynamic> encryptedData = {'data': encryptedCompressedData};

    // Convierte el mapa cifrado a un string JSON
    String finalData = jsonEncode(encryptedData);

    // Verificar si la tarjeta es compatible con NDEF
    if (tag.ndefAvailable == true) {

      // Verificar si los datos caben en la tarjeta
      final maxCapacity = tag.ndefCapacity ?? 0; // Capacidad máxima de la tarjeta
      if (finalData.length > maxCapacity) {
        context.pushNamed('menuNfcView');
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error: Los datos exceden la capacidad de la tarjeta (${maxCapacity} bytes).'),
            backgroundColor: Colors.red,
          ),
        );
        return;
      }

      // Crear un registro NDEF con los datos cifrados
      var record = ndef.TextRecord(
        text: finalData, // Escribe los datos cifrados en el JSON
        language: 'en',
      );

      // Escribir el mensaje NDEF en la tarjeta NFC
      await FlutterNfcKit.writeNDEFRecords([record]);
      Navigator.pop(context);

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Información cifrada escrita en NFC exitosamente.'),
          backgroundColor: Colors.green,
        ),
      );

    } else {
      Navigator.pop(context);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('La tarjeta no es compatible con NDEF.'),
          backgroundColor: Colors.red,
        ),
      );
    }
  } catch (e) {
    Navigator.pop(context);
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Error al escribir en la tarjeta NFC.'),
        backgroundColor: Colors.red,
      ),
    );
  } finally {
    await FlutterNfcKit.finish();
  }
}

String compressData(String data) {
  final bytes = utf8.encode(data); // Convierte el string a bytes
  if (bytes.isEmpty) {
    throw Exception("No se pudieron convertir los datos a bytes.");
  }
  final compressed = GZipEncoder().encode(bytes); // Comprime los bytes
  return base64.encode(compressed!); // Retorna el resultado en Base64
}

class _LlenarTarjetaViewWidgetState extends State<LlenarTarjetaViewWidget> {
  late LlenarTarjetaViewModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => LlenarTarjetaViewModel());

    _model.nameTextController ??= TextEditingController();
    _model.nameFocusNode ??= FocusNode();
    _model.nameFocusNode!.addListener(() => safeSetState(() {}));
    _model.birthTextController ??= TextEditingController();
    _model.birthFocusNode ??= FocusNode();
    _model.birthFocusNode!.addListener(() => safeSetState(() {}));
    _model.numETextController ??= TextEditingController();
    _model.numEFocusNode ??= FocusNode();
    _model.numEFocusNode!.addListener(() => safeSetState(() {}));
    _model.ocupacionTextController ??= TextEditingController();
    _model.ocupacionFocusNode ??= FocusNode();
    _model.ocupacionFocusNode!.addListener(() => safeSetState(() {}));
    _model.institutoTextController ??= TextEditingController();
    _model.institutoFocusNode ??= FocusNode();
    _model.institutoFocusNode!.addListener(() => safeSetState(() {}));
    _model.nssTextController ??= TextEditingController();
    _model.nssFocusNode ??= FocusNode();
     _model.nssFocusNode!.addListener(() => safeSetState(() {}));
    _model.calleTextController ??= TextEditingController();
    _model.calleFocusNode ??= FocusNode();
    _model.calleFocusNode!.addListener(() => safeSetState(() {}));
    _model.coloniaTextController ??= TextEditingController();
    _model.coloniaFocusNode ??= FocusNode();
    _model.coloniaFocusNode!.addListener(() => safeSetState(() {}));
    _model.ciudadTextController ??= TextEditingController();
    _model.ciudadFocusNode ??= FocusNode();
    _model.ciudadFocusNode!.addListener(() => safeSetState(() {}));
    _model.alergiasTTextController ??= TextEditingController();
    _model.alergiasTFocusNode ??= FocusNode();
    _model.alergiasTFocusNode!.addListener(() => safeSetState(() {}));
    _model.antPerPatTextController ??= TextEditingController();
    _model.antPerPatFocusNode ??= FocusNode();
    _model.antPerPatFocusNode!.addListener(() => safeSetState(() {}));
    _model.antPerNoPatTextController ??= TextEditingController();
    _model.antPerNoPatFocusNode ??= FocusNode();
    _model.antPerNoPatFocusNode!.addListener(() => safeSetState(() {}));
    _model.antHeFaTextController ??= TextEditingController();
    _model.antHeFaFocusNode ??= FocusNode();
    _model.antHeFaFocusNode!.addListener(() => safeSetState(() {}));
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
        backgroundColor: FlutterFlowTheme.of(context).secondaryBackground,
        appBar: AppBar(
          backgroundColor: FlutterFlowTheme.of(context).secondaryBackground,
          automaticallyImplyLeading: false,
          leading: FlutterFlowIconButton(
            borderColor: Colors.transparent,
            borderRadius: 30.0,
            borderWidth: 1.0,
            buttonSize: 60.0,
            icon: Icon(
              Icons.arrow_back_rounded,
              color: FlutterFlowTheme.of(context).primaryText,
              size: 30.0,
            ),
            onPressed: () async {
              Navigator.pop(context);
            },
          ),
          title: Text(
            'Llene la información',
            style: FlutterFlowTheme.of(context).headlineSmall.override(
              fontFamily: 'Inter Tight',
              letterSpacing: 0.0,
            ),
          ),
          actions: [],
          centerTitle: false,
          elevation: 0.0,
        ),
        body: SafeArea(
          top: true,
          child: Form(
            key: _model.formKey,
            autovalidateMode: AutovalidateMode.disabled,
            child: Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Align(
                          alignment: AlignmentDirectional(0.0, -1.0),
                          child: Container(
                            constraints: BoxConstraints(
                              maxWidth: 770.0,
                            ),
                            decoration: BoxDecoration(),
                            child: Padding(
                              padding: EdgeInsetsDirectional.fromSTEB(
                                  16.0, 12.0, 16.0, 0.0),
                              child: Column(
                                mainAxisSize: MainAxisSize.max,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Datos generales',
                                    style: FlutterFlowTheme.of(context)
                                        .bodyMedium
                                        .override(
                                      fontFamily: 'Inter',
                                      letterSpacing: 0.0,
                                    ),
                                  ),
                                  TextFormField(
                                    controller: _model.nameTextController,
                                    focusNode: _model.nameFocusNode,
                                    autofocus: true,
                                    textCapitalization:
                                    TextCapitalization.words,
                                    obscureText: false,
                                    decoration: InputDecoration(
                                      labelText: 'Nombre completo',
                                      labelStyle: FlutterFlowTheme.of(context)
                                          .headlineMedium
                                          .override(
                                        fontFamily: 'Inter Tight',
                                        color: FlutterFlowTheme.of(context)
                                            .secondaryText,
                                        letterSpacing: 0.0,
                                      ),
                                      hintStyle: FlutterFlowTheme.of(context)
                                          .labelMedium
                                          .override(
                                        fontFamily: 'Inter',
                                        letterSpacing: 0.0,
                                      ),
                                      errorStyle: FlutterFlowTheme.of(context)
                                          .bodyMedium
                                          .override(
                                        fontFamily: 'Inter',
                                        letterSpacing: 0.0,
                                      ),
                                      enabledBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                          color: FlutterFlowTheme.of(context)
                                              .alternate,
                                          width: 2.0,
                                        ),
                                        borderRadius:
                                        BorderRadius.circular(12.0),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                          color: FlutterFlowTheme.of(context)
                                              .primary,
                                          width: 2.0,
                                        ),
                                        borderRadius:
                                        BorderRadius.circular(12.0),
                                      ),
                                      errorBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                          color: FlutterFlowTheme.of(context)
                                              .error,
                                          width: 2.0,
                                        ),
                                        borderRadius:
                                        BorderRadius.circular(12.0),
                                      ),
                                      focusedErrorBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                          color: FlutterFlowTheme.of(context)
                                              .error,
                                          width: 2.0,
                                        ),
                                        borderRadius:
                                        BorderRadius.circular(12.0),
                                      ),
                                      filled: true,
                                      fillColor: (_model
                                          .birthFocusNode?.hasFocus ??
                                          false)
                                          ? FlutterFlowTheme.of(context).accent1
                                          : FlutterFlowTheme.of(context)
                                          .secondaryBackground,
                                      contentPadding:
                                      EdgeInsetsDirectional.fromSTEB(
                                          16.0, 20.0, 16.0, 20.0),
                                    ),
                                    style: FlutterFlowTheme.of(context)
                                        .headlineMedium
                                        .override(
                                      fontFamily: 'Inter Tight',
                                      fontSize: 22.0,
                                      letterSpacing: 0.0,
                                    ),
                                    cursorColor:
                                    FlutterFlowTheme.of(context).primary,
                                    validator: _model
                                        .nameTextControllerValidator
                                        .asValidator(context),
                                  ),
                                  TextFormField(
                                    controller: _model.birthTextController,
                                    focusNode: _model.birthFocusNode,
                                    autofocus: true,
                                    textCapitalization:
                                    TextCapitalization.words,
                                    obscureText: false,
                                    decoration: InputDecoration(
                                      labelText: 'Fecha de nacimiento ',
                                      labelStyle: FlutterFlowTheme.of(context)
                                          .bodyLarge
                                          .override(
                                        fontFamily: 'Inter',
                                        letterSpacing: 0.0,
                                      ),
                                      hintStyle: FlutterFlowTheme.of(context)
                                          .labelMedium
                                          .override(
                                        fontFamily: 'Inter',
                                        letterSpacing: 0.0,
                                      ),
                                      errorStyle: FlutterFlowTheme.of(context)
                                          .bodyMedium
                                          .override(
                                        fontFamily: 'Inter',
                                        color: FlutterFlowTheme.of(context)
                                            .error,
                                        fontSize: 12.0,
                                        letterSpacing: 0.0,
                                      ),
                                      enabledBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                          color: FlutterFlowTheme.of(context)
                                              .alternate,
                                          width: 2.0,
                                        ),
                                        borderRadius:
                                        BorderRadius.circular(12.0),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                          color: FlutterFlowTheme.of(context)
                                              .primary,
                                          width: 2.0,
                                        ),
                                        borderRadius:
                                        BorderRadius.circular(12.0),
                                      ),
                                      errorBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                          color: FlutterFlowTheme.of(context)
                                              .error,
                                          width: 2.0,
                                        ),
                                        borderRadius:
                                        BorderRadius.circular(12.0),
                                      ),
                                      focusedErrorBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                          color: FlutterFlowTheme.of(context)
                                              .error,
                                          width: 2.0,
                                        ),
                                        borderRadius:
                                        BorderRadius.circular(12.0),
                                      ),
                                      filled: true,
                                      fillColor: (_model
                                          .birthFocusNode?.hasFocus ??
                                          false)
                                          ? FlutterFlowTheme.of(context).accent1
                                          : FlutterFlowTheme.of(context)
                                          .secondaryBackground,
                                      contentPadding:
                                      EdgeInsetsDirectional.fromSTEB(
                                          16.0, 20.0, 16.0, 20.0),
                                    ),
                                    style: FlutterFlowTheme.of(context)
                                        .bodyLarge
                                        .override(
                                      fontFamily: 'Inter',
                                      letterSpacing: 0.0,
                                    ),
                                    keyboardType: TextInputType.number,
                                    cursorColor:
                                    FlutterFlowTheme.of(context).primary,
                                    validator: _model
                                        .birthTextControllerValidator
                                        .asValidator(context),
                                    inputFormatters: [_model.birthMask],
                                  ),
                                  TextFormField(
                                    controller: _model.numETextController,
                                    focusNode: _model.numEFocusNode,
                                    autofocus: true,
                                    textCapitalization:
                                    TextCapitalization.words,
                                    obscureText: false,
                                    decoration: InputDecoration(
                                      labelText:
                                      'Número en caso de emergencia ',
                                      labelStyle: FlutterFlowTheme.of(context)
                                          .labelLarge
                                          .override(
                                        fontFamily: 'Inter',
                                        letterSpacing: 0.0,
                                      ),
                                      hintStyle: FlutterFlowTheme.of(context)
                                          .labelMedium
                                          .override(
                                        fontFamily: 'Inter',
                                        letterSpacing: 0.0,
                                      ),
                                      errorStyle: FlutterFlowTheme.of(context)
                                          .bodyMedium
                                          .override(
                                        fontFamily: 'Inter',
                                        color: FlutterFlowTheme.of(context)
                                            .error,
                                        fontSize: 12.0,
                                        letterSpacing: 0.0,
                                      ),
                                      enabledBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                          color: FlutterFlowTheme.of(context)
                                              .alternate,
                                          width: 2.0,
                                        ),
                                        borderRadius:
                                        BorderRadius.circular(12.0),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                          color: FlutterFlowTheme.of(context)
                                              .primary,
                                          width: 2.0,
                                        ),
                                        borderRadius:
                                        BorderRadius.circular(12.0),
                                      ),
                                      errorBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                          color: FlutterFlowTheme.of(context)
                                              .error,
                                          width: 2.0,
                                        ),
                                        borderRadius:
                                        BorderRadius.circular(12.0),
                                      ),
                                      focusedErrorBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                          color: FlutterFlowTheme.of(context)
                                              .error,
                                          width: 2.0,
                                        ),
                                        borderRadius:
                                        BorderRadius.circular(12.0),
                                      ),
                                      filled: true,
                                      fillColor: (_model
                                          .numEFocusNode?.hasFocus ??
                                          false)
                                          ? FlutterFlowTheme.of(context).accent1
                                          : FlutterFlowTheme.of(context)
                                          .secondaryBackground,
                                      contentPadding:
                                      EdgeInsetsDirectional.fromSTEB(
                                          16.0, 20.0, 16.0, 20.0),
                                    ),
                                    style: FlutterFlowTheme.of(context)
                                        .bodyLarge
                                        .override(
                                      fontFamily: 'Inter',
                                      letterSpacing: 0.0,
                                    ),
                                    keyboardType: TextInputType.number,
                                    cursorColor:
                                    FlutterFlowTheme.of(context).primary,
                                    validator: _model
                                        .numETextControllerValidator
                                        .asValidator(context),
                                    inputFormatters: [_model.numEMask],
                                  ),
                                  TextFormField(
                                    controller: _model.ocupacionTextController,
                                    focusNode: _model.ocupacionFocusNode,
                                    autofocus: true,
                                    textCapitalization:
                                    TextCapitalization.words,
                                    obscureText: false,
                                    decoration: InputDecoration(
                                      labelText: 'Ocupación',
                                      labelStyle: FlutterFlowTheme.of(context)
                                          .labelLarge
                                          .override(
                                        fontFamily: 'Inter',
                                        letterSpacing: 0.0,
                                      ),
                                      hintStyle: FlutterFlowTheme.of(context)
                                          .labelMedium
                                          .override(
                                        fontFamily: 'Inter',
                                        letterSpacing: 0.0,
                                      ),
                                      errorStyle: FlutterFlowTheme.of(context)
                                          .bodyMedium
                                          .override(
                                        fontFamily: 'Inter',
                                        color: FlutterFlowTheme.of(context)
                                            .error,
                                        fontSize: 12.0,
                                        letterSpacing: 0.0,
                                      ),
                                      enabledBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                          color: FlutterFlowTheme.of(context)
                                              .alternate,
                                          width: 2.0,
                                        ),
                                        borderRadius:
                                        BorderRadius.circular(12.0),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                          color: FlutterFlowTheme.of(context)
                                              .primary,
                                          width: 2.0,
                                        ),
                                        borderRadius:
                                        BorderRadius.circular(12.0),
                                      ),
                                      errorBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                          color: FlutterFlowTheme.of(context)
                                              .error,
                                          width: 2.0,
                                        ),
                                        borderRadius:
                                        BorderRadius.circular(12.0),
                                      ),
                                      focusedErrorBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                          color: FlutterFlowTheme.of(context)
                                              .error,
                                          width: 2.0,
                                        ),
                                        borderRadius:
                                        BorderRadius.circular(12.0),
                                      ),
                                      filled: true,
                                      fillColor: (_model.ocupacionFocusNode
                                          ?.hasFocus ??
                                          false)
                                          ? FlutterFlowTheme.of(context).accent1
                                          : FlutterFlowTheme.of(context)
                                          .secondaryBackground,
                                      contentPadding:
                                      EdgeInsetsDirectional.fromSTEB(
                                          16.0, 20.0, 16.0, 20.0),
                                    ),
                                    style: FlutterFlowTheme.of(context)
                                        .bodyLarge
                                        .override(
                                      fontFamily: 'Inter',
                                      letterSpacing: 0.0,
                                    ),
                                    cursorColor:
                                    FlutterFlowTheme.of(context).primary,
                                    validator: _model
                                        .ocupacionTextControllerValidator
                                        .asValidator(context),
                                  ),
                                  TextFormField(
                                    controller: _model.institutoTextController,
                                    focusNode: _model.institutoFocusNode,
                                    autofocus: true,
                                    textCapitalization:
                                    TextCapitalization.words,
                                    obscureText: false,
                                    decoration: InputDecoration(
                                      labelText:
                                      'Institución a la que este afiliad@',
                                      labelStyle: FlutterFlowTheme.of(context)
                                          .labelLarge
                                          .override(
                                        fontFamily: 'Inter',
                                        letterSpacing: 0.0,
                                      ),
                                      hintStyle: FlutterFlowTheme.of(context)
                                          .labelMedium
                                          .override(
                                        fontFamily: 'Inter',
                                        letterSpacing: 0.0,
                                      ),
                                      errorStyle: FlutterFlowTheme.of(context)
                                          .bodyMedium
                                          .override(
                                        fontFamily: 'Inter',
                                        color: FlutterFlowTheme.of(context)
                                            .error,
                                        fontSize: 12.0,
                                        letterSpacing: 0.0,
                                      ),
                                      enabledBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                          color: FlutterFlowTheme.of(context)
                                              .alternate,
                                          width: 2.0,
                                        ),
                                        borderRadius:
                                        BorderRadius.circular(12.0),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                          color: FlutterFlowTheme.of(context)
                                              .primary,
                                          width: 2.0,
                                        ),
                                        borderRadius:
                                        BorderRadius.circular(12.0),
                                      ),
                                      errorBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                          color: FlutterFlowTheme.of(context)
                                              .error,
                                          width: 2.0,
                                        ),
                                        borderRadius:
                                        BorderRadius.circular(12.0),
                                      ),
                                      focusedErrorBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                          color: FlutterFlowTheme.of(context)
                                              .error,
                                          width: 2.0,
                                        ),
                                        borderRadius:
                                        BorderRadius.circular(12.0),
                                      ),
                                      filled: true,
                                      fillColor: (_model.institutoFocusNode
                                          ?.hasFocus ??
                                          false)
                                          ? FlutterFlowTheme.of(context).accent1
                                          : FlutterFlowTheme.of(context)
                                          .secondaryBackground,
                                      contentPadding:
                                      EdgeInsetsDirectional.fromSTEB(
                                          16.0, 20.0, 16.0, 20.0),
                                    ),
                                    style: FlutterFlowTheme.of(context)
                                        .bodyLarge
                                        .override(
                                      fontFamily: 'Inter',
                                      letterSpacing: 0.0,
                                    ),
                                    cursorColor:
                                    FlutterFlowTheme.of(context).primary,
                                    validator: _model
                                        .institutoTextControllerValidator
                                        .asValidator(context),
                                  ),
                                  TextFormField(
                                    controller: _model.nssTextController,
                                    focusNode: _model.nssFocusNode,
                                    autofocus: true,
                                    textCapitalization:
                                    TextCapitalization.words,
                                    obscureText: false,
                                    decoration: InputDecoration(
                                      labelText:
                                      'Número de seguro o identificación',
                                      labelStyle: FlutterFlowTheme.of(context)
                                          .labelLarge
                                          .override(
                                        fontFamily: 'Inter',
                                        letterSpacing: 0.0,
                                      ),
                                      hintStyle: FlutterFlowTheme.of(context)
                                          .labelMedium
                                          .override(
                                        fontFamily: 'Inter',
                                        letterSpacing: 0.0,
                                      ),
                                      errorStyle: FlutterFlowTheme.of(context)
                                          .bodyMedium
                                          .override(
                                        fontFamily: 'Inter',
                                        color: FlutterFlowTheme.of(context)
                                            .error,
                                        fontSize: 12.0,
                                        letterSpacing: 0.0,
                                      ),
                                      enabledBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                          color: FlutterFlowTheme.of(context)
                                              .alternate,
                                          width: 2.0,
                                        ),
                                        borderRadius:
                                        BorderRadius.circular(12.0),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                          color: FlutterFlowTheme.of(context)
                                              .primary,
                                          width: 2.0,
                                        ),
                                        borderRadius:
                                        BorderRadius.circular(12.0),
                                      ),
                                      errorBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                          color: FlutterFlowTheme.of(context)
                                              .error,
                                          width: 2.0,
                                        ),
                                        borderRadius:
                                        BorderRadius.circular(12.0),
                                      ),
                                      focusedErrorBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                          color: FlutterFlowTheme.of(context)
                                              .error,
                                          width: 2.0,
                                        ),
                                        borderRadius:
                                        BorderRadius.circular(12.0),
                                      ),
                                      filled: true,
                                      fillColor: (_model
                                          .nssFocusNode?.hasFocus ??
                                          false)
                                          ? FlutterFlowTheme.of(context).accent1
                                          : FlutterFlowTheme.of(context)
                                          .secondaryBackground,
                                      contentPadding:
                                      EdgeInsetsDirectional.fromSTEB(
                                          16.0, 20.0, 16.0, 20.0),
                                    ),
                                    style: FlutterFlowTheme.of(context)
                                        .bodyLarge
                                        .override(
                                      fontFamily: 'Inter',
                                      letterSpacing: 0.0,
                                    ),
                                    cursorColor:
                                    FlutterFlowTheme.of(context).primary,
                                    validator: _model.nssTextControllerValidator
                                        .asValidator(context),
                                  ),
                                  Text(
                                    'Genero',
                                    style: FlutterFlowTheme.of(context)
                                        .labelMedium
                                        .override(
                                      fontFamily: 'Inter',
                                      letterSpacing: 0.0,
                                    ),
                                  ),
                                  Align(
                                    alignment: AlignmentDirectional(0.0, 0.0),
                                    child: FlutterFlowChoiceChips(
                                      options: [
                                        ChipData('Mujer', Icons.female),
                                        ChipData('Hombre', Icons.male)
                                      ],
                                      onChanged: (val) => safeSetState(() =>
                                      _model.choiceChipsValue =
                                          val?.firstOrNull),
                                      selectedChipStyle: ChipStyle(
                                        backgroundColor:
                                        FlutterFlowTheme.of(context)
                                            .accent2,
                                        textStyle: FlutterFlowTheme.of(context)
                                            .bodyMedium
                                            .override(
                                          fontFamily: 'Inter',
                                          color:
                                          FlutterFlowTheme.of(context)
                                              .primaryText,
                                          letterSpacing: 0.0,
                                        ),
                                        iconColor: FlutterFlowTheme.of(context)
                                            .primaryText,
                                        iconSize: 18.0,
                                        elevation: 0.0,
                                        borderColor:
                                        FlutterFlowTheme.of(context)
                                            .secondary,
                                        borderWidth: 2.0,
                                        borderRadius:
                                        BorderRadius.circular(8.0),
                                      ),
                                      unselectedChipStyle: ChipStyle(
                                        backgroundColor:
                                        FlutterFlowTheme.of(context)
                                            .primaryBackground,
                                        textStyle: FlutterFlowTheme.of(context)
                                            .bodyMedium
                                            .override(
                                          fontFamily: 'Inter',
                                          color:
                                          FlutterFlowTheme.of(context)
                                              .secondaryText,
                                          letterSpacing: 0.0,
                                        ),
                                        iconColor: FlutterFlowTheme.of(context)
                                            .secondaryText,
                                        iconSize: 18.0,
                                        elevation: 0.0,
                                        borderColor:
                                        FlutterFlowTheme.of(context)
                                            .alternate,
                                        borderWidth: 2.0,
                                        borderRadius:
                                        BorderRadius.circular(8.0),
                                      ),
                                      chipSpacing: 12.0,
                                      rowSpacing: 12.0,
                                      multiselect: false,
                                      alignment: WrapAlignment.start,
                                      controller:
                                      _model.choiceChipsValueController ??=
                                          FormFieldController<List<String>>(
                                            [],
                                          ),
                                      wrapped: true,
                                    ),
                                  ),
                                  Text(
                                    'Domicilio',
                                    style: FlutterFlowTheme.of(context)
                                        .bodyMedium
                                        .override(
                                      fontFamily: 'Inter',
                                      letterSpacing: 0.0,
                                    ),
                                  ),
                                  TextFormField(
                                    controller: _model.calleTextController,
                                    focusNode: _model.calleFocusNode,
                                    autofocus: true,
                                    textCapitalization:
                                    TextCapitalization.words,
                                    obscureText: false,
                                    decoration: InputDecoration(
                                      labelText: 'Calle y Número',
                                      labelStyle: FlutterFlowTheme.of(context)
                                          .labelLarge
                                          .override(
                                        fontFamily: 'Inter',
                                        letterSpacing: 0.0,
                                      ),
                                      hintStyle: FlutterFlowTheme.of(context)
                                          .labelMedium
                                          .override(
                                        fontFamily: 'Inter',
                                        letterSpacing: 0.0,
                                      ),
                                      errorStyle: FlutterFlowTheme.of(context)
                                          .bodyMedium
                                          .override(
                                        fontFamily: 'Inter',
                                        color: FlutterFlowTheme.of(context)
                                            .error,
                                        fontSize: 12.0,
                                        letterSpacing: 0.0,
                                      ),
                                      enabledBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                          color: FlutterFlowTheme.of(context)
                                              .alternate,
                                          width: 2.0,
                                        ),
                                        borderRadius:
                                        BorderRadius.circular(12.0),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                          color: FlutterFlowTheme.of(context)
                                              .primary,
                                          width: 2.0,
                                        ),
                                        borderRadius:
                                        BorderRadius.circular(12.0),
                                      ),
                                      errorBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                          color: FlutterFlowTheme.of(context)
                                              .error,
                                          width: 2.0,
                                        ),
                                        borderRadius:
                                        BorderRadius.circular(12.0),
                                      ),
                                      focusedErrorBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                          color: FlutterFlowTheme.of(context)
                                              .error,
                                          width: 2.0,
                                        ),
                                        borderRadius:
                                        BorderRadius.circular(12.0),
                                      ),
                                      contentPadding:
                                      EdgeInsetsDirectional.fromSTEB(
                                          16.0, 20.0, 16.0, 20.0),
                                    ),
                                    style: FlutterFlowTheme.of(context)
                                        .bodyLarge
                                        .override(
                                      fontFamily: 'Inter',
                                      letterSpacing: 0.0,
                                    ),
                                    cursorColor:
                                    FlutterFlowTheme.of(context).primary,
                                    validator: _model
                                        .calleTextControllerValidator
                                        .asValidator(context),
                                  ),
                                  TextFormField(
                                    controller: _model.coloniaTextController,
                                    focusNode: _model.coloniaFocusNode,
                                    autofocus: true,
                                    textCapitalization:
                                    TextCapitalization.words,
                                    obscureText: false,
                                    decoration: InputDecoration(
                                      labelText: 'Colonia y CP',
                                      labelStyle: FlutterFlowTheme.of(context)
                                          .labelLarge
                                          .override(
                                        fontFamily: 'Inter',
                                        letterSpacing: 0.0,
                                      ),
                                      hintStyle: FlutterFlowTheme.of(context)
                                          .labelMedium
                                          .override(
                                        fontFamily: 'Inter',
                                        letterSpacing: 0.0,
                                      ),
                                      errorStyle: FlutterFlowTheme.of(context)
                                          .bodyMedium
                                          .override(
                                        fontFamily: 'Inter',
                                        color: FlutterFlowTheme.of(context)
                                            .error,
                                        fontSize: 12.0,
                                        letterSpacing: 0.0,
                                      ),
                                      enabledBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                          color: FlutterFlowTheme.of(context)
                                              .alternate,
                                          width: 2.0,
                                        ),
                                        borderRadius:
                                        BorderRadius.circular(12.0),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                          color: FlutterFlowTheme.of(context)
                                              .primary,
                                          width: 2.0,
                                        ),
                                        borderRadius:
                                        BorderRadius.circular(12.0),
                                      ),
                                      errorBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                          color: FlutterFlowTheme.of(context)
                                              .error,
                                          width: 2.0,
                                        ),
                                        borderRadius:
                                        BorderRadius.circular(12.0),
                                      ),
                                      focusedErrorBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                          color: FlutterFlowTheme.of(context)
                                              .error,
                                          width: 2.0,
                                        ),
                                        borderRadius:
                                        BorderRadius.circular(12.0),
                                      ),
                                      filled: true,
                                      fillColor: (_model
                                          .coloniaFocusNode?.hasFocus ??
                                          false)
                                          ? FlutterFlowTheme.of(context).accent1
                                          : FlutterFlowTheme.of(context)
                                          .secondaryBackground,
                                      contentPadding:
                                      EdgeInsetsDirectional.fromSTEB(
                                          16.0, 20.0, 16.0, 20.0),
                                    ),
                                    style: FlutterFlowTheme.of(context)
                                        .bodyLarge
                                        .override(
                                      fontFamily: 'Inter',
                                      letterSpacing: 0.0,
                                    ),
                                    cursorColor:
                                    FlutterFlowTheme.of(context).primary,
                                    validator: _model
                                        .coloniaTextControllerValidator
                                        .asValidator(context),
                                  ),
                                  TextFormField(
                                    controller: _model.ciudadTextController,
                                    focusNode: _model.ciudadFocusNode,
                                    autofocus: true,
                                    textCapitalization:
                                    TextCapitalization.words,
                                    obscureText: false,
                                    decoration: InputDecoration(
                                      labelText: 'Ciudad',
                                      labelStyle: FlutterFlowTheme.of(context)
                                          .labelLarge
                                          .override(
                                        fontFamily: 'Inter',
                                        letterSpacing: 0.0,
                                      ),
                                      hintStyle: FlutterFlowTheme.of(context)
                                          .labelMedium
                                          .override(
                                        fontFamily: 'Inter',
                                        letterSpacing: 0.0,
                                      ),
                                      errorStyle: FlutterFlowTheme.of(context)
                                          .bodyMedium
                                          .override(
                                        fontFamily: 'Inter',
                                        color: FlutterFlowTheme.of(context)
                                            .error,
                                        fontSize: 12.0,
                                        letterSpacing: 0.0,
                                      ),
                                      enabledBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                          color: FlutterFlowTheme.of(context)
                                              .alternate,
                                          width: 2.0,
                                        ),
                                        borderRadius:
                                        BorderRadius.circular(12.0),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                          color: FlutterFlowTheme.of(context)
                                              .primary,
                                          width: 2.0,
                                        ),
                                        borderRadius:
                                        BorderRadius.circular(12.0),
                                      ),
                                      errorBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                          color: FlutterFlowTheme.of(context)
                                              .error,
                                          width: 2.0,
                                        ),
                                        borderRadius:
                                        BorderRadius.circular(12.0),
                                      ),
                                      focusedErrorBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                          color: FlutterFlowTheme.of(context)
                                              .error,
                                          width: 2.0,
                                        ),
                                        borderRadius:
                                        BorderRadius.circular(12.0),
                                      ),
                                      contentPadding:
                                      EdgeInsetsDirectional.fromSTEB(
                                          16.0, 20.0, 16.0, 20.0),
                                    ),
                                    style: FlutterFlowTheme.of(context)
                                        .bodyLarge
                                        .override(
                                      fontFamily: 'Inter',
                                      letterSpacing: 0.0,
                                    ),
                                    cursorColor:
                                    FlutterFlowTheme.of(context).primary,
                                    validator: _model
                                        .ciudadTextControllerValidator
                                        .asValidator(context),
                                  ),
                                  Text(
                                    'Información clínica',
                                    style: FlutterFlowTheme.of(context)
                                        .labelMedium
                                        .override(
                                      fontFamily: 'Inter',
                                      letterSpacing: 0.0,
                                    ),
                                  ),
                                  FlutterFlowDropDown<String>(
                                    controller: _model.sangreValueController ??=
                                        FormFieldController<String>(null),
                                    options: [
                                      'A+',
                                      'A-',
                                      'B+',
                                      'B-',
                                      'AB+',
                                      'AB-',
                                      'O+',
                                      'O-'
                                    ],
                                    onChanged: (val) => safeSetState(
                                            () => _model.sangreValue = val),
                                    width: double.infinity,
                                    height: 52.0,
                                    searchHintTextStyle:
                                    FlutterFlowTheme.of(context)
                                        .labelMedium
                                        .override(
                                      fontFamily: 'Outfit',
                                      color: Color(0xFF606A85),
                                      fontSize: 14.0,
                                      letterSpacing: 0.0,
                                      fontWeight: FontWeight.w500,
                                    ),
                                    searchTextStyle:
                                    FlutterFlowTheme.of(context)
                                        .bodyMedium
                                        .override(
                                      fontFamily: 'Figtree',
                                      color: Color(0xFF6F61EF),
                                      fontSize: 14.0,
                                      letterSpacing: 0.0,
                                      fontWeight: FontWeight.w600,
                                    ),
                                    textStyle: FlutterFlowTheme.of(context)
                                        .bodyLarge
                                        .override(
                                      fontFamily: 'Inter',
                                      letterSpacing: 0.0,
                                    ),
                                    hintText: 'Seleccione su tipo de sangre',
                                    searchHintText: 'Opciones...',
                                    searchCursorColor: Color(0xFF6F61EF),
                                    icon: Icon(
                                      Icons.keyboard_arrow_down_rounded,
                                      color: Color(0xFF606A85),
                                      size: 24.0,
                                    ),
                                    fillColor:
                                    FlutterFlowTheme.of(context).alternate,
                                    elevation: 2.0,
                                    borderColor: Color(0xFFE5E7EB),
                                    borderWidth: 2.0,
                                    borderRadius: 12.0,
                                    margin: EdgeInsetsDirectional.fromSTEB(
                                        12.0, 4.0, 8.0, 4.0),
                                    hidesUnderline: true,
                                    isOverButton: true,
                                    isSearchable: true,
                                    isMultiSelect: false,
                                  ),
                                  TextFormField(
                                    controller: _model.alergiasTTextController,
                                    focusNode: _model.alergiasTFocusNode,
                                    autofocus: true,
                                    textCapitalization:
                                    TextCapitalization.words,
                                    obscureText: false,
                                    decoration: InputDecoration(
                                      labelText: 'Alergias',
                                      labelStyle: FlutterFlowTheme.of(context)
                                          .labelLarge
                                          .override(
                                        fontFamily: 'Inter',
                                        letterSpacing: 0.0,
                                      ),
                                      hintStyle: FlutterFlowTheme.of(context)
                                          .labelMedium
                                          .override(
                                        fontFamily: 'Inter',
                                        letterSpacing: 0.0,
                                      ),
                                      errorStyle: FlutterFlowTheme.of(context)
                                          .bodyMedium
                                          .override(
                                        fontFamily: 'Inter',
                                        color: FlutterFlowTheme.of(context)
                                            .error,
                                        fontSize: 12.0,
                                        letterSpacing: 0.0,
                                      ),
                                      enabledBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                          color: FlutterFlowTheme.of(context)
                                              .alternate,
                                          width: 2.0,
                                        ),
                                        borderRadius:
                                        BorderRadius.circular(12.0),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                          color: FlutterFlowTheme.of(context)
                                              .primary,
                                          width: 2.0,
                                        ),
                                        borderRadius:
                                        BorderRadius.circular(12.0),
                                      ),
                                      errorBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                          color: FlutterFlowTheme.of(context)
                                              .error,
                                          width: 2.0,
                                        ),
                                        borderRadius:
                                        BorderRadius.circular(12.0),
                                      ),
                                      focusedErrorBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                          color: FlutterFlowTheme.of(context)
                                              .error,
                                          width: 2.0,
                                        ),
                                        borderRadius:
                                        BorderRadius.circular(12.0),
                                      ),
                                      filled: true,
                                      fillColor: (_model.alergiasTFocusNode
                                          ?.hasFocus ??
                                          false)
                                          ? FlutterFlowTheme.of(context).accent1
                                          : FlutterFlowTheme.of(context)
                                          .secondaryBackground,
                                      contentPadding:
                                      EdgeInsetsDirectional.fromSTEB(
                                          16.0, 20.0, 16.0, 20.0),
                                    ),
                                    style: FlutterFlowTheme.of(context)
                                        .bodyLarge
                                        .override(
                                      fontFamily: 'Inter',
                                      letterSpacing: 0.0,
                                    ),
                                    cursorColor:
                                    FlutterFlowTheme.of(context).primary,
                                    validator: _model
                                        .alergiasTTextControllerValidator
                                        .asValidator(context),
                                  ),
                                  TextFormField(
                                    controller: _model.antPerPatTextController,
                                    focusNode: _model.antPerPatFocusNode,
                                    autofocus: true,
                                    textCapitalization:
                                    TextCapitalization.words,
                                    obscureText: false,
                                    decoration: InputDecoration(
                                      labelText:
                                      'Antecedentes personales patológicos',
                                      labelStyle: FlutterFlowTheme.of(context)
                                          .labelLarge
                                          .override(
                                        fontFamily: 'Inter',
                                        letterSpacing: 0.0,
                                      ),
                                      hintStyle: FlutterFlowTheme.of(context)
                                          .labelMedium
                                          .override(
                                        fontFamily: 'Inter',
                                        letterSpacing: 0.0,
                                      ),
                                      errorStyle: FlutterFlowTheme.of(context)
                                          .bodyMedium
                                          .override(
                                        fontFamily: 'Inter',
                                        color: FlutterFlowTheme.of(context)
                                            .error,
                                        fontSize: 12.0,
                                        letterSpacing: 0.0,
                                      ),
                                      enabledBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                          color: FlutterFlowTheme.of(context)
                                              .alternate,
                                          width: 2.0,
                                        ),
                                        borderRadius:
                                        BorderRadius.circular(12.0),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                          color: FlutterFlowTheme.of(context)
                                              .primary,
                                          width: 2.0,
                                        ),
                                        borderRadius:
                                        BorderRadius.circular(12.0),
                                      ),
                                      errorBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                          color: FlutterFlowTheme.of(context)
                                              .error,
                                          width: 2.0,
                                        ),
                                        borderRadius:
                                        BorderRadius.circular(12.0),
                                      ),
                                      focusedErrorBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                          color: FlutterFlowTheme.of(context)
                                              .error,
                                          width: 2.0,
                                        ),
                                        borderRadius:
                                        BorderRadius.circular(12.0),
                                      ),
                                      filled: true,
                                      fillColor: (_model.antPerPatFocusNode
                                          ?.hasFocus ??
                                          false)
                                          ? FlutterFlowTheme.of(context).accent1
                                          : FlutterFlowTheme.of(context)
                                          .secondaryBackground,
                                      contentPadding:
                                      EdgeInsetsDirectional.fromSTEB(
                                          16.0, 20.0, 16.0, 20.0),
                                    ),
                                    style: FlutterFlowTheme.of(context)
                                        .bodyLarge
                                        .override(
                                      fontFamily: 'Inter',
                                      letterSpacing: 0.0,
                                    ),
                                    cursorColor:
                                    FlutterFlowTheme.of(context).primary,
                                    validator: _model
                                        .antPerPatTextControllerValidator
                                        .asValidator(context),
                                  ),
                                  TextFormField(
                                    controller:
                                    _model.antPerNoPatTextController,
                                    focusNode: _model.antPerNoPatFocusNode,
                                    autofocus: true,
                                    textCapitalization:
                                    TextCapitalization.words,
                                    obscureText: false,
                                    decoration: InputDecoration(
                                      labelText:
                                      'Antecedentes personales NO patológicos',
                                      labelStyle: FlutterFlowTheme.of(context)
                                          .labelLarge
                                          .override(
                                        fontFamily: 'Inter',
                                        letterSpacing: 0.0,
                                      ),
                                      hintStyle: FlutterFlowTheme.of(context)
                                          .labelMedium
                                          .override(
                                        fontFamily: 'Inter',
                                        letterSpacing: 0.0,
                                      ),
                                      errorStyle: FlutterFlowTheme.of(context)
                                          .bodyMedium
                                          .override(
                                        fontFamily: 'Inter',
                                        color: FlutterFlowTheme.of(context)
                                            .error,
                                        fontSize: 12.0,
                                        letterSpacing: 0.0,
                                      ),
                                      enabledBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                          color: FlutterFlowTheme.of(context)
                                              .alternate,
                                          width: 2.0,
                                        ),
                                        borderRadius:
                                        BorderRadius.circular(12.0),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                          color: FlutterFlowTheme.of(context)
                                              .primary,
                                          width: 2.0,
                                        ),
                                        borderRadius:
                                        BorderRadius.circular(12.0),
                                      ),
                                      errorBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                          color: FlutterFlowTheme.of(context)
                                              .error,
                                          width: 2.0,
                                        ),
                                        borderRadius:
                                        BorderRadius.circular(12.0),
                                      ),
                                      focusedErrorBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                          color: FlutterFlowTheme.of(context)
                                              .error,
                                          width: 2.0,
                                        ),
                                        borderRadius:
                                        BorderRadius.circular(12.0),
                                      ),
                                      filled: true,
                                      fillColor: (_model.antPerNoPatFocusNode
                                          ?.hasFocus ??
                                          false)
                                          ? FlutterFlowTheme.of(context).accent1
                                          : FlutterFlowTheme.of(context)
                                          .secondaryBackground,
                                      contentPadding:
                                      EdgeInsetsDirectional.fromSTEB(
                                          16.0, 20.0, 16.0, 20.0),
                                    ),
                                    style: FlutterFlowTheme.of(context)
                                        .bodyLarge
                                        .override(
                                      fontFamily: 'Inter',
                                      letterSpacing: 0.0,
                                    ),
                                    cursorColor:
                                    FlutterFlowTheme.of(context).primary,
                                    validator: _model
                                        .antPerNoPatTextControllerValidator
                                        .asValidator(context),
                                  ),
                                  TextFormField(
                                    controller: _model.antHeFaTextController,
                                    focusNode: _model.antHeFaFocusNode,
                                    autofocus: true,
                                    textCapitalization:
                                    TextCapitalization.words,
                                    obscureText: false,
                                    decoration: InputDecoration(
                                      labelText:
                                      'Antecedentes heredo familiares ',
                                      labelStyle: FlutterFlowTheme.of(context)
                                          .labelLarge
                                          .override(
                                        fontFamily: 'Inter',
                                        letterSpacing: 0.0,
                                      ),
                                      hintStyle: FlutterFlowTheme.of(context)
                                          .labelMedium
                                          .override(
                                        fontFamily: 'Inter',
                                        letterSpacing: 0.0,
                                      ),
                                      errorStyle: FlutterFlowTheme.of(context)
                                          .bodyMedium
                                          .override(
                                        fontFamily: 'Inter',
                                        color: FlutterFlowTheme.of(context)
                                            .error,
                                        fontSize: 12.0,
                                        letterSpacing: 0.0,
                                      ),
                                      enabledBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                          color: FlutterFlowTheme.of(context)
                                              .alternate,
                                          width: 2.0,
                                        ),
                                        borderRadius:
                                        BorderRadius.circular(12.0),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                          color: FlutterFlowTheme.of(context)
                                              .primary,
                                          width: 2.0,
                                        ),
                                        borderRadius:
                                        BorderRadius.circular(12.0),
                                      ),
                                      errorBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                          color: FlutterFlowTheme.of(context)
                                              .error,
                                          width: 2.0,
                                        ),
                                        borderRadius:
                                        BorderRadius.circular(12.0),
                                      ),
                                      focusedErrorBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                          color: FlutterFlowTheme.of(context)
                                              .error,
                                          width: 2.0,
                                        ),
                                        borderRadius:
                                        BorderRadius.circular(12.0),
                                      ),
                                      filled: true,
                                      fillColor: (_model
                                          .antHeFaFocusNode?.hasFocus ??
                                          false)
                                          ? FlutterFlowTheme.of(context).accent1
                                          : FlutterFlowTheme.of(context)
                                          .secondaryBackground,
                                      contentPadding:
                                      EdgeInsetsDirectional.fromSTEB(
                                          16.0, 20.0, 16.0, 20.0),
                                    ),
                                    style: FlutterFlowTheme.of(context)
                                        .bodyLarge
                                        .override(
                                      fontFamily: 'Inter',
                                      letterSpacing: 0.0,
                                    ),
                                    cursorColor:
                                    FlutterFlowTheme.of(context).primary,
                                    validator: _model
                                        .antHeFaTextControllerValidator
                                        .asValidator(context),
                                  ),
                                  Text(
                                    '¿Es su primera vez llenando su información en esta aplicación?',
                                    style: FlutterFlowTheme.of(context)
                                        .labelMedium
                                        .override(
                                      fontFamily: 'Inter',
                                      letterSpacing: 0.0,
                                    ),
                                  ),
                                  Align(
                                    alignment: AlignmentDirectional(0.0, 0.0),
                                    child: FlutterFlowChoiceChips(
                                      options: [
                                        ChipData('Ya lo he hecho', Icons.check),
                                        ChipData('Es mi primera vez', Icons.close),
                                      ],
                                      onChanged: (val) => setState(() {
                                        _model.eleccionUserValue = val?.firstOrNull; // Guardar la selección
                                      }),
                                      selectedChipStyle: ChipStyle(
                                        backgroundColor: FlutterFlowTheme.of(context).accent2,
                                        textStyle: FlutterFlowTheme.of(context).bodyMedium.override(
                                          fontFamily: 'Inter',
                                          color: FlutterFlowTheme.of(context).primaryText,
                                          letterSpacing: 0.0,
                                        ),
                                        iconColor: FlutterFlowTheme.of(context).primaryText,
                                        iconSize: 18.0,
                                        elevation: 0.0,
                                        borderColor: FlutterFlowTheme.of(context).secondary,
                                        borderWidth: 2.0,
                                        borderRadius: BorderRadius.circular(8.0),
                                      ),
                                      unselectedChipStyle: ChipStyle(
                                        backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
                                        textStyle: FlutterFlowTheme.of(context).bodyMedium.override(
                                          fontFamily: 'Inter',
                                          color: FlutterFlowTheme.of(context).secondaryText,
                                          letterSpacing: 0.0,
                                        ),
                                        iconColor: FlutterFlowTheme.of(context).secondaryText,
                                        iconSize: 18.0,
                                        elevation: 0.0,
                                        borderColor: FlutterFlowTheme.of(context).alternate,
                                        borderWidth: 2.0,
                                        borderRadius: BorderRadius.circular(8.0),
                                      ),
                                      chipSpacing: 12.0,
                                      rowSpacing: 12.0,
                                      multiselect: false,
                                      alignment: WrapAlignment.start,
                                      controller: _model.eleccionUserValueController ??= FormFieldController<List<String>>([]),
                                      wrapped: true,
                                    ),
                                  ),
                                ]
                                    .divide(SizedBox(height: 12.0))
                                    .addToEnd(SizedBox(height: 32.0)),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Container(
                  constraints: BoxConstraints(
                    maxWidth: 770.0,
                  ),
                  decoration: BoxDecoration(),
                  child: Padding(
                    padding:
                    EdgeInsetsDirectional.fromSTEB(16.0, 12.0, 16.0, 12.0),
                    child: FFButtonWidget(
                      onPressed: () async {

                        Map<String, dynamic> jsonData = {
                          'n': _model.nameTextController?.text ?? '',
                          'b': _model.birthTextController?.text ?? '',
                          'g': _model.choiceChipsValue ?? '',
                          'num': _model.numETextController?.text ?? '',
                          's': _model.sangreValue ?? '',
                          'a': _model.alergiasTTextController?.text ?? '',
                          'ahf': _model.antHeFaTextController.text?? '',
                          'aP': _model.antPerPatTextController?.text ?? '',
                          'aPNP': _model.antPerNoPatTextController?.text ?? '',
                          'i': _model.institutoTextController?.text ?? '',
                          'nss': _model.nssTextController?.text ?? '',
                          'job': _model.ocupacionTextController?.text ?? '',
                          'ca': _model.calleTextController?.text ?? '',
                          'co': _model.coloniaTextController?.text ?? '',
                          'ci': _model.ciudadTextController?.text ?? '',
                        };
                        String jsonString = jsonEncode(jsonData);

                        if (_model.eleccionUserValue == 'Ya lo he hecho') {
                          // Acción para la opción "Ya lo he hecho"
                          await writeToNFC(context, jsonData);
                        } else if (_model.eleccionUserValue == 'Es mi primera vez') {
                          // Acción para la opción "Es mi primera vez"
                          await writeToNFC(context, jsonData);

                          // Intentar escribir en Firestore dentro de un try-catch
                          try {
                            await PacientesRecord.collection.doc().set({
                              ...createPacientesRecordData(
                                name: _model.nameTextController.text,
                                birth: _model.birthTextController.text,
                                nume: _model.numETextController.text,
                                job: _model.ocupacionTextController.text,
                                instAfil: _model.institutoTextController.text,
                                nss: _model.nssTextController.text,
                                gener: _model.choiceChipsValue,
                                calleNum: _model.calleTextController.text,
                                colCp: _model.coloniaTextController.text,
                                city: _model.ciudadTextController.text,
                                sangre: _model.sangreValue,
                                ahf: _model.alergiasTTextController.text,
                                app: _model.antPerPatTextController.text,
                                apnp: _model.antPerNoPatTextController.text,
                                alergias: _model.alergiasTTextController.text,
                                nameMod: '',
                                numeroEdit: '',
                              ),
                              ...mapToFirestore({
                                'actualizacionDate': FieldValue.serverTimestamp(),
                              }),
                            });
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(
                                  '¡Paciente registrado con éxito!',
                                  style: TextStyle(
                                    color: FlutterFlowTheme.of(context).success,
                                  ),
                                ),
                                duration: Duration(milliseconds: 4000),
                                backgroundColor: FlutterFlowTheme.of(context).secondary,
                              ),
                            );
                          } catch (e) {
                            // Si ocurre un error, muestra un mensaje de error
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(
                                  'Error: no se pudo registrar el paciente.',
                                  style: TextStyle(
                                    color: Colors.red,
                                  ),
                                ),
                                duration: Duration(milliseconds: 4000),
                                backgroundColor: FlutterFlowTheme.of(context).secondary,
                              ),
                            );
                          }
                        }
                      },
                      text: 'Subir información',
                      options: FFButtonOptions(
                        width: double.infinity,
                        height: 48.0,
                        padding: EdgeInsetsDirectional.fromSTEB(
                            24.0, 0.0, 24.0, 0.0),
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
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}