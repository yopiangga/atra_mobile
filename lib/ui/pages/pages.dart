import 'dart:convert';
import 'dart:io';

import 'package:another_flushbar/flushbar.dart';
import 'package:atra_mobile/methods/methods.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:provider/provider.dart';
import 'package:atra_mobile/models/article_model.dart';
import 'package:atra_mobile/models/models.dart';
import 'package:atra_mobile/providers/providers.dart';
import 'package:atra_mobile/services/services.dart';
import 'package:atra_mobile/shared/shared.dart';
import 'package:atra_mobile/ui/widgets/flushbar_widget.dart';
import 'package:atra_mobile/ui/widgets/widgets.dart';
import 'package:intl/intl.dart';
import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:google_mlkit_image_labeling/google_mlkit_image_labeling.dart'
    as imageLabelling;

part 'start_page.dart';
part 'article_detail_page.dart';
part 'dahsboard_page.dart';
part 'document_detail_page.dart';
part 'document_page.dart';
part 'documents_page.dart';
part 'main_page.dart';
part 'sign_in_page.dart';
part 'sign_up_page.dart';
part 'image_detection_page.dart';
