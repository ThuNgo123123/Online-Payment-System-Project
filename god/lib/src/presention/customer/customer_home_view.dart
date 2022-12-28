import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';

import '../loading/Loading_page.dart';

class CustomerHomeView extends StatelessWidget {
  const CustomerHomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return const CustomerHomePage();
  }
}

class CustomerHomePage extends StatefulWidget {
  const CustomerHomePage({super.key});

  @override
  State<CustomerHomePage> createState() => _CustomerHomePageState();
}

class _CustomerHomePageState extends State<CustomerHomePage> {
  final Stream<DocumentSnapshot> statusStream = FirebaseFirestore.instance
      .collection('status')
      .doc("q1JOKlA9AyaieRxD8ELQ")
      .snapshots();

  int status = 0;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    initNotify();
  }

  initNotify() async {
    statusStream.listen((event) async {
      if (event.exists) {
        Map<String, dynamic> data = event.data() as Map<String, dynamic>;
        setState(() {
          status = data["status"];
        });
        if (status == 2) {
          setState(() {
            isLoading = true;
          });
          await Future.delayed(const Duration(seconds: 1), () {
            setState(() {
              isLoading = false;
            });
            showSuccessDialog();
          });
        }
        if (status == 3) {
          setState(() {
            isLoading = true;
          });
          await Future.delayed(const Duration(seconds: 1), () {
            setState(() {
              isLoading = false;
            });
            showSuccessGrabDialog();
          });
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      appBar: AppBar(
        backgroundColor: const Color(0xFF00A84B),
        title: const Text("Đơn hàng"),
        actions: [
          IconButton(
            onPressed: () {
              showQRDialog();
            },
            icon: const Icon(
              Icons.qr_code,
              color: Colors.white,
            ),
          )
        ],
      ),
      body: Stack(
        children: [
          buildBody(),
          if (isLoading)
            Container(
              color: Colors.black12,
              child: const Center(
                child: LoadingPage(),
              ),
            ),
        ],
      ),
    );
  }

  Widget buildBody() {
    return Column(
      children: [
        buildOderCode(),
        const SizedBox(height: 16),
        buildCart(),
        const Spacer(),
        buildTotal(),
        const SizedBox(height: 16),
        buildStatus(),
        const SizedBox(height: 30),
      ],
    );
  }

  Widget buildOderCode() {
    return Container(
      width: MediaQuery.of(context).size.width,
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 13, horizontal: 16),
        child: Row(
          children: const [
            Text(
              "Mã đơn hàng: ",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            Text(
              "#HD00001",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Color(0xFF00A84B),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildCart() {
    return Container(
      width: MediaQuery.of(context).size.width,
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 13, horizontal: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Chi tiết đơn hàng",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            buildItem(
              "assets/images/iphone.webp",
              "iPhone 14 128GB Màu đỏ | Chính hãng VN/A 99%",
              "20.990.000 ₫",
            ),
            buildItem(
              "assets/images/sac.webp",
              "Sạc nhanh OtterBox 18W",
              "390.000 ₫",
            )
          ],
        ),
      ),
    );
  }

  Widget buildItem(String img, String name, String price) {
    return Padding(
      padding: const EdgeInsets.only(top: 26),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 62,
            height: 62,
            child: Image.asset(img),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 20),
                Row(
                  children: [
                    const Expanded(child: Text("1x")),
                    Text(
                      price,
                      style: const TextStyle(color: Colors.red),
                    )
                  ],
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget buildTotal() {
    return Container(
      width: MediaQuery.of(context).size.width,
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 13, horizontal: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: const [
                Expanded(
                  child: Text(
                    "Tiền hàng:",
                  ),
                ),
                Text(
                  "21.380.000 ₫",
                ),
              ],
            ),
            const SizedBox(height: 10),
            Row(
              children: const [
                Expanded(
                  child: Text(
                    "Tiền ship: ",
                  ),
                ),
                Text(
                  "80.000 ₫",
                ),
              ],
            ),
            const SizedBox(height: 10),
            Row(
              children: const [
                Expanded(
                  child: Text(
                    "Thành tiền:",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Text(
                  "21.460.000 ₫",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.red,
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget buildStatus() {
    return Container(
      width: MediaQuery.of(context).size.width,
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 13, horizontal: 16),
        child: Row(
          children: [
            const Expanded(
              child: Text(
                "Trạng thái:",
              ),
            ),
            InkWell(
                onTap: () {
                  showStatusSheet(status);
                },
                child: Container(
                  decoration: BoxDecoration(
                    color: const Color(0xFF3BB3D4),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 10, horizontal: 20),
                    child: Text(
                      status == 0
                          ? "Tài xế đang di chuyển"
                          : status == 1
                              ? 'Đã nhận hàng'
                              : 'Đã thanh toán',
                      style: const TextStyle(color: Colors.white),
                    ),
                  ),
                ))
          ],
        ),
      ),
    );
  }

  Future<void> showSuccessDialog() async {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Thông báo'),
          content: SingleChildScrollView(
            child: ListBody(
              children: const <Widget>[
                Text(
                    'Hóa đơn #HD00001 đã được thanh toán thành công số tiền 21.460.000 ₫. Chuyển trạng thái hóa đơn sang hoàn thành'),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Hoàn thành'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  Future<void> showSuccessGrabDialog() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Thông báo'),
          content: SingleChildScrollView(
            child: ListBody(
              children: const <Widget>[
                Text(
                    'Hóa đơn #HD00001 đã được thanh toán thành công số tiền 21.460.000 ₫. Tài xế xác nhận đã nhận tiền mặt. Chuyển trạng thái hóa đơn sang hoàn thành'),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Hoàn thành'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  Future<void> showQRDialog() async {
    showModalBottomSheet<void>(
      context: context,
      builder: (BuildContext context) {
        return SizedBox(
          height: 700,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 30),
            child: Column(
              children: [
                const SizedBox(height: 20),
                const Text("Đưa mã này cho tài xế"),
                const SizedBox(height: 20),
                QrImage(
                  data: "firebase 123",
                  version: QrVersions.auto,
                  size: 350.0,
                  embeddedImage: const AssetImage('assets/images/logo.png'),
                  embeddedImageStyle: QrEmbeddedImageStyle(
                    size: const Size(80, 80),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Future<void> showStatusSheet(int status) async {
    showModalBottomSheet<void>(
      context: context,
      builder: (BuildContext context) {
        return SizedBox(
          height: 200,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 30),
            child: Column(
              children: <Widget>[
                itemSheet('Tài xế đang di chuyển', true),
                const SizedBox(height: 10),
                itemSheet('Đã đến nơi', status > 0),
                const SizedBox(height: 10),
                itemSheet('Đã thanh toán', status > 1),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget itemSheet(String text, bool checked) {
    return Row(
      children: [
        Expanded(child: Text(text)),
        Icon(checked
            ? Icons.check_circle_outline_outlined
            : Icons.circle_outlined)
      ],
    );
  }
}
