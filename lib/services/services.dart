import 'dart:convert';

import 'package:atra_mobile/models/article_model.dart';
import 'package:dio/dio.dart';
import 'package:downloads_path_provider_28/downloads_path_provider_28.dart';
import 'package:http/http.dart' as http;
import 'package:atra_mobile/models/models.dart';
import 'package:atra_mobile/shared/shared.dart';
import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'package:permission_handler/permission_handler.dart';

part 'article_services.dart';
part 'auth_services.dart';
part 'document_services.dart';
part 'prosa_services.dart';
part 'download_services.dart';
