import 'package:flutter/material.dart';
import 'package:nosso_primeiro_projeto/data/task_inherited.dart';

class FormScreen extends StatefulWidget {
  const FormScreen({Key? key, required this.taskContext}) : super(key: key);

  final BuildContext taskContext;

  @override
  State<FormScreen> createState() => _FormScreenState();
}

class _FormScreenState extends State<FormScreen> {
  TextEditingController nameController = TextEditingController();
  TextEditingController difficultyController = TextEditingController();
  TextEditingController imageController = TextEditingController();

  final _formKey = GlobalKey<FormState>();   // vai ficar de olho no estado do formulário (para fazer a validação funcionar)
  //recebe uma chave global do tipo estado de formulário, então ela vai ficar de olho no estado do nosso formulário. Tudo que está dentro do Form que seja um validador de formulário, ela vai estar de olho
  
  bool valueValidator(String? value) {   // para verificar se os valores inseridos no formulário são válidos
    if(value != null && value.isEmpty){
      return true;
    }
    return false;
  }

  bool difficultyValidator(String? value) {   //validador de dificuldade
    if(value != null && value.isEmpty){
      if (int.parse(value) > 5 || 
          int.parse(value) < 1) {
            return true;
      }
    }
    return false;
  }       

  @override
  Widget build(BuildContext context) {
    return Form(  // esse widget tem o poder de verificar as validações que ocorrem no TextFormField
      key: _formKey,  // vai ficar de olho no estado do formulário
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Nova Tarefa'),
        ),
        body: Center(
          child: SingleChildScrollView(
            child: Container(
              height: 650,
              width: 375,
              decoration: BoxDecoration(
                color: Colors.black12,
                borderRadius: BorderRadius.circular(10),
                border: Border.all(width: 3),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      validator: (String? value) {
                        if (valueValidator(value)) {
                          return 'Insira o nome da tarefa';
                        }
                        return null;
                      },
                      controller: nameController,
                      textAlign: TextAlign.center,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: 'Nome',
                        fillColor: Colors.white70,
                        filled: true,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      validator: (value) {
                        if (difficultyValidator(value)) {
                          return 'Insira uma Dificuldade de valor entre 1 e 5';
                        }
                        return null;
                      },
                      keyboardType: TextInputType.number,
                      controller: difficultyController,
                      textAlign: TextAlign.center,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: 'Dificuldade',
                        fillColor: Colors.white70,
                        filled: true,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      onChanged: (text){  //  a informação do formulário mudou e o setState avisou para o StatefulWidget que foi alterado e ele “rebuildou” a tela, mostrando a imagem
                        setState(() {

                        });
                      },
                      validator: (value) {
                        if (valueValidator(value)) {
                          return 'insira uma url de imagem';
                        }
                        return null;
                      },
                      keyboardType: TextInputType.url,
                      controller: imageController,
                      textAlign: TextAlign.center,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: 'Imagem',
                        fillColor: Colors.white70,
                        filled: true,
                      ),
                    ),
                  ),
                  Container(
                    height: 100,
                    width: 72,
                    decoration: BoxDecoration(
                      color: Colors.blue,
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(width: 2, color: Colors.blue),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Image.network(
                        imageController.text,
                        errorBuilder: (BuildContext context,Object exception,StackTrace? stackTrace){ // função que constrói uma saída para caso a imagem seja inválida (erro na hora de carregar a imagem)
                          //o context indica o local onde o erro está acontecendo
                          return Image.asset('assets/images/nophoto.png'); //imagem mostrada caso o erro ocorra
                        },
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        // print(nameController.text);
                        // print(difficultyController.text);
                        // print(imageController.text);
                        TaskInherited.of(widget.taskContext).newTask(
                          nameController.text, 
                          imageController.text, 
                          int.parse(difficultyController.text
                        ));
                        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text(
                          "Criando nova tarefa..."
                        ),),);
                        Navigator.pop(context);
                      }
                    },
                    child: const Text('Adicionar!'),
                  ),
                ],
              ),
          )
          ),
        ),
    )
    );
  }
}
