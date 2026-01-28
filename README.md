# Danetka. Think Again.

**Danetka** is a logic-based riddle card game inspired by classic *Yes / No* riddles.

Players try to uncover a hidden story by asking questions that can only be answered with  
**Yes**, **No**, or **Doesn’t matter**.

The app focuses on clean UI, smooth animations, and a simple but engaging game flow.

<p align="center">
  <img src="./Assets/screens.gif" width="320" />
</p>

---

## 🎮 Gameplay

- One player acts as the **host** and chooses a riddle card
- The host reads the description and keeps the full story hidden
- Other players ask questions to reconstruct the situation
- Answers are limited to **Yes**, **No**, or **Doesn’t matter**
- Hints are available if the discussion gets stuck
- The full story is revealed at the end

The game is designed for playing with friends and encourages discussion and logical thinking.

---

## 🗂 Categories & Navigation

Riddles are grouped into categories for easier navigation and replayability.

<p align="center">
  <img src="./Assets/categories.gif" width="320" />
</p>

---

## 🃏 Card Interaction & Animations

Each riddle is presented as a card with smooth transitions and subtle animations.

<p align="center">
  <img src="./Assets/cards.gif" width="320" />
</p>

---

## ✨ Features

- Card-based riddle gameplay
- Category system
- Hint and answer reveal flow
- **Remote loading of riddle cards**
- Offline support after initial load
- Smooth SwiftUI animations

---

## 🛠 Tech Stack

- **MVVM**
- **SwiftUI**
- **JSON API**
- **URLSession**
- **Localization**
- **Local caching**
- **In-App Purchases**
- **Custom animations**

---

## 🧩 Architecture

The app uses **MVVM** with a clear separation between UI and data layers:

- **Presentation (MVVM)** — SwiftUI screens, navigation, animations, ViewModels (`Features/*`, `UIComponents`, `Navigation`)
- **Domain (Models)** — cards, categories, remote manifest (`Shared/Models`, localized resources)
- **Data layer** — networking, caching, repositories, persistence (`Services`, `Repository`, `Shared/Persistence`)
- **Purchases** — StoreKit flow, transaction handling, access control (`Purchases`)

This structure keeps the project scalable:
new packs, cards, languages, or monetization rules can be added mostly in the data/config layer without rewriting UI.

---

## 🚀 What This Project Demonstrates

- End-to-end SwiftUI app development
- Working with remote APIs and local caching
- App state management and navigation
- Localization-ready UI
- Real-world monetization integration
- Structuring a pet project close to production quality

---

## 🔮 Future Plans

- New riddle packs and categories
- App Store release and publishing
