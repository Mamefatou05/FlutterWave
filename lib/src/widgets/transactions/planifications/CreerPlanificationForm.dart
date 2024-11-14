import 'package:SenCash/src/models/PlanificationTransfertModel.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CreerPlanificationForm extends StatefulWidget {
  final Function(PlanificationTransfert) onSubmit;

  CreerPlanificationForm({required this.onSubmit});

  @override
  _CreerPlanificationFormState createState() => _CreerPlanificationFormState();
}

class _CreerPlanificationFormState extends State<CreerPlanificationForm> {
  final _formKey = GlobalKey<FormState>();
  final _destinataireController = TextEditingController();
  final _montantController = TextEditingController();
  String _periodicite = 'JOURNALIER';
  TimeOfDay _heureExecution = TimeOfDay.now();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: ListView(
        padding: EdgeInsets.all(16),
        children: [
          _buildTextField(_destinataireController, 'Numéro du destinataire', Icons.phone),
          SizedBox(height: 16),
          _buildTextField(_montantController, 'Montant', Icons.money, keyboardType: TextInputType.number),
          SizedBox(height: 16),
          _buildPeriodiciteDropdown(),
          SizedBox(height: 16),
          _buildHeureExecutionPicker(context),
          SizedBox(height: 24),
          ElevatedButton(
            onPressed: _onSubmit,
            child: Text('Planifier'),
          ),
        ],
      ),
    );
  }

  Widget _buildTextField(TextEditingController controller, String label, IconData icon, {TextInputType keyboardType = TextInputType.text}) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(icon),
      ),
      keyboardType: keyboardType,
      validator: (value) => value?.isEmpty ?? true ? 'Champ requis' : null,
    );
  }

  Widget _buildPeriodiciteDropdown() {
    return DropdownButtonFormField<String>(
      value: _periodicite,
      decoration: InputDecoration(
        labelText: 'Périodicité',
        prefixIcon: Icon(Icons.repeat),
      ),
      items: ['JOURNALIER', 'HEBDOMADAIRE', 'MENSUEL'].map((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
      onChanged: (value) {
        setState(() {
          _periodicite = value!;
        });
      },
    );
  }

  Widget _buildHeureExecutionPicker(BuildContext context) {
    return ListTile(
      leading: Icon(Icons.access_time),
      title: Text('Heure d\'exécution'),
      subtitle: Text(_heureExecution.format(context)),
      onTap: () async {
        final TimeOfDay? time = await showTimePicker(
          context: context,
          initialTime: _heureExecution,
        );
        if (time != null) {
          setState(() {
            _heureExecution = time;
          });
        }
      },
    );
  }

  void _onSubmit() {
    if (_formKey.currentState?.validate() ?? false) {
      final planification = PlanificationTransfert(
        id: 0,
        destinataireTelephone: _destinataireController.text,
        montant: double.parse(_montantController.text),
        periodicite: _periodicite,
        heureExecution: _heureExecution.format(context),
      );
      widget.onSubmit(planification);
    }
  }
}
