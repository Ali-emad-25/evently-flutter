import 'package:evently/ui/home/tabs/home_tab/widgets/event_item.dart';
import 'package:flutter/material.dart';

class FavoriteTab extends StatelessWidget {
  const FavoriteTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 16, right: 16, top: 20),
      child: Column(
        spacing: 20,
        children: [
          TextField(
            style: Theme.of(context).textTheme.headlineMedium,
            cursorColor: Theme.of(context).primaryColor,
            decoration: InputDecoration(
              hintText: 'Search for event',
              hintStyle: Theme.of(context).textTheme.labelMedium,
              suffixIcon: Icon(
                Icons.search,
                color: Theme.of(context).primaryColor,
              ),

              filled: true,
              fillColor: Theme.of(context).cardColor,

              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20),
                borderSide: BorderSide(color: Theme.of(context).dividerColor),
              ),

              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20),
                borderSide: BorderSide(color: Theme.of(context).primaryColor),
              ),
            ),
          ),
          Expanded(
            child: ListView.separated(
              itemBuilder: (context, index) {
                return EventItem();
              },
              separatorBuilder: (context, index) {
                return SizedBox(height: 10);
              },
              itemCount: 6,
            ),
          ),
        ],
      ),
    );
  }
}
