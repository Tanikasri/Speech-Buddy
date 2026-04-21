<div align="center">

# 🗣️ Speech Buddy Pro

### _Giving every patient a voice — no words needed._

[![Flutter](https://img.shields.io/badge/Flutter-3.x-02569B?style=for-the-badge&logo=flutter&logoColor=white)](https://flutter.dev)
[![Dart](https://img.shields.io/badge/Dart-3.x-0175C2?style=for-the-badge&logo=dart&logoColor=white)](https://dart.dev)
[![Hive](https://img.shields.io/badge/Hive-Local%20DB-yellow?style=for-the-badge)](https://pub.dev/packages/hive)
[![Provider](https://img.shields.io/badge/Provider-State%20Mgmt-blueviolet?style=for-the-badge)](https://pub.dev/packages/provider)
[![License: MIT](https://img.shields.io/badge/License-MIT-green?style=for-the-badge)](LICENSE)

</div>

---

## 💡 The Problem It Solves

In hospitals, care homes, and rehabilitation centers, patients who **cannot speak** — due to stroke, cognitive disability, ALS, cerebral palsy, or surgery recovery — struggle to communicate even their most basic needs.

They can't call out. Staff can't hear them. Needs go unmet.

**Speech Buddy Pro** solves this with a simple, one-tap interface that instantly alerts caretakers — no internet, no backend, no complexity.

---

## 🎯 What It Does

Speech Buddy Pro is a **fully offline, multi-role assistive communication system** built in Flutter.

A patient taps a single big icon. A caretaker sees the request instantly. An admin tracks response times. That's it.

```
Patient taps "Help" 🆘
        ↓
Request saved locally (Hive)
        ↓
Caretaker sees alert → Accepts → Completes
        ↓
Admin dashboard shows analytics & response time
```

---

## 👥 Three Roles, One App

### 🧑‍🦽 Patient (User View)
The patient sees a **large, accessible icon grid** — designed for users with limited mobility or cognitive function.

| Button | What it requests |
|--------|-----------------|
| 🍽️ **Diet** | Patient needs food |
| 🚿 **Toilet** | Patient needs bathroom assistance |
| 🆘 **Help** | Emergency — immediate attention needed |
| 💧 **Water** | Patient needs water |

- One tap → sound plays + request logged automatically
- No typing, no navigating, no confusion
- "Request Sent" confirmation appears immediately

---

### 👩‍⚕️ Caretaker View
Caretakers get a **live, prioritized request list** filtered to their assigned rooms.

- 🔴 **HELP** requests are pinned to the top — always visible first
- 🟡 **PENDING** requests shown next
- 🟢 **COMPLETED** requests archived below
- One-tap **Accept** and **Complete** actions
- Timestamps on every request so nothing is missed

---

### 🛠️ Admin Dashboard
Admins get full operational visibility without any backend.

- 📊 **Request Volume** — see exactly how many Water, Help, Diet, Toilet requests were made
- ⏱️ **Average Response Time** — measures time from patient request to caretaker acceptance (staff performance metric)
- 🏠 **Room Assignments** — which caretaker covers which room

---

## 🏗️ Architecture

```
lib/
├── main.dart                  # Entry point, Hive init, Provider setup
├── app_shell.dart             # NavigationRail shell (role switcher)
├── models/
│   ├── request.dart           # Request model (Hive)
│   └── room_assignment.dart   # Room → Caretaker mapping (Hive)
├── providers/
│   └── request_provider.dart  # Central state management
└── screens/
    ├── user_view.dart         # Patient grid UI
    ├── caretaker_view.dart    # Caretaker request dashboard
    └── admin_view.dart        # Admin analytics
```

**Tech Stack:**

| Layer | Technology |
|-------|-----------|
| UI Framework | Flutter (Dart) |
| State Management | Provider |
| Local Database | Hive (offline-first) |
| Audio Playback | audioplayers |
| Unique IDs | uuid |

---

## 🚀 Getting Started

### Prerequisites
- Flutter SDK `>=3.7.2`
- Dart SDK `>=3.0`

### Run Locally

```bash
# 1. Clone the repo
git clone https://github.com/Tanikasri/Speech-Buddy.git
cd Speech-Buddy/speakbuddy

# 2. Install dependencies
flutter pub get

# 3. Generate Hive adapters
flutter pub run build_runner build --delete-conflicting-outputs

# 4. Run the app
flutter run
```

### Supported Platforms
- ✅ Android
- ✅ iOS
- ✅ Web (Chrome)
- ✅ Windows / macOS / Linux

---

## 🌟 Who Can Benefit

| User | How it helps |
|------|-------------|
| **Stroke survivors** | Communicate needs without speech |
| **ALS / MS patients** | One-tap input requires minimal motor control |
| **Post-surgery recovery** | Silent, effortless communication |
| **Dementia care** | Simple icons remove cognitive load |
| **Pediatric wards** | Children can signal needs visually |
| **Care home staff** | Organized, prioritized request queue |
| **Hospital admins** | Data-driven performance monitoring |

---

## 📸 App Preview

| Patient Grid | Caretaker Dashboard | Admin Analytics |
|:---:|:---:|:---:|
| Large icons, one tap | Prioritized request list | Response time & volume |

---

## 🔮 Future Roadmap

- [ ] Push notifications (FCM) for caretaker alerts
- [ ] Vibration feedback on patient button tap
- [ ] Voice/TTS confirmation ("Your request has been sent")
- [ ] Multi-language icon labels
- [ ] Wearable (smartwatch) support for patients
- [ ] Real-time sync with Firebase for multi-device

---

## 🤝 Contributing

Contributions are welcome! If you work in healthcare, accessibility tech, or assistive communication — we'd especially love your input.

1. Fork the repo
2. Create a branch: `git checkout -b feature/your-feature`
3. Commit and push
4. Open a Pull Request

---

## 📄 License

MIT License — free to use, modify, and distribute.

---

<div align="center">

**Built with ❤️ for those who deserve to be heard.**

_Speech Buddy Pro — because every patient has something to say._

</div>
