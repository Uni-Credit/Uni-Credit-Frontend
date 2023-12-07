

/*

import 'package:auto_route/annotations.dart';
import 'package:dev_presenting/views/about/roulette_members_view.dart';
import 'package:dev_presenting/views/about/team_member.dart';
import 'package:dev_presenting/views/about/team_member_information.dart';
import 'package:dev_presenting/views/about/team_member_listing.dart';
import 'package:dev_presenting/views/app_flow/PageInFlow.dart';
import 'package:dev_presenting/views/app_flow/flow_container.dart';
import 'package:dev_presenting/views/app_flow/getter_flow.dart';
import 'package:dev_presenting/views/app_flow/list_app_flow.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:common_extensions/extensions/ui/for_build_context.dart';
import 'package:framework/shared_widgets/base_template/go_back_button.dart';
import 'package:flexible_structures/widgets/base_templates/template_scaffold.dart';
import 'package:framework/shared_widgets/graphical_item/app_logo.dart';
import 'package:flexible_structures/widgets/responsive/item_sizes.dart';
import 'package:framework/shared_widgets/listing/multi_child_scroll_view.dart';
import 'package:framework/shared_widgets/widgets/highlighted_text.dart';
import 'package:uni_credit/shared_widgets/title_widget.dart';
import 'package:timelineview/timelineview.dart';
import 'package:uni_credit/shared_widgets/furg_logo.dart';
import 'package:uni_credit/theme/theme_colors.dart';
import 'package:uni_credit/views/about_page/about_presentation.dart';

@RoutePage()
class AboutPage extends StatefulWidget {
  const AboutPage({super.key});

  @override
  State<AboutPage> createState() => _AboutPageState();
}

class _AboutPageState extends State<AboutPage> {

  TeamMember? teamMember;

  ValueNotifier<int> selectedIndex = ValueNotifier(0);


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    selectedIndex.addListener(() {
      setState(() {

      });
    });
  }

  @override
  Widget build(BuildContext context) {

    List<TeamMember> teamMembers = [
      TeamMember(name: 'Gabriel Arantes',
          memberImage: Image.asset(''), linkedinUrl: '',
      description: 'Design',
      ),
     /**/ TeamMember(name: 'Emanuel Costa',
          memberImage: Image.asset(''), linkedinUrl: '',
      description: 'Backend',
      ),
      TeamMember(name: 'Jadson Almeida',
          memberImage: Image.asset(''), linkedinUrl: '',
      description: 'Backend',
      ), TeamMember(name: 'Yan Lukas',
          memberImage: Image.asset(''), linkedinUrl: '',
      description: 'Backend',
      ),TeamMember(name: 'Emily Salum',
          memberImage: Image.asset(''), linkedinUrl: '',
      description: 'Frontend',
        githubinUrl: 'https://github.com/emilymarquessalum'
      ),
    ];


    ;

    return TemplateScaffold(
      navbarConfig: NavbarConfiguration.empty(),
      appbarConfig: AppbarConfiguration.empty(),
      useDefaultPadding: false,
      footer: [
        AboutPresentationFooter(selectedIndex: selectedIndex,
        destinations: [
          NavigationDestination(icon: Icon(Icons.people,
          color: Colors.white70,), label: ''),
          NavigationDestination(icon: Icon(Icons.info_outline,
            color: Colors.white70,), label: ''),
        ]),

      ],
      body: AboutPresentationBody(
        body: Padding(
          padding: const EdgeInsets.only(top: 8.0),
          child: ProjectLogos(),
        ), index: selectedIndex,
        listWidgets: [
          Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 32.0),
                child: Column(
                  children: [
                    AboutIdea(),
                  ],
                ),
              ),
              RouletteMembersView(teamMembers: teamMembers,
                  contrastColor:
                  ThemeColors.getConstrastToBackground()
              ),
            ],
          ),

          Column(
            children: [
              AboutProject(),
              Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: FlowScreen(
                  cellSize: Size(80,80),
                  flowDecoration: FlowDecoration.simpleDarkMode()
                      .copyWith(boxStrokeColor: ThemeColors.getSpecialColor())
                  ,
                  flowGenerator:
                  ListAppFlow(
                      pages: [
                        PageInFlow(name: 'Login',
                            children: [
                              PageInFlow(
                                  name: 'Registro'
                              ),PageInFlow(
                                  name: 'Dashboard'
                              ),
                            ]
                        ),
                        PageInFlow(name: 'Registro',
                            children: [
                            ]),
                        PageInFlow(name: 'Dashboard',
                            children:[
                              PageInFlow(name: 'Fazer transação'),
                              PageInFlow(name: 'Histórico'),

                            ]
                        ),

                        PageInFlow(name: 'Fazer transação'),
                        PageInFlow(name: 'Histórico'),
                      ]
                  ),

                ),
              ),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Quer ver mais detalhes? '),
                  HighlightedText(onPressed: (){},
                    display: 'Acesse aqui',
                    itemSize: ItemSize.small,
                    topPadding: 0,
                  ),
                ],
              )

            ],
          ),
        ],

      ),
    );
  }
}

class ProjectLogos extends StatelessWidget {
  const ProjectLogos({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [

        FurgLogo(),
        AppLogo(itemSize: ItemSize.smallish,),
      ],
    );
  }
}

class ProjectProgressTimeline extends StatelessWidget {
  const ProjectProgressTimeline({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return TimelineView(
         //      showLabels: false, // weather to show lables at bottom or not default (true)
      circleRadius: 15.0, // radius of the circle ignored if selected and unSelectedWidgets are provided
      lineHeight: 2.0, // Height of line will be ignored if lineWidget is provided

      labelWidgets: <Widget>[
        for(String objective in ['Idealização', 'MVP',
        'Gerar Visibilidade',
          'Viabilizar',
          'Implementação'
        ])
          Text(objective)
      ], activeIndex: 1, // list of items
    );
  }
}


class AboutPrinciples extends StatelessWidget {
  const AboutPrinciples({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TitleWidget(title: 'PRINCÍPIOS'),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Chip(label: Text(
                true ? 'Segurança' :
                'Segurança para o Estudante')),
            Chip(label: Text(
                true ? 'Agilidade' :
                'Agilidade de Pagamento')),  Chip(label: Text(
                 'Autonomia'  )),
            //Chip(label: Text('Comunidade Expansiva')),

          ],
        ),
      ],
    );
  }
}

class AboutIdea extends StatelessWidget {
  const AboutIdea({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 24.0),
          child: TitleWidget(title: 'SOBRE A ÍDEIA'),
        ),

        Padding(
          padding: const EdgeInsets.all(8.0),
          child: RichText(
            text: TextSpan(
              children: [
                TextSpan(
                    text: 'Observamos limitações fazendo transações em nossa universidade',
                  style: Theme.of(context).textTheme.labelSmall?.copyWith
                    (fontSize: 12)
                ),
                TextSpan(
                  text:  '\n\n'
                      'Os tipos de pagamentos nos restaurantes'
                      ' são disponibilizados pelas empresas responsáveis.'
                      ' Durante algum tempo uma delas não aceitava '
                      'cartão, e além disso o pagamento feito na hora'
                      ' tornava o processo mais lento! \n',
                  style: Theme.of(context).textTheme.bodySmall
                ),
                TextSpan(
                  text: 'Trazemos como solução um sistema de controle de créditos que '
                      'tornaria-se vinculado ao sistema da universidade, e '
                      'permitiria pagamento automático e seguro, ',
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: Color(0xfffbf3f3),
                    fontSize: 13
                  )
                )
              ]
            ),
          ),
        ),
      ],
    );
  }
}

class AboutProject extends StatelessWidget {
  const AboutProject({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TitleWidget(title: 'SOBRE O PROJETO', useSymmetricalPadding: true,),

        RichText(
          textAlign: TextAlign.center,
          text: TextSpan(

            children: [
              TextSpan(
                text: 'Iniciado em 05/2023, como um projeto de Integração Curricular.\n'
              ),   TextSpan(
                text: 'Feito com Flutter, NodeJS e MySQL.',
              ),



            ],
            style: Theme.of(context).textTheme.bodySmall
          ),
        ),
      ],
    );
  }
}*/
