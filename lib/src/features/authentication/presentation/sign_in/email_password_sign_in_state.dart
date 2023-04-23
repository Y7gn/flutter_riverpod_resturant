import 'package:ecommerceriverpod/src/features/authentication/presentation/sign_in/string_vaidators.dart';

enum EmailPasswordSignInFormType { signIn, register }

mixin EmailPasswordValidators {
  final StringValidator emailSubmtValidator = EmailSubmitRegexValidator();
  final StringValidator passwordRegisterSubmitValidator =
      MinLengthStringValidator(8);
  final StringValidator passwordSignInSubmitValidator =
      NonEmptyStringValidator();
}

class EmailPasswordSignInState with EmailPasswordValidators {
  EmailPasswordSignInState({
    this.formType = EmailPasswordSignInFormType.signIn,
    this.isLoading = false,
  });
  final EmailPasswordSignInFormType formType;
  final bool isLoading;
}
