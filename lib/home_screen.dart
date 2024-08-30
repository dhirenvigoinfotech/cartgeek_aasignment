import 'package:cartgeek_aasignment/api_service.dart';
import 'package:flutter/material.dart';
import 'models/current_booking_model.dart';
import 'models/package_model.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Future<List<CurrentBooking>>? _currentBookingFuture;
  Future<List<Package>>? _packages;
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  void initState() {
    super.initState();
    _fetchData();
  }

  void _showNoInternetDialog() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('No Internet Connection'),
            content: const Text(
                'Please check your internet connection and try again.'),
            actions: <Widget>[
              TextButton(
                child: const Text('OK'),
                onPressed: () {
                  Navigator.of(context).pop();
                  _fetchData();
                },
              ),
            ],
          );
        },
      );
    });
  }

  void _fetchData() {
    setState(() {
      _currentBookingFuture = fetchCurrentBooking();
      _packages = fetchPackages();
    });
  }

  Future<void> _refreshData() async {
    _fetchData();
    await Future.delayed(const Duration(seconds: 1));
  }

  @override
  Widget build(BuildContext context) {
    final itemWidth = MediaQuery.of(context).size.width / 4;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        automaticallyImplyLeading: false,
        actions: [
          Builder(
            builder: (BuildContext context) {
              return IconButton(
                icon: const ImageIcon(
                  AssetImage('assets/menus.png'),
                  color: Color(0xFFE36D9A),
                ),
                onPressed: () => Scaffold.of(context).openDrawer(),
              );
            },
          ),
        ],
      ),
      drawer: Drawer(
        child: Container(
          color: Colors.white,
          child: ListView(
            padding: EdgeInsets.zero,
            children: [
              Container(
                margin: const EdgeInsets.only(top: 50),
                padding: const EdgeInsets.symmetric(vertical: 20),
                color: Colors.white,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(1),
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: Color(0xFFE36D9A),
                      ),
                      child: const CircleAvatar(
                        radius: 40,
                        backgroundImage: AssetImage('assets/cristiano.jpg'),
                      ),
                    ),
                    const SizedBox(height: 10),
                    const Text(
                      'Emily Cyrus',
                      style: TextStyle(
                        color: Color(0xFFE36D9A),
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              _buildDrawerItem('Home'),
              _buildDrawerItem('Book a nanny'),
              _buildDrawerItem('How it works'),
              const Divider(
                  color: Color(0xFFFD7EB2),
                  thickness: 0.3,
                  indent: 20,
                  endIndent: 20),
              _buildDrawerItem('Why Nanny Vanny'),
              _buildDrawerItem('My Bookings'),
              _buildDrawerItem('My Profile'),
              const Divider(
                  color: Color(0xFFFD7EB2),
                  thickness: 0.3,
                  indent: 20,
                  endIndent: 20),
              _buildDrawerItem('Support'),
            ],
          ),
        ),
      ),
      body: RefreshIndicator(
        onRefresh: _refreshData,
        child: Container(
          color: Colors.white,
          child: SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildProfileSection(),
                const SizedBox(height: 20),
                _buildServiceCard(),
                const SizedBox(height: 10),
                _buildCurrentBookingSection(),
                _buildPackagesSection(),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: Stack(
        children: [
          BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            iconSize: 30,
            selectedItemColor: const Color(0xFFE36D9A),
            unselectedItemColor: Colors.grey[600],
            currentIndex: _selectedIndex,
            onTap: _onItemTapped,
            items: const [
              BottomNavigationBarItem(
                icon: Icon(Icons.home),
                label: 'Home',
              ),
              BottomNavigationBarItem(
                icon: ImageIcon(
                  AssetImage('assets/packages.png'),
                ),
                label: 'Packages',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.access_time),
                label: 'Bookings',
              ),
              BottomNavigationBarItem(
                icon: Padding(
                  padding: EdgeInsets.only(top: 3),
                  child: ImageIcon(
                    AssetImage('assets/user.png'),
                    size: 26,
                  ),
                ),
                label: 'Profile',
              ),
            ],
          ),
          Positioned(
            bottom: 3,
            left: (itemWidth * _selectedIndex) + (itemWidth / 2 - 3),
            child: Container(
              width: 5,
              height: 5,
              decoration: BoxDecoration(
                color: const Color(0xFFE36D9A),
                borderRadius: BorderRadius.circular(2),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDrawerItem(String title) {
    return ListTile(
      title: Text(title,
          style: const TextStyle(color: Color(0xFF262F71), fontSize: 18)),
      onTap: () => Navigator.pop(context),
    );
  }

  Widget _TitleItem(String title) {
    return ListTile(
      title: Text(title,
          style: const TextStyle(
              color: Color(0xFF262F71),
              fontSize: 18,
              fontWeight: FontWeight.bold)),
    );
  }

  Widget _buildProfileSection() {
    return Row(
      children: [
        Container(
          margin: const EdgeInsets.only(left: 20),
          padding: const EdgeInsets.all(1),
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
            color: Color(0xFFE36D9A),
          ),
          child: const CircleAvatar(
            radius: 30,
            backgroundImage: AssetImage('assets/cristiano.jpg'),
          ),
        ),
        const SizedBox(width: 10),
        const Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Welcome',
              style: TextStyle(
                color: Colors.black,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              'Emily Cyrus',
              style: TextStyle(
                color: Color(0xFFE36D9A),
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildServiceCard() {
    return Center(
      child: Container(
        height: 170,
        width: 350,
        padding: const EdgeInsets.all(16.0),
        decoration: BoxDecoration(
          color: const Color(0xFFF5B5CF),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Nanny And',
                  style: TextStyle(
                    color: Color(0xFF262F71),
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const Text(
                  'Babysitting Services',
                  style: TextStyle(
                    color: Color(0xFF262F71),
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 10),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF262F71),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                  onPressed: () {},
                  child: const Text(
                    'Book Now',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                    ),
                  ),
                ),
              ],
            ),
            Positioned(
              right: -50,
              bottom: -45,
              child: Image.asset(
                'assets/card_image.png',
                height: 250,
                width: 200,
                fit: BoxFit.contain,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCurrentBookingSection() {
    return FutureBuilder<List<CurrentBooking>>(
      future: _currentBookingFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          _showNoInternetDialog();
          return Center(child: Text('Error: ${snapshot.error}'));
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return const Center(child: Text('No current bookings.'));
        } else {
          final bookings = snapshot.data!;
          return SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _TitleItem("Your Current Booking"),
                ...bookings
                    .map((booking) => _buildBookingCard(booking))
                    .toList(),
              ],
            ),
          );
        }
      },
    );
  }

  Widget _buildBookingCard(CurrentBooking booking) {
    return Center(
      child: Container(
        width: 350,
        padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.3),
              blurRadius: 5.0,
              spreadRadius: 2.0,
            ),
          ],
        ),
        constraints: const BoxConstraints(
          minHeight: 120,
        ),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    booking.title,
                    style: const TextStyle(
                      color: Color(0xFFEA91BC),
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFFEA91BC),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                      padding: const EdgeInsets.symmetric(
                          vertical: 0, horizontal: 40),
                      minimumSize: const Size(0, 30),
                    ),
                    child: const Text(
                      "Start",
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "From",
                        style: TextStyle(
                          color: Colors.grey,
                          fontSize: 14,
                        ),
                      ),
                      const SizedBox(height: 4.0),
                      Row(
                        children: [
                          const Icon(Icons.calendar_today,
                              size: 16, color: Color(0xFFFD7EB2)),
                          const SizedBox(width: 4.0),
                          Text(
                            booking.fromDate,
                            style: const TextStyle(
                              color: Colors.black,
                              fontSize: 16,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 4.0),
                      Row(
                        children: [
                          const Icon(Icons.access_time,
                              size: 16, color: Color(0xFFFD7EB2)),
                          const SizedBox(width: 4.0),
                          Text(
                            booking.fromTime,
                            style: const TextStyle(
                              color: Colors.black,
                              fontSize: 16,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(width: 45),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "To",
                        style: TextStyle(
                          color: Colors.grey,
                          fontSize: 14,
                        ),
                      ),
                      const SizedBox(height: 4.0),
                      Row(
                        children: [
                          const Icon(Icons.calendar_today,
                              size: 16, color: Color(0xFFFD7EB2)),
                          const SizedBox(width: 4.0),
                          Text(
                            booking.toDate,
                            style: const TextStyle(
                              color: Colors.black,
                              fontSize: 16,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 4.0),
                      Row(
                        children: [
                          const Icon(Icons.access_time,
                              size: 16, color: Color(0xFFFD7EB2)),
                          const SizedBox(width: 4.0),
                          Text(
                            booking.toTime,
                            style: const TextStyle(
                              color: Colors.black,
                              fontSize: 16,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _buildActionButton("Rate Us",
                      icon: const Icon(Icons.star_border_purple500_outlined)),
                  _buildActionButton("Geolocation",
                      icon: const Icon(Icons.location_on_sharp)),
                  _buildActionButton("Surveillance",
                      icon: const Icon(Icons.alarm)),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildActionButton(String text, {Icon? icon}) {
    return OutlinedButton(
      onPressed: () {},
      style: OutlinedButton.styleFrom(
        alignment: Alignment.center,
        backgroundColor: const Color(0xFF262F71),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.0),
        ),
        padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 10),
        minimumSize: const Size(0, 25),
      ),
      child: Row(
        children: [
          if (icon != null) ...[
            Icon(
              icon.icon,
              color: Colors.white,
            ),
            const SizedBox(width: 8.0),
          ],
          Text(
            text,
            style: const TextStyle(
              fontSize: 10,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPackagesSection() {
    return FutureBuilder<List<Package>>(
      future: _packages,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else if (snapshot.hasData && snapshot.data!.isNotEmpty) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _TitleItem("Packages"),
              Column(
                children: List.generate(snapshot.data!.length, (index) {
                  final package = snapshot.data![index];
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 5.0),
                    child: _buildPackageCard(package, index.isOdd),
                  );
                }),
              ),
            ],
          );
        } else {
          return const Center(child: Text('No packages available'));
        }
      },
    );
  }

  Widget _buildPackageCard(Package package, bool isEven) {
    final cardColor =
        isEven ? const Color(0xFF80ABDB) : const Color(0xFFF5B5CF);
    final buttonColor =
        isEven ? const Color(0xFF109ED3) : const Color(0xFFFD7EB2);
    final textColor =
        isEven ? const Color(0xFFFFFFFF) : const Color(0xFF3C3C3C);
    final iconColor =
        isEven ? const Color(0xFFFFFFFF) : const Color(0xFFFD7EB2);

    return Center(
      child: IntrinsicHeight(
        child: ConstrainedBox(
          constraints: const BoxConstraints(minHeight: 100),
          child: Container(
            width: 350,
            padding: const EdgeInsets.fromLTRB(16, 8, 16, 16),
            decoration: BoxDecoration(
              color: cardColor,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _buildCalendarIcon(package.title, iconColor),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: buttonColor,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        padding: const EdgeInsets.symmetric(
                            vertical: 0, horizontal: 10),
                        minimumSize: const Size(0, 30),
                      ),
                      onPressed: () {},
                      child: const Text(
                        'Book Now',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      package.title,
                      style: const TextStyle(
                        color: Color(0xFF262F71),
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Padding(
                      padding: const EdgeInsets.only(right: 8),
                      child: Text(
                        '₹ ${package.price}',
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF262F71),
                          fontSize: 14,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                Text(
                  package.desc,
                  style: TextStyle(
                    color: textColor,
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildCalendarIcon(String title, Color iconColor) {
    String? label;

    if (title == "One Day Package") {
      label = '01';
    } else if (title == "Three Day Package") {
      label = '03';
    } else if (title == "Five Day Package") {
      label = '05';
    } else if (title == "Weekend Day Package") {
      label = '☼';
    }

    return Stack(
      alignment: Alignment.center,
      children: [
        Icon(
          Icons.calendar_today,
          size: 30,
          color: iconColor,
        ),
        if (label != null)
          Padding(
            padding: const EdgeInsets.only(top: 4),
            child: Text(
              label,
              style: TextStyle(
                color: iconColor,
                fontSize: 13,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
      ],
    );
  }
}
