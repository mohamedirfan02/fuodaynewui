

class AppValidators {
  // Name Validator
  static String? validateName(
    String? value, {
    String emptyMessage = 'Name is required',
    String minLengthMessage = 'Name must be at least 2 characters',
  }) {
    if (value == null || value.trim().isEmpty) {
      return emptyMessage;
    }
    if (value.trim().length < 2) {
      return minLengthMessage;
    }
    return null;
  }

  static String? validatePhoneNumber(
      String? value, {
        String emptyMessage = 'Phone number is required',
        String invalidMessage = 'Enter a valid phone number',
      }) {
    if (value == null || value.trim().isEmpty) {
      return emptyMessage;
    }

    // Validates 10-digit numbers (Indian mobile numbers)
    final phoneRegex = RegExp(r'^[6-9]\d{9}$');
    if (!phoneRegex.hasMatch(value.trim())) {
      return invalidMessage;
    }

    return null;
  }


  // Simple Text Validator
  static String? validateText(
    String? value, {
    String emptyMessage = 'This field is required',
  }) {
    if (value == null || value.trim().isEmpty) {
      return emptyMessage;
    }
    return null;
  }

  // Numeric Validator for "Number of Years" with custom error message
  static String? validateNumberOfYears(
    String? value, {
    String emptyMessage = 'Number of years is required',
    String invalidMessage = 'Only numeric values are allowed',
    String negativeMessage = 'Number of years cannot be negative',
  }) {
    if (value == null || value.trim().isEmpty) {
      return emptyMessage;
    }
    final number = int.tryParse(value.trim());
    if (number == null) {
      return invalidMessage;
    }
    if (number < 0) {
      return negativeMessage;
    }
    return null;
  }

  // Full DOB Validator
  static String? validateFullDOB(
    String? value, {
    String invalidMessage = 'Enter a valid date of birth',
  }) {
    if (value == null || value.trim().isEmpty) {
      return invalidMessage;
    }
    return null;
  }
}
