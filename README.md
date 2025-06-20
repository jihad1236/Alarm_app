# ⏰ Alarm App

A personalized and intelligent alarm scheduling application built with **Flutter** and **GetX**, using **SQLite**, **Firebase**, and **local notifications**. This app allows users to set, manage, and get notified for alarms, optionally using current location-based triggers.

---

## 🧠 Features

### ✅ Core Alarm Features
- Add, edit, and delete alarms
- Schedule one-time or repeating alarms
- Local notifications with custom titles and body
- Toggle alarms on/off without deleting
- Instant test notification support

### 🧭 Location-Based Notification (Optional)
- Request and check location permission
- Fetch current location and address
- Trigger a notification when location is granted

### 🗃️ Local Data Handling
- Alarm data stored in **SQLite**
- GetX Controller to handle state
- Reusable alarm model with fields:
  - `id`, `title`, `time`, `isActive`, `repeat`, `createdAt`

### 📱 Beautiful UI
- Responsive and modern layout
- Custom styled buttons, dialogs, and forms
- Smooth transitions using `Get.to()`

---

## 🛠️ Technologies Used

| Tech              | Description                          |
|------------------|--------------------------------------|
| Flutter           | Main framework                      |
| GetX              | State management and routing        |
| Flutter Local Notifications | Alarm trigger notifications      |
| SQLite            | Local persistent storage for alarms |
| Geolocator        | Current location fetching           |
| Permission Handler| Manage runtime permissions          |

---

## 🧩 Project Structure

```plaintext
lib/
├── main.dart
├── models/
│   └── alarm_model.dart
├── controllers/
│   ├── alarm_controller.dart
│   └── notification_controller.dart
├── services/
│   ├── notification_service.dart
│   └── database_helper.dart
├── views/
│   ├── home_page.dart
│   └── add_edit_alarm_page.dart
└── utils/
    └── time_utils.dart
