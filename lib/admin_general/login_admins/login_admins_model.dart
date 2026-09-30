import '/auth/firebase_auth/auth_util.dart';
import '/flutter_flow/flutter_flow_animations.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'dart:math';
import 'login_admins_widget.dart' show LoginAdminsWidget;
import 'package:easy_debounce/easy_debounce.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class LoginAdminsModel extends FlutterFlowModel<LoginAdminsWidget> {
  ///  State fields for stateful widgets in this page.

  final formKey = GlobalKey<FormState>();
  // State field(s) for emailTf widget.
  FocusNode? emailTfFocusNode;
  TextEditingController? emailTfTextController;
  String? Function(BuildContext, String?)? emailTfTextControllerValidator;
  String? _emailTfTextControllerValidator(BuildContext context, String? val) {
    if (val == null || val.isEmpty) {
      return 'Ingrese su nombre de administrador';
    }

    if (!RegExp(kTextValidatorEmailRegex).hasMatch(val)) {
      return 'Ingrese un Email Valido';
    }
    return null;
  }

  // State field(s) for contra widget.
  FocusNode? contraFocusNode;
  TextEditingController? contraTextController;
  late bool contraVisibility;
  String? Function(BuildContext, String?)? contraTextControllerValidator;
  String? _contraTextControllerValidator(BuildContext context, String? val) {
    if (val == null || val.isEmpty) {
      return 'Ingrese su contraseña';
    }

    return null;
  }

  @override
  void initState(BuildContext context) {
    emailTfTextControllerValidator = _emailTfTextControllerValidator;
    contraVisibility = false;
    contraTextControllerValidator = _contraTextControllerValidator;
  }

  @override
  void dispose() {
    emailTfFocusNode?.dispose();
    emailTfTextController?.dispose();

    contraFocusNode?.dispose();
    contraTextController?.dispose();
  }
}
