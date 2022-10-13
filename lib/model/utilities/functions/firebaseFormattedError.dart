/// a function to format firebase error
///\
///
String getMessageFromErrorCode(error) {
  switch (error.code) {
    case "ERROR_EMAIL_ALREADY_IN_USE":
    case "account-exists-with-different-credential":
    case "email-already-in-use":
      return "Email already used. \n"
          "1. Use another email Address \n"
          "2. Go to login Page to login, or reset your pin .";
      case "ERROR_WRONG_PASSWORD":
    case "wrong-password":
      return "Wrong email/password combination.";
      
    case "ERROR_USER_NOT_FOUND":
    case "user-not-found":
      return "No user found with this email.";
      
    case "ERROR_USER_DISABLED":
    case "user-disabled":
      return "User disabled.";
      
    case "ERROR_TOO_MANY_REQUESTS":
    case "operation-not-allowed":
      return "Too many requests to log into this account.";
      
    case "ERROR_OPERATION_NOT_ALLOWED":
    case "operation-not-allowed":
      return "Server error, please try again later.";
      
    case "ERROR_INVALID_EMAIL":
    case "invalid-email":
      return "Email address is invalid.";
    case "ERROR_INVALID_EMAIL":
      return "Your email address appears to be malformed.";
      
    case "ERROR_WRONG_PASSWORD":
      return "Your password is wrong.";
      
    case "ERROR_USER_NOT_FOUND":
      return "User with this email doesn't exist.";
      
    case "ERROR_USER_DISABLED":
      return "User with this email has been disabled.";
      
    case "ERROR_TOO_MANY_REQUESTS":
      return "Too many requests. Try again later.";
      
    case "ERROR_OPERATION_NOT_ALLOWED":
      return "Signing in with Email and Password is not enabled.";
      
    default:
      return "Login failed. Please try again.";
  }
}

