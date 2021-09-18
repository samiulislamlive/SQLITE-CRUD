import 'package:flutter/material.dart';

import 'db_helper.dart';
import 'employee.dart';


class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late Future<List<Employee>> employees;
  TextEditingController controller = TextEditingController();
  late String name;
  late int curUserId;

  final formKey = new GlobalKey<FormState>();
  var dbHelper;
  late bool isUpdating;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    dbHelper = DBHelper();
    isUpdating = false;
  }

  refreshList(){
    setState(() {
      employees = dbHelper.getEmployees();
    });

  }

  form(){
    return Form(
      key: formKey,
      child: Padding(
        padding: EdgeInsets.all(15.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          verticalDirection: VerticalDirection.down,
          children: <Widget>[
            TextFormField(
              controller: controller,
              keyboardType: TextInputType.text,
              decoration: InputDecoration(
                labelText: 'Just a field'
              ),
              validator: (val)=> val!.length == 0? 'Write something to save' :null,
              onSaved: (val)=> name = val!,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                TextButton(onPressed: validate,
                    child: Text(isUpdating ? 'UPDATE' : 'ADD'),
                ),
                TextButton(onPressed: (){
                  setState(() {
                    isUpdating = false;
                  });
                },
                  child: Text('CANCEL'),
                )
              ],
            )
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
