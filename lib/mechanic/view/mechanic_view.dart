import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class MechanicView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      child: Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          scrolledUnderElevation: 0,
          backgroundColor: Colors.transparent,
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            style: IconButton.styleFrom(
              backgroundColor: Color(0xFFFFFFFF),
            ),
            onPressed: () {
              context.go("/home");
            },
          ),
          actions: [
            IconButton(
              icon: Icon(Icons.share),
              style: IconButton.styleFrom(
                backgroundColor: Color(0xFFFFFFFF),
              ),
              onPressed: () {},
            ),
            IconButton(
              icon: Icon(Icons.bookmark_outline),
              style: IconButton.styleFrom(
                backgroundColor: Color(0xFFFFFFFF),
              ),
              onPressed: () {},
            ),
          ],
        ),
        body: Stack(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Image.network(
                  "https://www.shutterstock.com/image-photo/mechanic-using-wrench-while-working-600nw-2184125681.jpg",
                  width: double.infinity,
                  height: 200,
                  fit: BoxFit.cover,
                ),
                Container(
                  padding: EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Makmur Jaya',
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      Text(
                          'Jl. Digital Kreatif No. 10, Palmerah, Jakarta Barat'),
                    ],
                  ),
                ),
                TabBar(
                  isScrollable: true,
                  labelColor: Color(0xFFFB9548),
                  unselectedLabelColor: Colors.black,
                  tabAlignment: TabAlignment.center,
                  dividerColor: Color(0xFFA7A7A7),
                  indicatorColor: Color(0XFFFB9548),
                  tabs: [
                    Tab(text: 'Tentang'),
                    Tab(text: 'Layanan'),
                    Tab(text: 'Galeri'),
                    Tab(text: 'Ulasan'),
                  ],
                ),
                Expanded(
                  child: TabBarView(
                    children: [
                      About(),
                      About(),
                      About(),
                      About(),
                    ],
                  ),
                ),
              ],
            ),
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.fromLTRB(30, 15, 30, 15),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('Estimasi Biaya',
                              style: TextStyle(
                                  fontSize: 17, fontWeight: FontWeight.bold)),
                          Text('Rp. 50.000',
                              style: TextStyle(
                                  fontSize: 24, fontWeight: FontWeight.bold)),
                        ],
                      ),
                    ),
                    SizedBox(height: 3),
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(15),
                          topRight: Radius.circular(15),
                        ),
                        color: Color(0xFF262626),
                      ),
                      padding: EdgeInsets.fromLTRB(30, 15, 30, 15),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                fixedSize: Size(165, 45),
                                backgroundColor: Color(0xFF262626),
                                foregroundColor: (Color(0xFFFF693A)),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                side: BorderSide(
                                  width: 2.0,
                                  color: Color(0xFFFF693A),
                                )),
                            onPressed: () {},
                            child: Text('Atur Jadwal',
                                style: TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.bold)),
                          ),
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                padding: EdgeInsets.all(5),
                                fixedSize: Size(165, 45),
                                backgroundColor: Color(0xFFFF693A),
                                foregroundColor: (Color(0xFFFFFFFF)),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                side: BorderSide(
                                  width: 2.0,
                                  color: Color(0xFFFF693A),
                                )),
                            onPressed: () {},
                            child: Text(
                              'Pesan Sekarang',
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.bold),
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ), // Tutup kurung Positioned di sini
            ),
          ],
        ),
      ),
    );
  }
}

class About extends StatelessWidget {
  const About({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Tentang',
            style: TextStyle(fontWeight: FontWeight.w800),
          ),
          SizedBox(
            height: 10,
          ),
          Text(
            'Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Aenean commodo ligula eget dolor. Aenean massa. Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Donec quam felis, ultricies nec, pellentesque eu, pretium quis, sem. Nulla consequat massa quis enim. Donec pede justo, fringilla vel, aliquet nec, vulputate eget, arcu.',
            style: TextStyle(fontSize: 12),
          ),
          SizedBox(height: 20),
          Text(
            'Penyedia Jasa',
            style: TextStyle(fontWeight: FontWeight.w800),
          ),
          ListTile(
            contentPadding: EdgeInsets.all(0),
            leading: CircleAvatar(
              backgroundImage: NetworkImage(
                  'https://upload.wikimedia.org/wikipedia/commons/a/a0/Andrzej_Person_Kancelaria_Senatu.jpg'),
            ),
            title: Text(
              'Makmur Jaya',
              style: TextStyle(
                fontWeight: FontWeight.w800,
              ),
            ),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                    style: IconButton.styleFrom(
                        backgroundColor: Color(0xFFF5F5F5)),
                    icon: Icon(Icons.chat, size: 25, color: Color(0xFFFB9548)),
                    onPressed: () {}),
                SizedBox(width: 5),
                IconButton(
                    style: IconButton.styleFrom(
                        backgroundColor: Color(0xFFF5F5F5)),
                    icon: Icon(Icons.call, size: 25, color: Color(0xFFFB9548)),
                    onPressed: () {}),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
