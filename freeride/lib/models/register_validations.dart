class RegisterValidations {
  static bool validateEmail(String email) {
    return RegExp(
      r"^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$",
    ).hasMatch(email);
  }

  static bool isFormValid(model) {
    return model.isNameValid &&
        model.isEmailValid &&
        model.hasMinLength &&
        model.hasNumber &&
        model.hasUppercase &&
        model.passwordsMatch;
  }
}
