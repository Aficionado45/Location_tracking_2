import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:contacts_service/contacts_service.dart';

const iOSLocalizedLabels = false;

class ContactPage extends StatefulWidget {
  const ContactPage({Key key}) : super(key: key);

  @override
  _ContactPageState createState() => _ContactPageState();
}

class _ContactPageState extends State<ContactPage> {
  Iterable<Contact> _contacts;

  @override
  void initState() {
    getContacts();
    super.initState();
  }

//Getting all contact
  Future<void> getContacts() async {
    final Iterable<Contact> contacts = await ContactsService.getContacts();
    setState(() {
      _contacts = contacts.where((element) => element.phones.toList().length > 0);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: (Text('${_contacts?.length ?? 0} Contacts')),
      ),
      body: _contacts != null
          ? Scrollbar(

            child: ListView.builder(
                itemCount: _contacts?.length ?? 0,
                itemBuilder: (BuildContext context, int index) {
                  Contact contact = _contacts?.elementAt(index);
                  return
                     Card(
                      child: InkWell(
                        onTap: (){},
                        child: ListTile(
                          contentPadding:
                              const EdgeInsets.symmetric(vertical: 2, horizontal: 18),
                          leading: (contact.avatar != null && contact.avatar.isNotEmpty)
                              ? CircleAvatar(
                                  backgroundImage: MemoryImage(contact.avatar),
                                )
                              : CircleAvatar(
                                  child: Text(
                                    contact.initials(),
                                  ),
                                  backgroundColor: Theme.of(context).accentColor,
                                ),
                          title: Text(contact.displayName ?? ''),
                          subtitle:
                              Text(contact.phones.toList().length > 0
                              ? contact.phones.toList()[0].value : ''),
                        ),
                      ),
                     );
                },
              ),
          )
          : Center(
              child: const CircularProgressIndicator(),
            ),
    );
  }
}
