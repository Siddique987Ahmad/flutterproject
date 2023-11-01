import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

// class ListingScreen extends StatefulWidget {
//   @override
//   _ListingScreenState createState() => _ListingScreenState();
// }

// class _ListingScreenState extends State<ListingScreen> {
//   final CollectionReference companies =
//       FirebaseFirestore.instance.collection('companies');

//   String companyName = "";
//   String companyDescription = "";
//   Map<String, String> companyYears = {};

//   List<String> options = List.generate(10, (index) => "Option ${index + 1}");
//   String selectedOption = "Option 1";

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text("Listing Screen"),
//       ),
//       body: Column(
//         children: <Widget>[
//           StreamBuilder<QuerySnapshot>(
//             stream: companies.snapshots(),
//             builder: (context, snapshot) {
//               if (snapshot.hasError) {
//                 return Text("Error: ${snapshot.error}");
//               }

//               if (snapshot.connectionState == ConnectionState.waiting) {
//                 return CircularProgressIndicator();
//               }

//               return Expanded(
//                 child: ListView.builder(
//                   itemCount: snapshot.data!.docs.length,
//                   itemBuilder: (context, index) {
//                     final companyData = snapshot.data!.docs[index].data()
//                         as Map<String, dynamic>;
//                     return CompanyWidget(
//                       item: companyData,
//                       onDelete: () {
//                         _deleteCompany(snapshot.data!.docs[index].id);
//                       },
//                       onEdit: () {
//                         _showEditCompanyDialog(context, companyData,
//                             snapshot.data!.docs[index].id);
//                       },
//                     );
//                   },
//                 ),
//               );
//             },
//           ),
//           Padding(
//             padding: const EdgeInsets.all(16.0),
//             child: Align(
//               alignment: Alignment.bottomRight,
//               child: FloatingActionButton(
//                 onPressed: () {
//                   _showAddCompanyDialog(context);
//                 },
//                 child: Icon(Icons.add),
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   void _showAddCompanyDialog(BuildContext context) {
//     showDialog(
//       context: context,
//       builder: (context) {
//         return AlertDialog(
//           title: Text("Add Company"),
//           content: StatefulBuilder(
//             builder: (context, setState) {
//               return Column(
//                 mainAxisSize: MainAxisSize.min,
//                 children: <Widget>[
//                   TextField(
//                     decoration: InputDecoration(labelText: "Company Name"),
//                     onChanged: (value) {
//                       companyName = value;
//                     },
//                   ),
//                   TextField(
//                     decoration: InputDecoration(labelText: "Description"),
//                     onChanged: (value) {
//                       companyDescription = value;
//                     },
//                   ),
//                   DropdownButton<String>(
//                     value: selectedOption,
//                     items: options.map((option) {
//                       return DropdownMenuItem<String>(
//                         value: option,
//                         child: Text(option),
//                       );
//                     }).toList(),
//                     onChanged: (String? newValue) {
//                       setState(() {
//                         selectedOption = newValue ?? "";
//                       });
//                     },
//                   ),
//                   for (int year = 2023; year <= 2032; year++)
//                     if (selectedOption == "Option ${year - 2022}")
//                       Row(
//                         children: [
//                           Text(year.toString()),
//                           Expanded(
//                             child: TextField(
//                               decoration:
//                                   InputDecoration(labelText: "Year $year"),
//                               onChanged: (value) {
//                                 if (value != null) {
//                                   companyYears[year.toString()] = value;
//                                 }
//                               },
//                             ),
//                           ),
//                         ],
//                       ),
//                 ],
//               );
//             },
//           ),
//           actions: <Widget>[
//             TextButton(
//               onPressed: () {
//                 Navigator.of(context).pop();
//               },
//               child: Text("Cancel"),
//             ),
//             TextButton(
//               onPressed: () {
//                 saveDataToFirestore({
//                   "name": companyName,
//                   "description": companyDescription,
//                   "years": Map.of(companyYears),
//                 });
//                 // Clear input fields after adding
//                 companyName = "";
//                 companyDescription = "";
//                 companyYears.clear();
//                 Navigator.of(context).pop();
//               },
//               child: Text("Add"),
//             ),
//           ],
//         );
//       },
//     );
//   }

//   void _showEditCompanyDialog(
//       BuildContext context, Map<String, dynamic> company, String companyId) {
//     companyName = company["name"];
//     companyDescription = company["description"];
//     companyYears = {};

//     showDialog(
//       context: context,
//       builder: (context) {
//         return AlertDialog(
//           title: Text("Edit Company"),
//           content: StatefulBuilder(
//             builder: (context, setState) {
//               return Column(
//                 mainAxisSize: MainAxisSize.min,
//                 children: <Widget>[
//                   TextField(
//                     decoration: InputDecoration(labelText: "Company Name"),
//                     onChanged: (value) {
//                       companyName = value;
//                     },
//                     controller: TextEditingController(text: companyName),
//                   ),
//                   TextField(
//                     decoration: InputDecoration(labelText: "Description"),
//                     onChanged: (value) {
//                       companyDescription = value;
//                     },
//                     controller: TextEditingController(text: companyDescription),
//                   ),
//                   DropdownButton<String>(
//                     value: selectedOption,
//                     items: options.map((option) {
//                       return DropdownMenuItem<String>(
//                         value: option,
//                         child: Text(option),
//                       );
//                     }).toList(),
//                     onChanged: (String? newValue) {
//                       setState(() {
//                         selectedOption = newValue ?? "";
//                       });
//                     },
//                   ),
//                   for (int year = 2023; year <= 2032; year++)
//                     if (selectedOption == "Option ${year - 2022}")
//                       Row(
//                         children: [
//                           Text(year.toString()),
//                           Expanded(
//                             child: TextField(
//                               decoration:
//                                   InputDecoration(labelText: "Year $year"),
//                               onChanged: (value) {
//                                 if (value != null) {
//                                   companyYears[year.toString()] = value;
//                                 }
//                               },
//                               controller: TextEditingController(
//                                 text: companyYears[year.toString()] ?? "",
//                               ),
//                             ),
//                           ),
//                         ],
//                       ),
//                 ],
//               );
//             },
//           ),
//           actions: <Widget>[
//             TextButton(
//               onPressed: () {
//                 Navigator.of(context).pop();
//               },
//               child: Text("Cancel"),
//             ),
//             TextButton(
//               onPressed: () {
//                 updateDataInFirestore(companyId, {
//                   "name": companyName,
//                   "description": companyDescription,
//                   "years": Map.of(companyYears),
//                 });
//                 companyName = "";
//                 companyDescription = "";
//                 Navigator.of(context).pop();
//               },
//               child: Text("Save"),
//             ),
//           ],
//         );
//       },
//     );
//   }

//   Future<void> saveDataToFirestore(Map<String, dynamic> data) async {
//     await companies.add(data);
//   }

//   Future<void> updateDataInFirestore(
//       String companyId, Map<String, dynamic> data) async {
//     await companies.doc(companyId).update(data);
//   }

//   Future<void> _deleteCompany(String companyId) async {
//     await companies.doc(companyId).delete();
//   }
// }

// class CompanyWidget extends StatelessWidget {
//   final Map<String, dynamic> item;
//   final Function() onDelete;
//   final Function() onEdit;

//   CompanyWidget({
//     required this.item,
//     required this.onDelete,
//     required this.onEdit,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       margin: EdgeInsets.all(10),
//       padding: EdgeInsets.all(10),
//       decoration: BoxDecoration(
//         border: Border.all(),
//       ),
//       child: Column(
//         children: <Widget>[
//           Text("Company Name: ${item["name"] ?? ""}"),
//           Text("Description: ${item["description"] ?? ""}"),
//           Text("Years:"),
//           if (item["years"] != null) ...[
//             for (var entry in (item["years"] as Map<String, dynamic>).entries)
//               Align(
//                 alignment: Alignment.center,
//                 child: Row(
//                   children: [
//                     Text("Year: ${entry.key}"),
//                     Text("Value: ${entry.value.toString()}"),
//                   ],
//                 ),
//               ),
//           ],
//           Row(
//             mainAxisAlignment: MainAxisAlignment.end,
//             children: <Widget>[
//               TextButton(
//                 onPressed: onEdit,
//                 child: Text("Edit"),
//               ),
//               TextButton(
//                 onPressed: onDelete,
//                 child: Text("Delete"),
//               ),
//             ],
//           ),
//         ],
//       ),
//     );
//   }
// }

// class ListingScreen extends StatefulWidget {
//   @override
//   _ListingScreenState createState() => _ListingScreenState();
// }

// class _ListingScreenState extends State<ListingScreen> {
//   final CollectionReference companies =
//       FirebaseFirestore.instance.collection('companies');

//   String companyName = "";
//   String companyDescription = "";

//   List<String> options = List.generate(10, (index) => "Option ${index + 1}");
//   String selectedOption = "Option 1";

//   Map<String, String> companyYears = {};

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text("Company Listings"),
//       ),
//       body: SingleChildScrollView(
//         child: Column(
//           children: <Widget>[
//             StreamBuilder<QuerySnapshot>(
//               stream: companies.snapshots(),
//               builder: (context, snapshot) {
//                 if (snapshot.hasError) {
//                   return Text("Error: ${snapshot.error}");
//                 }

//                 if (snapshot.connectionState == ConnectionState.waiting) {
//                   return CircularProgressIndicator();
//                 }

//                 return Column(
//                   children: snapshot.data!.docs.map((doc) {
//                     final companyData = doc.data() as Map<String, dynamic>;
//                     return CompanyWidget(
//                       item: companyData,
//                       onDelete: () {
//                         _deleteCompany(doc.id);
//                       },
//                       onEdit: () {
//                         _showEditCompanyDialog(context, companyData, doc.id);
//                       },
//                     );
//                   }).toList(),
//                 );
//               },
//             ),
//             SizedBox(height: 20),
//             // Input Fields
//             Padding(
//               padding: const EdgeInsets.all(16.0),
//               child: Column(
//                 children: [
//                   TextField(
//                     decoration: InputDecoration(labelText: "Company Name"),
//                     onChanged: (value) {
//                       companyName = value;
//                     },
//                   ),
//                   TextField(
//                     decoration: InputDecoration(labelText: "Description"),
//                     onChanged: (value) {
//                       companyDescription = value;
//                     },
//                   ),
//                   DropdownButton<String>(
//                     value: selectedOption,
//                     items: options.map((option) {
//                       return DropdownMenuItem<String>(
//                         value: option,
//                         child: Text(option),
//                       );
//                     }).toList(),
//                     onChanged: (String? newValue) {
//                       setState(() {
//                         selectedOption = newValue ?? "";
//                       });
//                     },
//                   ),
//                   if (selectedOption.isNotEmpty)
//                     ListView.builder(
//                       shrinkWrap: true,
//                       physics: NeverScrollableScrollPhysics(),
//                       itemCount: 5,
//                       itemBuilder: (context, index) {
//                         final year1 = 2023 + 2 * index;
//                         final year2 = year1 + 1;
//                         return Row(
//                           children: [
//                             Expanded(
//                               child: Column(
//                                 children: [
//                                   Text(
//                                     year1.toString(),
//                                     style:
//                                         TextStyle(fontWeight: FontWeight.bold),
//                                   ),
//                                   TextField(
//                                     decoration: InputDecoration(
//                                       labelText: "Year $year1",
//                                       border: OutlineInputBorder(),
//                                       focusedBorder: OutlineInputBorder(
//                                         borderSide:
//                                             BorderSide(color: Colors.blue),
//                                       ),
//                                     ),
//                                     onChanged: (value) {
//                                       if (value != null) {
//                                         companyYears[year1.toString()] = value;
//                                       }
//                                     },
//                                     controller: TextEditingController(
//                                       text:
//                                           companyYears[year1.toString()] ?? "",
//                                     ),
//                                   ),
//                                 ],
//                               ),
//                             ),
//                             Expanded(
//                               child: Column(
//                                 children: [
//                                   Text(
//                                     year2.toString(),
//                                     style:
//                                         TextStyle(fontWeight: FontWeight.bold),
//                                   ),
//                                   TextField(
//                                     decoration: InputDecoration(
//                                       labelText: "Year $year2",
//                                       border: OutlineInputBorder(),
//                                       focusedBorder: OutlineInputBorder(
//                                         borderSide:
//                                             BorderSide(color: Colors.blue),
//                                       ),
//                                     ),
//                                     onChanged: (value) {
//                                       if (value != null) {
//                                         companyYears[year2.toString()] = value;
//                                       }
//                                     },
//                                     controller: TextEditingController(
//                                       text:
//                                           companyYears[year2.toString()] ?? "",
//                                     ),
//                                   ),
//                                 ],
//                               ),
//                             ),
//                           ],
//                         );
//                       },
//                     ),
//                   ElevatedButton(
//                     onPressed: () {
//                       _saveCompanyData();
//                     },
//                     child: Text("Add Company"),
//                   ),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   void _showEditCompanyDialog(
//       BuildContext context, Map<String, dynamic> company, String companyId) {
//     companyName = company["name"];
//     companyDescription = company["description"];
//     companyYears = {};

//     showDialog(
//       context: context,
//       builder: (context) {
//         return AlertDialog(
//           title: Text("Edit Company"),
//           content: StatefulBuilder(
//             builder: (context, setState) {
//               return Column(
//                 mainAxisSize: MainAxisSize.min,
//                 children: <Widget>[
//                   TextField(
//                     decoration: InputDecoration(labelText: "Company Name"),
//                     onChanged: (value) {
//                       companyName = value;
//                     },
//                     controller: TextEditingController(text: companyName),
//                   ),
//                   TextField(
//                     decoration: InputDecoration(labelText: "Description"),
//                     onChanged: (value) {
//                       companyDescription = value;
//                     },
//                     controller: TextEditingController(text: companyDescription),
//                   ),
//                   DropdownButton<String>(
//                     value: selectedOption,
//                     items: options.map((option) {
//                       return DropdownMenuItem<String>(
//                         value: option,
//                         child: Text(option),
//                       );
//                     }).toList(),
//                     onChanged: (String? newValue) {
//                       setState(() {
//                         selectedOption = newValue ?? "";
//                       });
//                     },
//                   ),
//                   if (selectedOption.isNotEmpty)
//                     ListView.builder(
//                       shrinkWrap: true,
//                       physics: NeverScrollableScrollPhysics(),
//                       itemCount: 5,
//                       itemBuilder: (context, index) {
//                         final year1 = 2023 + 2 * index;
//                         final year2 = year1 + 1;
//                         return Row(
//                           children: [
//                             Expanded(
//                               child: Column(
//                                 children: [
//                                   Text(
//                                     year1.toString(),
//                                     style:
//                                         TextStyle(fontWeight: FontWeight.bold),
//                                   ),
//                                   TextField(
//                                     decoration: InputDecoration(
//                                       labelText: "Year $year1",
//                                       border: OutlineInputBorder(),
//                                       focusedBorder: OutlineInputBorder(
//                                         borderSide:
//                                             BorderSide(color: Colors.blue),
//                                       ),
//                                     ),
//                                     onChanged: (value) {
//                                       if (value != null) {
//                                         companyYears[year1.toString()] = value;
//                                       }
//                                     },
//                                     controller: TextEditingController(
//                                       text:
//                                           companyYears[year1.toString()] ?? "",
//                                     ),
//                                   ),
//                                 ],
//                               ),
//                             ),
//                             Expanded(
//                               child: Column(
//                                 children: [
//                                   Text(
//                                     year2.toString(),
//                                     style:
//                                         TextStyle(fontWeight: FontWeight.bold),
//                                   ),
//                                   TextField(
//                                     decoration: InputDecoration(
//                                       labelText: "Year $year2",
//                                       border: OutlineInputBorder(),
//                                       focusedBorder: OutlineInputBorder(
//                                         borderSide:
//                                             BorderSide(color: Colors.blue),
//                                       ),
//                                     ),
//                                     onChanged: (value) {
//                                       if (value != null) {
//                                         companyYears[year2.toString()] = value;
//                                       }
//                                     },
//                                     controller: TextEditingController(
//                                       text:
//                                           companyYears[year2.toString()] ?? "",
//                                     ),
//                                   ),
//                                 ],
//                               ),
//                             ),
//                           ],
//                         );
//                       },
//                     ),
//                 ],
//               );
//             },
//           ),
//           actions: <Widget>[
//             TextButton(
//               onPressed: () {
//                 Navigator.of(context).pop();
//               },
//               child: Text("Cancel"),
//             ),
//             TextButton(
//               onPressed: () {
//                 _updateCompanyData(companyId);
//                 companyName = "";
//                 companyDescription = "";
//                 Navigator.of(context).pop();
//               },
//               child: Text("Save"),
//             ),
//           ],
//         );
//       },
//     );
//   }

//   Future<void> _saveCompanyData() async {
//     await companies.add({
//       "name": companyName,
//       "description": companyDescription,
//       "years": Map.of(companyYears),
//     });

//     // Clear input fields after adding
//     companyName = "";
//     companyDescription = "";
//     companyYears.clear();
//   }

//   Future<void> _updateCompanyData(String companyId) async {
//     await companies.doc(companyId).update({
//       "name": companyName,
//       "description": companyDescription,
//       "years": Map.of(companyYears),
//     });

//     companyName = "";
//     companyDescription = "";
//   }

//   Future<void> _deleteCompany(String companyId) async {
//     await companies.doc(companyId).delete();
//   }
// }

// class CompanyWidget extends StatelessWidget {
//   final Map<String, dynamic> item;
//   final Function() onDelete;
//   final Function() onEdit;

//   CompanyWidget({
//     required this.item,
//     required this.onDelete,
//     required this.onEdit,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       margin: EdgeInsets.all(10),
//       padding: EdgeInsets.all(10),
//       decoration: BoxDecoration(
//         border: Border.all(),
//         borderRadius: BorderRadius.circular(8),
//       ),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: <Widget>[
//           Text("Company Name: ${item["name"] ?? ""}",
//               style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
//           Text("Description: ${item["description"] ?? ""}",
//               style: TextStyle(fontSize: 12)),
//           Text("Years:",
//               style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold)),
//           if (item["years"] != null) ...[
//             for (var entry in (item["years"] as Map<String, dynamic>).entries)
//               Row(
//                 children: [
//                   Text("Year: ${entry.key}",
//                       style: TextStyle(fontWeight: FontWeight.bold)),
//                   Text("Value: ${entry.value.toString()}",
//                       style: TextStyle(fontSize: 12)),
//                 ],
//               ),
//           ],
//           Row(
//             mainAxisAlignment: MainAxisAlignment.end,
//             children: <Widget>[
//               TextButton(
//                 onPressed: onEdit,
//                 child: Text("Edit"),
//               ),
//               TextButton(
//                 onPressed: onDelete,
//                 child: Text("Delete"),
//               ),
//             ],
//           ),
//         ],
//       ),
//     );
//   }
// }

class ListingScreen extends StatefulWidget {
  @override
  _ListingScreenState createState() => _ListingScreenState();
}

class _ListingScreenState extends State<ListingScreen> {
  final CollectionReference companies =
      FirebaseFirestore.instance.collection('companies');

  String companyName = "";
  String companyDescription = "";

  List<String> options = List.generate(10, (index) => "Option ${index + 1}");
  String selectedOption = "Option 1";

  Map<String, String> companyYears = {};

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Company Listings"),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            StreamBuilder<QuerySnapshot>(
              stream: companies.snapshots(),
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return Text("Error: ${snapshot.error}");
                }

                if (snapshot.connectionState == ConnectionState.waiting) {
                  return CircularProgressIndicator();
                }

                return Column(
                  children: (snapshot.data?.docs ?? []).map((doc) {
                    final companyData = doc.data() as Map<String, dynamic>;
                    return CompanyWidget(
                      item: companyData,
                      onDelete: () {
                        _deleteCompany(doc.id);
                      },
                      onEdit: () {
                        _showEditCompanyDialog(context, companyData, doc.id);
                      },
                    );
                  }).toList(),
                );
              },
            ),
            SizedBox(height: 20),
            // Input Fields
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  TextField(
                    decoration: InputDecoration(labelText: "Company Name"),
                    onChanged: (value) {
                      companyName = value;
                    },
                  ),
                  TextField(
                    decoration: InputDecoration(labelText: "Description"),
                    onChanged: (value) {
                      companyDescription = value;
                    },
                  ),
                  DropdownButton<String>(
                    value: selectedOption,
                    items: options.map((option) {
                      return DropdownMenuItem<String>(
                        value: option,
                        child: Text(option),
                      );
                    }).toList(),
                    onChanged: (String? newValue) {
                      setState(() {
                        selectedOption = newValue ?? "";
                      });
                    },
                  ),
                  if (selectedOption.isNotEmpty)
                    ListView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: 5,
                      itemBuilder: (context, index) {
                        final year1 = 2023 + 2 * index;
                        final year2 = year1 + 1;
                        return Row(
                          children: [
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  children: [
                                    Text(
                                      year1.toString(),
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold),
                                    ),
                                    TextField(
                                      decoration: InputDecoration(
                                        labelText: "Year $year1",
                                        border: OutlineInputBorder(),
                                        focusedBorder: OutlineInputBorder(
                                          borderSide:
                                              BorderSide(color: Colors.blue),
                                        ),
                                      ),
                                      onChanged: (value) {
                                        if (value != null) {
                                          companyYears[year1.toString()] =
                                              value;
                                        }
                                      },
                                      controller: TextEditingController(
                                        text: companyYears[year1.toString()] ??
                                            "",
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  children: [
                                    Text(
                                      year2.toString(),
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold),
                                    ),
                                    TextField(
                                      decoration: InputDecoration(
                                        labelText: "Year $year2",
                                        border: OutlineInputBorder(),
                                        focusedBorder: OutlineInputBorder(
                                          borderSide:
                                              BorderSide(color: Colors.blue),
                                        ),
                                      ),
                                      onChanged: (value) {
                                        if (value != null) {
                                          companyYears[year2.toString()] =
                                              value;
                                        }
                                      },
                                      controller: TextEditingController(
                                        text: companyYears[year2.toString()] ??
                                            "",
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        );
                      },
                    ),
                  ElevatedButton(
                    onPressed: () {
                      _saveCompanyData();
                    },
                    child: Text("Add Company"),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showEditCompanyDialog(
      BuildContext context, Map<String, dynamic> company, String companyId) {
    companyName = company["name"];
    companyDescription = company["description"];
    companyYears = {};

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("Edit Company"),
          content: StatefulBuilder(
            builder: (context, setState) {
              return Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  TextField(
                    decoration: InputDecoration(labelText: "Company Name"),
                    onChanged: (value) {
                      companyName = value;
                    },
                    controller: TextEditingController(text: companyName),
                  ),
                  TextField(
                    decoration: InputDecoration(labelText: "Description"),
                    onChanged: (value) {
                      companyDescription = value;
                    },
                    controller: TextEditingController(text: companyDescription),
                  ),
                  DropdownButton<String>(
                    value: selectedOption,
                    items: options.map((option) {
                      return DropdownMenuItem<String>(
                        value: option,
                        child: Text(option),
                      );
                    }).toList(),
                    onChanged: (String? newValue) {
                      setState(() {
                        selectedOption = newValue ?? "";
                      });
                    },
                  ),
                  if (selectedOption.isNotEmpty)
                    ListView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: 5,
                      itemBuilder: (context, index) {
                        final year1 = 2023 + 2 * index;
                        final year2 = year1 + 1;
                        return Row(
                          children: [
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  children: [
                                    Text(
                                      year1.toString(),
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold),
                                    ),
                                    TextField(
                                      decoration: InputDecoration(
                                        labelText: "Year $year1",
                                        border: OutlineInputBorder(),
                                        focusedBorder: OutlineInputBorder(
                                          borderSide:
                                              BorderSide(color: Colors.blue),
                                        ),
                                      ),
                                      onChanged: (value) {
                                        if (value != null) {
                                          companyYears[year1.toString()] =
                                              value;
                                        }
                                      },
                                      controller: TextEditingController(
                                        text: companyYears[year1.toString()] ??
                                            "",
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  children: [
                                    Text(
                                      year2.toString(),
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold),
                                    ),
                                    TextField(
                                      decoration: InputDecoration(
                                        labelText: "Year $year2",
                                        border: OutlineInputBorder(),
                                        focusedBorder: OutlineInputBorder(
                                          borderSide:
                                              BorderSide(color: Colors.blue),
                                        ),
                                      ),
                                      onChanged: (value) {
                                        if (value != null) {
                                          companyYears[year2.toString()] =
                                              value;
                                        }
                                      },
                                      controller: TextEditingController(
                                        text: companyYears[year2.toString()] ??
                                            "",
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        );
                      },
                    ),
                ],
              );
            },
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text("Cancel"),
            ),
            TextButton(
              onPressed: () {
                _updateCompanyData(companyId);
                companyName = "";
                companyDescription = "";
                Navigator.of(context).pop();
              },
              child: Text("Save"),
            ),
          ],
        );
      },
    );
  }

  Future<void> _saveCompanyData() async {
    await companies.add({
      "name": companyName,
      "description": companyDescription,
      "years": Map.of(companyYears),
    });

    // Clear input fields after adding
    companyName = "";
    companyDescription = "";
    companyYears.clear();
  }

  Future<void> _updateCompanyData(String companyId) async {
    await companies.doc(companyId).update({
      "name": companyName,
      "description": companyDescription,
      "years": Map.of(companyYears),
    });

    companyName = "";
    companyDescription = "";
  }

  Future<void> _deleteCompany(String companyId) async {
    await companies.doc(companyId).delete();
  }
}

class CompanyWidget extends StatelessWidget {
  final Map<String, dynamic> item;
  final Function() onDelete;
  final Function() onEdit;

  CompanyWidget({
    required this.item,
    required this.onDelete,
    required this.onEdit,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(10),
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        border: Border.all(),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text("Company Name: ${item["name"] ?? ""}",
              style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
          Text("Description: ${item["description"] ?? ""}",
              style: TextStyle(fontSize: 12)),
          Text("Years:",
              style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold)),
          if (item["years"] != null) ...[
            for (var entry in (item["years"] as Map<String, dynamic>).entries)
              Row(
                children: [
                  Text("Year: ${entry.key}",
                      style: TextStyle(fontWeight: FontWeight.bold)),
                  Text("Value: ${entry.value.toString()}",
                      style: TextStyle(fontSize: 12)),
                ],
              ),
          ],
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              TextButton(
                onPressed: onEdit,
                child: Text("Edit"),
              ),
              TextButton(
                onPressed: onDelete,
                child: Text("Delete"),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
