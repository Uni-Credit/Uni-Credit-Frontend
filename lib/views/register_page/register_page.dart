



import 'package:auto_route/annotations.dart';
import 'package:flexible_structures/widgets/base_templates/go_back_button.dart';
import 'package:flexible_structures/widgets/base_templates/template_scaffold.dart';
import 'package:flutter/cupertino.dart';
import 'package:form_components/form_components/validation_form_controller.dart';
import 'package:uni_credit/views/register_page/register_body.dart';




@RoutePage(name: 'register')
class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  FormValidationController formController = FormValidationController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    formController.onValidationChange((isValid) {
      setState(() {

      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return TemplateScaffold(

        navbarConfig: //true ? NavbarConfiguration.empty():
             NavbarConfiguration(
          navbar: GoBackButton(),
               usesDefaultNavbar: false,
               useDefaultPadding: false,
               useDefaultBackgroundPadding: false,
          navbarHeight: 40,
               navigatorAsBackground: true
        ),
       // useDefaultPadding: false,
        appbarConfig: AppbarConfiguration.empty(),
        body: RegisterBody(
      formController: formController,
    ));
  }
}
