import 'package:easy_localization/easy_localization.dart';
import 'package:evently/firebase_utils.dart';
import 'package:evently/models/event.dart';
import 'package:evently/providers/user_provider.dart';
import 'package:evently/ui/home/tabs/home_tab/widgets/event_item.dart';
import 'package:evently/ui/login/widgets/text_field_widget.dart';
import 'package:evently/utils/size_utils.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FavoriteTab extends StatefulWidget {
  FavoriteTab({super.key});

  @override
  State<FavoriteTab> createState() => _FavoriteTabState();
}

class _FavoriteTabState extends State<FavoriteTab> {
  List<Event> filteredEventsList = [];
  String searchText = '';
  Stream<List<Event>>? stream;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    var userProvider = Provider.of<UserProvider>(context, listen: false);
    stream = FirebaseUtils.getEventsFavoriteInFirestore(
      userProvider.currentUser!.id,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        left: context.width * 0.043,
        right: context.width * 0.043,
        top: context.height * 0.025,
      ),
      child: Column(
        spacing: context.height * 0.025,
        children: [
          TextFieldWidget(
            hintText: 'search_for_event',
            suffixIcon: Icon(
              Icons.search,
              color: Theme.of(context).primaryColor,
            ),
            onChanged: (text) {
              searchText = text;
              setState(() {});
            },
          ),
          Expanded(
            child: StreamBuilder(
              stream: stream,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(
                    child: CircularProgressIndicator(
                      color: Theme.of(context).primaryColor,
                    ),
                  );
                } else if (snapshot.hasError) {
                  return Center(child: Text(snapshot.error.toString()));
                } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return Center(
                    child: Text(
                      'No_favorite'.tr(),
                      style: Theme.of(context).textTheme.labelLarge,
                    ),
                  );
                } else {
                  filteredEventsList = snapshot.data!.where((event) {
                    return event.title.toLowerCase().contains(
                      searchText.toLowerCase(),
                    );
                  }).toList();
                  return filteredEventsList.isEmpty
                      ? Center(
                          child: Text(
                            'not_found_search'.tr(),
                            style: Theme.of(context).textTheme.labelLarge,
                          ),
                        )
                      : ListView.separated(
                          itemBuilder: (context, index) {
                            return EventItem(
                              event: filteredEventsList[index],
                              isLastItem:
                                  index == filteredEventsList.length - 1,
                            );
                          },
                          separatorBuilder: (context, index) {
                            return SizedBox(height: context.height * 0.017);
                          },
                          itemCount: filteredEventsList.length,
                        );
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
