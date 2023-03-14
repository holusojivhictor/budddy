import 'dart:io';

import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'network_exceptions.freezed.dart';

@freezed
class NetworkExceptions with _$NetworkExceptions implements Exception {
  @pragma('vm:entry-point')
  const factory NetworkExceptions.requestCancelled() = _RequestCancelled;

  const factory NetworkExceptions.unauthorisedRequest() = _UnauthorisedRequest;

  const factory NetworkExceptions.incorrectAuth() = _IncorrectAuthRequest;

  const factory NetworkExceptions.invalidRequest() = _InvalidRequest;

  const factory NetworkExceptions.badRequest() = _BadRequest;

  const factory NetworkExceptions.notFound(String reason) = _NotFound;

  const factory NetworkExceptions.methodNotAllowed() = _MethodNotAllowed;

  const factory NetworkExceptions.notAcceptable() = _NotAcceptable;

  const factory NetworkExceptions.requestTimeout() = _RequestTimeout;

  const factory NetworkExceptions.sendTimeout() = _SendTimeout;

  const factory NetworkExceptions.conflict() = _Conflict;

  const factory NetworkExceptions.internalServerError() = _InternalServerError;

  const factory NetworkExceptions.notImplemented() = _NotImplemented;

  const factory NetworkExceptions.serviceUnavailable() = _ServiceUnavailable;

  const factory NetworkExceptions.noInternetConnection() = _NoInternetConnection;

  const factory NetworkExceptions.formatException() = _FormatException;

  const factory NetworkExceptions.unableToProcess() = _UnableToProcess;

  const factory NetworkExceptions.defaultError(String error) = _DefaultError;

  const factory NetworkExceptions.unexpectedError() = _UnexpectedError;

  const factory NetworkExceptions.userNotFound() = _UserNotFound;

  const factory NetworkExceptions.wrongPassword() = _WrongPassword;

  const factory NetworkExceptions.weakPassword() = _WeakPassword;

  const factory NetworkExceptions.existingEmail() = _ExistingEmail;

  static NetworkExceptions getException(error) {
    if (error is Exception) {
      try {
        NetworkExceptions networkExceptions;
        if (error is DioError) {
          switch (error.type) {
            case DioErrorType.cancel:
              networkExceptions = const NetworkExceptions.requestCancelled();
              break;
            case DioErrorType.receiveTimeout:
              networkExceptions = const NetworkExceptions.sendTimeout();
              break;
            case DioErrorType.sendTimeout:
              networkExceptions = const NetworkExceptions.sendTimeout();
              break;
            case DioErrorType.connectionTimeout:
              networkExceptions = const NetworkExceptions.requestTimeout();
              break;
            case DioErrorType.badCertificate:
              networkExceptions = const NetworkExceptions.defaultError('Bad certificate');
              break;
            case DioErrorType.badResponse:
              switch (error.response!.statusCode) {
                case 400:
                  networkExceptions = const NetworkExceptions.invalidRequest();
                  break;
                case 401:
                  networkExceptions = const NetworkExceptions.incorrectAuth();
                  break;
                case 403:
                  networkExceptions = const NetworkExceptions.unauthorisedRequest();
                  break;
                case 404:
                  networkExceptions = const NetworkExceptions.notFound('Not found');
                  break;
                case 409:
                  networkExceptions = const NetworkExceptions.conflict();
                  break;
                case 408:
                  networkExceptions = const NetworkExceptions.requestTimeout();
                  break;
                case 500:
                  networkExceptions = const NetworkExceptions.internalServerError();
                  break;
                case 503:
                  networkExceptions = const NetworkExceptions.serviceUnavailable();
                  break;
                default:
                  var responseCode = error.response!.statusCode;
                  networkExceptions = NetworkExceptions.defaultError(
                    'Received invalid status code: $responseCode',
                  );
              }
              break;
            case DioErrorType.connectionError:
              networkExceptions = const NetworkExceptions.noInternetConnection();
              break;
            case DioErrorType.unknown:
              networkExceptions = const NetworkExceptions.noInternetConnection();
              break;
          }
        } else if (error is SocketException) {
          networkExceptions = const NetworkExceptions.noInternetConnection();
        } else if (error is HttpException) {
          networkExceptions = const NetworkExceptions.notFound('Resource not found.');
        } else if (error is FirebaseAuthException) {
          networkExceptions = const NetworkExceptions.noInternetConnection();
          switch (error.code) {
            case 'wrong-password':
              networkExceptions = const NetworkExceptions.wrongPassword();
              break;
            case 'invalid-email':
              networkExceptions = const NetworkExceptions.defaultError('Invalid email provided.');
              break;
            case 'user-disabled':
              networkExceptions = const NetworkExceptions.defaultError('User has been disabled.');
              break;
            case 'user-not-found':
              networkExceptions = const NetworkExceptions.userNotFound();
              break;
            case 'email-already-in-use':
              networkExceptions = const NetworkExceptions.existingEmail();
              break;
            case 'operation-not-allowed':
              networkExceptions = const NetworkExceptions.serviceUnavailable();
              break;
            case 'weak-password':
              networkExceptions = const NetworkExceptions.weakPassword();
              break;
            case 'provider-already-linked':
              networkExceptions = const NetworkExceptions.defaultError('Provider already linked to user.');
              break;
            case 'invalid-credential':
              networkExceptions = const NetworkExceptions.defaultError('Invalid credentials.');
              break;
            case 'credential-already-in-use':
              networkExceptions = const NetworkExceptions.defaultError('Credential linked to existing user.');
              break;
            case 'too-many-requests':
              networkExceptions = const NetworkExceptions.defaultError('Too many requests.');
              break;
            case 'expired-action-code':
              networkExceptions = const NetworkExceptions.defaultError('Code has expired.');
              break;
            case 'invalid-action-code':
              networkExceptions = const NetworkExceptions.defaultError('Invalid code provided.');
              break;
            case 'invalid-verification-code':
              networkExceptions = const NetworkExceptions.defaultError('Invalid code provided.');
              break;
            case 'session-expired':
              networkExceptions = const NetworkExceptions.defaultError('Session expired');
              break;
          }
        } else {
          networkExceptions = const NetworkExceptions.unexpectedError();
        }
        return networkExceptions;
      } on FormatException catch (_) {
        return const NetworkExceptions.formatException();
      } on PlatformException catch (e) {
        NetworkExceptions networkExceptions;
        switch (e.code) {
          case 'sign_in_canceled':
            networkExceptions = const NetworkExceptions.defaultError('Sign in cancelled');
            break;
          case 'network_error':
            networkExceptions = const NetworkExceptions.noInternetConnection();
            break;
          case 'sign_in_failed':
            networkExceptions = const NetworkExceptions.defaultError('Sign in failed');
            break;
          default:
            networkExceptions = NetworkExceptions.defaultError(e.message ?? 'Unexpected error occurred.');
            break;
        }
        return networkExceptions;
      } catch (_) {
        return const NetworkExceptions.unexpectedError();
      }
    } else {
      if (error.toString().contains("is not a subtype of")) {
        return const NetworkExceptions.unableToProcess();
      } else {
        return const NetworkExceptions.unexpectedError();
      }
    }
  }

  static String getErrorMessage(NetworkExceptions customExceptions) {
    var errorMessage = "";
    customExceptions.when(notImplemented: () {
      errorMessage = "Not Implemented.";
    }, requestCancelled: () {
      errorMessage = "Request Cancelled.";
    }, internalServerError: () {
      errorMessage = "Internal Server Error.";
    }, notFound: (String reason) {
      errorMessage = reason;
    }, serviceUnavailable: () {
      errorMessage = "Service unavailable.";
    }, methodNotAllowed: () {
      errorMessage = "Method not Allowed.";
    }, badRequest: () {
      errorMessage = "Bad request.";
    }, unauthorisedRequest: () {
      errorMessage = "Unauthorised request.";
    }, unexpectedError: () {
      errorMessage = "Unexpected error occurred.";
    }, requestTimeout: () {
      errorMessage = "Connection request timeout.";
    }, noInternetConnection: () {
      errorMessage = "Check your internet connection.";
    }, conflict: () {
      errorMessage = "Error due to a conflict.";
    }, sendTimeout: () {
      errorMessage = "Send timeout in connection with API server.";
    }, unableToProcess: () {
      errorMessage = "Unable to process the data.";
    }, defaultError: (String error) {
      errorMessage = error;
    }, formatException: () {
      errorMessage = "Unexpected error occurred.";
    }, notAcceptable: () {
      errorMessage = "Not acceptable.";
    }, incorrectAuth: () {
      errorMessage = "Unauthorised: Invalid login credentials.";
    }, invalidRequest: () {
      errorMessage = "Invalid details provided.";
    }, userNotFound: () {
      errorMessage = "No user found for this email.";
    }, weakPassword: () {
      errorMessage = "The password provided is too weak.";
    }, wrongPassword: () {
      errorMessage = "Wrong email or password provided.";
    }, existingEmail: () {
      errorMessage = "An account already exists for that email.";
    },
    );
    return errorMessage;
  }
}
