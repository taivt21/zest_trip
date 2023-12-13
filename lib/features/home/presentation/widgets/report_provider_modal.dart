import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:zest_trip/features/payment/presentation/bloc/report_provider/report_provider_bloc.dart';
import 'package:zest_trip/get_it.dart';

class ReportModal extends StatefulWidget {
  final String providerId;

  const ReportModal({Key? key, required this.providerId}) : super(key: key);

  @override
  _ReportModalState createState() => _ReportModalState();
}

class _ReportModalState extends State<ReportModal> {
  String _selectedType = "";
  TextEditingController reasonController = TextEditingController();

  @override
  void dispose() {
    reasonController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<ReportProviderBloc, ReportProviderState>(
      listener: (context, state) {
        if (state is ReportProviderSuccess) {
          Fluttertoast.showToast(
            msg: "Report provider success",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
          );
          Navigator.pop(context);
        } else if (state is ReportProviderFail) {
          Fluttertoast.showToast(
            msg: "${state.error?.response?.data?["message"]}",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
          );
        }
      },
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        appBar: AppBar(
          scrolledUnderElevation: 0,
          title: const Text("Report"),
          automaticallyImplyLeading: false,
          flexibleSpace: Row(
            children: [
              IconButton(
                icon: const Icon(Icons.clear),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                context.read<ReportProviderBloc>().add(ReportProvider(
                      providerId: widget.providerId,
                      reason: reasonController.text,
                      type: _selectedType,
                    ));
              },
              child: const Text(
                "Send",
                style: TextStyle(
                    decoration: TextDecoration.underline, fontSize: 15),
              ),
            )
          ],
        ),
        body: SizedBox(
          height: MediaQuery.of(context).size.height * 0.8,
          child: Stack(
            children: [
              SingleChildScrollView(
                child: Container(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TextField(
                          autofocus: true,
                          minLines: 4,
                          maxLines: 8,
                          controller: reasonController,
                          decoration: const InputDecoration(
                            labelText: "Reason",
                            hintText: "Your reason",
                            border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(32)),
                            ),
                          )),
                      const SizedBox(height: 16.0),
                      Text(
                        "Select type of report",
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                      const SizedBox(height: 8.0),
                      Wrap(
                        spacing: 8.0,
                        children: [
                          buildChoiceChip('Underpromise'),
                          buildChoiceChip('Scammer'),
                          buildChoiceChip('Mischief'),
                          buildChoiceChip('Others'),
                        ],
                      ),
                      const SizedBox(height: 16.0),
                    ],
                  ),
                ),
              ),
              // Positioned(
              //   bottom: 16,
              //   left: 0,
              //   right: 0,
              //   child: Padding(
              //     padding: const EdgeInsets.symmetric(horizontal: 16),
              //     child: ElevatedButtonCustom(
              //       onPressed: () {
              //         context.read<ReportProviderBloc>().add(ReportProvider(
              //               providerId: widget.providerId,
              //               reason: reasonController.text,
              //               type: _selectedType,
              //             ));
              //       },
              //       text: "Report",
              //     ),
              //   ),
              // ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildChoiceChip(String label) {
    return ChoiceChip(
      label: Text(label),
      selected: _selectedType == label,
      onSelected: (selected) {
        setState(() {
          _selectedType = selected ? label : "";
        });
      },
      elevation: _selectedType == label ? 2 : 0,
      pressElevation: 2,
      selectedColor: Colors.transparent,
      backgroundColor: Colors.transparent,
      shape: RoundedRectangleBorder(
        side: BorderSide(
          color: _selectedType == label ? Colors.black : Colors.grey,
          width: 1.5,
        ),
        borderRadius: BorderRadius.circular(4),
      ),
    );
  }
}
