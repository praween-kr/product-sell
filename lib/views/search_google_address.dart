import 'package:flutter/material.dart';
import 'package:oninto_flutter/model/g_place_model.dart';
import 'package:oninto_flutter/service/api_requests.dart';

class SearchGoogleAddress extends StatefulWidget {
  const SearchGoogleAddress({super.key, required this.onChanged});
  final Function(PlaceResults) onChanged;

  @override
  State<SearchGoogleAddress> createState() => _SearchGoogleAddressState();
}

class _SearchGoogleAddressState extends State<SearchGoogleAddress> {
  List<PlaceResults> googleSearchAddress = <PlaceResults>[];
  var googleSearching = false;
  var googleSearchQuery = TextEditingController(text: '');

  searchGooglePlaces() async {
    await ApiRequests.gPlaceSearch(
      googleSearchQuery.text.trim(),
      addresses: (addresses) {
        setState(() {
          googleSearchAddress = addresses;
        });
      },
      loading: (loading) {
        setState(() {
          googleSearching = loading;
        });
      },
    );
  }

  Color themeColor = const Color(0xFFf1a339);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: themeColor,
        title: const Text("Search Place"),
        centerTitle: false,
      ),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 14),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 14),
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              decoration: BoxDecoration(
                color: Colors.grey.shade300,
                borderRadius: BorderRadius.circular(40),
              ),
              child: TextField(
                cursorColor: themeColor,
                controller: googleSearchQuery,
                decoration: InputDecoration(
                  focusColor: themeColor,
                  hintText: 'Search place...',
                  suffixIcon: IconButton(
                    icon: Icon(Icons.clear, color: themeColor),
                    onPressed: () => googleSearchQuery.clear(),
                  ),
                  prefixIcon: IconButton(
                    icon: Icon(
                      Icons.search,
                      color: themeColor,
                    ),
                    onPressed: () {
                      // Perform the search here
                    },
                  ),
                  border: InputBorder.none,
                ),
                onChanged: (query) async {
                  if (query.trim() == '') {
                    googleSearchAddress = [];
                  } else {
                    await searchGooglePlaces();
                  }
                },
              ),
            ),
            const SizedBox(height: 14),
            Expanded(
              child: ListView.builder(
                  itemCount: googleSearchAddress.length,
                  itemBuilder: (context, index) {
                    PlaceResults item = googleSearchAddress[index];
                    return Material(
                      color: Colors.transparent,
                      child: InkWell(
                        onTap: () {
                          widget.onChanged(item);
                          Navigator.pop(context);
                        },
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 14, vertical: 8),
                          decoration: const BoxDecoration(),
                          child: Row(
                            children: [
                              Icon(
                                Icons.location_pin,
                                color: Colors.grey,
                                size: MediaQuery.of(context).size.width * 0.08,
                              ),
                              const SizedBox(width: 8),
                              Expanded(child: Text(item.address ?? '')),
                            ],
                          ),
                        ),
                      ),
                    );
                  }),
            ),
            const SizedBox(height: 24.0),
          ],
        ),
      ),
    );
  }
}
