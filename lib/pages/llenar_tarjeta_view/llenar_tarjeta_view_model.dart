import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/flutter_flow/flutter_flow_choice_chips.dart';
import '/flutter_flow/flutter_flow_drop_down.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/flutter_flow/form_field_controller.dart';
import 'llenar_tarjeta_view_widget.dart' show LlenarTarjetaViewWidget;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:provider/provider.dart';

class LlenarTarjetaViewModel extends FlutterFlowModel<LlenarTarjetaViewWidget> {
  ///  State fields for stateful widgets in this page.

  final formKey = GlobalKey<FormState>();
  // State field(s) for name widget.
  FocusNode? nameFocusNode;
  TextEditingController? nameTextController;
  String? Function(BuildContext, String?)? nameTextControllerValidator;
  String? _nameTextControllerValidator(BuildContext context, String? val) {
    if (val == null || val.isEmpty) {
      return 'Por favor, ingrese su nombre completo';
    }

    return null;
  }

  // State field(s) for birth widget.
  FocusNode? birthFocusNode;
  TextEditingController? birthTextController;
  final birthMask = MaskTextInputFormatter(mask: '##/##/####');
  String? Function(BuildContext, String?)? birthTextControllerValidator;
  String? _birthTextControllerValidator(BuildContext context, String? val) {
    if (val == null || val.isEmpty) {
      return 'Por favor, Ingrese su fecha de nacimiento';
    }

    return null;
  }

  // State field(s) for numE widget.
  FocusNode? numEFocusNode;
  TextEditingController? numETextController;
  final numEMask = MaskTextInputFormatter(mask: '(###) ###-####');
  String? Function(BuildContext, String?)? numETextControllerValidator;
  String? _numETextControllerValidator(BuildContext context, String? val) {
    if (val == null || val.isEmpty) {
      return 'Por favor, Ingrese su número de emergencia';
    }

    return null;
  }

  // State field(s) for ocupacion widget.
  FocusNode? ocupacionFocusNode;
  TextEditingController? ocupacionTextController;
  String? Function(BuildContext, String?)? ocupacionTextControllerValidator;
  String? _ocupacionTextControllerValidator(BuildContext context, String? val) {
    if (val == null || val.isEmpty) {
      return 'Por favor, Ingrese su ocupación';
    }

    return null;
  }

  // State field(s) for instituto widget.
  FocusNode? institutoFocusNode;
  TextEditingController? institutoTextController;
  String? Function(BuildContext, String?)? institutoTextControllerValidator;
  String? _institutoTextControllerValidator(BuildContext context, String? val) {
    if (val == null || val.isEmpty) {
      return 'Por favor, Ingrese su institución';
    }

    return null;
  }

  // State field(s) for nss widget.
  FocusNode? nssFocusNode;
  TextEditingController? nssTextController;
  String? Function(BuildContext, String?)? nssTextControllerValidator;
  String? _nssTextControllerValidator(BuildContext context, String? val) {
    if (val == null || val.isEmpty) {
      return 'Por favor, Ingrese su número de identificación';
    }

    return null;
  }

  // State field(s) for ChoiceChips widget.
  FormFieldController<List<String>>? choiceChipsValueController;
  String? get choiceChipsValue =>
      choiceChipsValueController?.value?.firstOrNull;
  set choiceChipsValue(String? val) =>
      choiceChipsValueController?.value = val != null ? [val] : [];
  // State field(s) for calle widget.
  FocusNode? calleFocusNode;
  TextEditingController? calleTextController;
  String? Function(BuildContext, String?)? calleTextControllerValidator;
  String? _calleTextControllerValidator(BuildContext context, String? val) {
    if (val == null || val.isEmpty) {
      return 'Por favor, ingrese su calle y número';
    }

    return null;
  }

  // State field(s) for colonia widget.
  FocusNode? coloniaFocusNode;
  TextEditingController? coloniaTextController;
  String? Function(BuildContext, String?)? coloniaTextControllerValidator;
  String? _coloniaTextControllerValidator(BuildContext context, String? val) {
    if (val == null || val.isEmpty) {
      return 'Por favor, Ingrese su colonia';
    }

    return null;
  }

  // State field(s) for ciudad widget.
  FocusNode? ciudadFocusNode;
  TextEditingController? ciudadTextController;
  String? Function(BuildContext, String?)? ciudadTextControllerValidator;
  String? _ciudadTextControllerValidator(BuildContext context, String? val) {
    if (val == null || val.isEmpty) {
      return 'Por favor, ingrese su ciudad';
    }

    return null;
  }

  // State field(s) for sangre widget.
  String? sangreValue;
  FormFieldController<String>? sangreValueController;
  // State field(s) for alergiasT widget.
  FocusNode? alergiasTFocusNode;
  TextEditingController? alergiasTTextController;
  String? Function(BuildContext, String?)? alergiasTTextControllerValidator;
  String? _alergiasTTextControllerValidator(BuildContext context, String? val) {
    if (val == null || val.isEmpty) {
      return 'Por favor, llene este campo';
    }

    return null;
  }

  // State field(s) for antPerPat widget.
  FocusNode? antPerPatFocusNode;
  TextEditingController? antPerPatTextController;
  String? Function(BuildContext, String?)? antPerPatTextControllerValidator;
  String? _antPerPatTextControllerValidator(BuildContext context, String? val) {
    if (val == null || val.isEmpty) {
      return 'Por favor, llene este campo';
    }

    return null;
  }

  // State field(s) for antPerNoPat widget.
  FocusNode? antPerNoPatFocusNode;
  TextEditingController? antPerNoPatTextController;
  String? Function(BuildContext, String?)? antPerNoPatTextControllerValidator;
  String? _antPerNoPatTextControllerValidator(
      BuildContext context, String? val) {
    if (val == null || val.isEmpty) {
      return 'Por favor, llene este campo';
    }

    return null;
  }

  // State field(s) for antHeFa widget.
  FocusNode? antHeFaFocusNode;
  TextEditingController? antHeFaTextController;
  String? Function(BuildContext, String?)? antHeFaTextControllerValidator;

  FormFieldController<List<String>>? eleccionUserValueController;
  String? get eleccionUserValue =>
      eleccionUserValueController?.value?.firstOrNull;
  set eleccionUserValue(String? val) =>
      eleccionUserValueController?.value = val != null ? [val] : [];


  @override
  void initState(BuildContext context) {
    nameTextControllerValidator = _nameTextControllerValidator;
    birthTextControllerValidator = _birthTextControllerValidator;
    numETextControllerValidator = _numETextControllerValidator;
    ocupacionTextControllerValidator = _ocupacionTextControllerValidator;
    institutoTextControllerValidator = _institutoTextControllerValidator;
    nssTextControllerValidator = _nssTextControllerValidator;
    calleTextControllerValidator = _calleTextControllerValidator;
    coloniaTextControllerValidator = _coloniaTextControllerValidator;
    ciudadTextControllerValidator = _ciudadTextControllerValidator;
    alergiasTTextControllerValidator = _alergiasTTextControllerValidator;
    antPerPatTextControllerValidator = _antPerPatTextControllerValidator;
    antPerNoPatTextControllerValidator = _antPerNoPatTextControllerValidator;
  }

  @override
  void dispose() {
    nameFocusNode?.dispose();
    nameTextController?.dispose();

    birthFocusNode?.dispose();
    birthTextController?.dispose();

    numEFocusNode?.dispose();
    numETextController?.dispose();

    ocupacionFocusNode?.dispose();
    ocupacionTextController?.dispose();

    institutoFocusNode?.dispose();
    institutoTextController?.dispose();

    nssFocusNode?.dispose();
    nssTextController?.dispose();

    calleFocusNode?.dispose();
    calleTextController?.dispose();

    coloniaFocusNode?.dispose();
    coloniaTextController?.dispose();

    ciudadFocusNode?.dispose();
    ciudadTextController?.dispose();

    alergiasTFocusNode?.dispose();
    alergiasTTextController?.dispose();

    antPerPatFocusNode?.dispose();
    antPerPatTextController?.dispose();

    antPerNoPatFocusNode?.dispose();
    antPerNoPatTextController?.dispose();

    antHeFaFocusNode?.dispose();
    antHeFaTextController?.dispose();
  }
}
