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

### 🔹 Home Screen

![Home Screen](screenshots/home_screen.png)

### 🔹 Barcode Scanner

![Scanner Screen](screenshots/scanner_screen.png)

### 🔹 Scan History

![Scan History](screenshots/history_screen.png)

> Place these images in the `screenshots/` directory of your project repository.

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
