import 'package:flutter/material.dart';

class ValidationHelper {
  static String? dynamicValidator(String? value, List<String> validationRules, Map<String, dynamic>? options) {
  
    for (var rule in validationRules) {
      switch (rule) {
        case 'email':
          var emailResult = validateEmail(value);
          if (emailResult != null) return emailResult;
          break;
        case 'length':
          var lengthResult = validateLength('equal',value,options!['length']);
          if (lengthResult != null) return lengthResult;
          break;
        case 'minLength':
          var lengthResult = validateLength('min',value,options!['length']);
          if (lengthResult != null) return lengthResult;
          break;
        case 'maxLength':
          var lengthResult = validateLength('max',value,options!['length']);
          if (lengthResult != null) return lengthResult;
          break;
        case 'nonEmpty':
          var nonEmptyResult = validateNonEmpty(value);
          if (nonEmptyResult != null) return nonEmptyResult;
          break;
        case 'password':
          var passwordResult = validatePassword(value);
          if (passwordResult != null) return passwordResult;
          break;
        case 'numberOnly':
          var numberOnlyResult = validateNumberOnly(value);
          if (numberOnlyResult != null) return numberOnlyResult;
          break;
        case 'equal':
          var equalResult = validateEqual(value,options!['value2']);
          if (equalResult != null) return equalResult;
          break;
        // Add more cases as needed
      }
    }
    return null; // Return null if all checks pass
  }


  static String? validateEqual(String? value1, String? value2) {
    if (value1 != value2) {
        return 'The values must be equal';
    }
    return null;
  }


  static String? validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter an email';
    }
    // Simple email format check
    RegExp regex =RegExp(r'^[\w-]+(\.[\w-]+)*@([\w-]+\.)+[a-zA-Z]{2,7}$');
    if (!regex.hasMatch(value)) {
      return 'Please enter a valid email';
    }
    return null;
  }

  static String? validateLength(String? operation,String? value,num? length) {
    if (value!.length < length!) {
      return 'Please enter some text at validate length';
    }
    // Check length
    if(operation=='equal' && value.length != length){
      return 'length must be equal to ${length}';
    }
    if(operation=='min' && value.length < length ){
      return 'Length must be lower that ${length}';
    }
    if(operation=='max' && value.length > length){
      return 'Length must be greater than ${length}';
    }
  
    return null;
  }

  static String? validateNonEmpty(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter some text';
    }
    return null;
  }

  static String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter a password';
    }
    // Check length
    if (value.length < 8) {
      return 'Password must be at least 8 characters';
    }
    // Add more password validation rules as needed
    return null;
  }

  static String? validateNumberOnly(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter some numbers';
    }
    // Check if the value contains only digits
    if (!RegExp(r'^\d+$').hasMatch(value)) {
      return 'Please enter only numbers';
    }
    return null;
  }
}
