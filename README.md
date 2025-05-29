# 📱 ZScan - Barcode Scanner & Generator App

**ZScan** is a Flutter-powered mobile application designed to scan and generate barcodes and QR codes effortlessly. With support for history tracking, sharing, and clipboard integration, ZScan is your lightweight, fast, and feature-rich barcode tool.

---

## 🚀 Features

* 📷 **Scan Barcodes & QR Codes**
* 🖨️ **Generate Custom Barcodes/QRs**
* 🗂️ **Save and View Scan History**
* 🔗 **Copy or Share Scan Results**
* ↺ **Multi-Scan Support**
* 📀 **Local Data Storage with SQLite**
* 🌙 **Dark Mode UI Support**

---

## 📂 Project Structure

```
lib/
├── main.dart
│
├── screens/
│   ├── home_screen.dart         # Tabbed view for Scanner and Generator
│   ├── scanner_screen.dart      # Camera scanner with multi-scan support
│   ├── scan_history.dart        # Displays scanned history with delete/share
│   └── generator_screen.dart    # Generates QR/Barcodes from input text
│
└── database/
    └── db_helper.dart           # Manages SQLite scan history database
```

---

## 🧰 Installation

1. Clone the repository:

   ```bash
   git clone https://github.com/yourusername/zscan.git
   cd zscan
   ```

2. Install dependencies:

   ```bash
   flutter pub get
   ```

3. Run the app:

   ```bash
   flutter run
   ```

> Make sure a device or emulator is connected and Flutter is properly installed.

---

## 📸 Screenshots

![Screenshot_20250529_233413](https://github.com/user-attachments/assets/1a20d7fb-3aa6-43ef-a958-98611c94b657)
![Screenshot_20250529_233331](https://github.com/user-attachments/assets/b4020c42-f617-4737-a3bc-6f3e2b85205c)
![Screenshot_20250529_233445](https://github.com/user-attachments/assets/2df33d79-e5b9-4ded-8adc-876d7ea13fae)

---


## 📦 Packages Used

| Package         | Version |
| --------------- | ------- |
| `flutter_zxing` | ^2.1.0  |
| `share_plus`    | ^7.2.1  |
| `path_provider` | ^2.1.2  |
| `sqflite`       | ^2.4.2  |
| `path`          | ^1.8.3  |

---

## 📄 License

This project is licensed under the **MIT License**.

```
MIT License

Copyright (c) 2025 Saeed Dehghani

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the “Software”), to deal
in the Software without restriction...

(Full license text in LICENSE file)
```

---

## 👤 Author

**Saeed Dehghani**
📧 [dehganisaeed69@gmail.com](mailto:dehganisaeed69@gmail.com)

---

## 🌟 Contribution

Pull requests are welcome. For major changes, please open an issue first to discuss what you'd like to change.

---

**Enjoy using ZScan!**
