# 15-puzzle [![Awesome](https://cdn.rawgit.com/sindresorhus/awesome/d7305f38d29fed78fa85652e3a63e154dd8e8829/media/badge.svg)](https://github.com/sindresorhus/awesome)

[![Language](https://img.shields.io/badge/Language-Swift_5.2-orange.svg)]()
[![Framework](https://img.shields.io/badge/Framework-SpriteKit-red.svg)]()
[![License](https://img.shields.io/badge/License-MIT-blue.svg)]()

**Last Update: 04/June/2020.**

![](logo-15_puzzle.png)

### If you like the project, please give it a star ⭐ It will show the creator your appreciation and help others to discover the repo.

# ✍️ About
🧩 Classic 15 Puzzle game for iOS.

# 📺 Demo 
Please wait while the `.gif` files are loading...

<img src="/assets/15_puzzle-ipad-pro.gif" width="61%"> <img src="/assets/15_puzzle-iphone-xs.gif" width="37.7%">

# 🕹 Controls
- **Swipe** anywhere to move the cells
- **Tap** ↶ button to shuffle the cells
- When you solve the puzzle, you will see the corresponding overlay dialog
- When time exceeds (01:00:00 / 1 hour) or the number of moves will reach it's maximum (10.000) the game will be over

# 👻 Features
- [x] Supports both `iPhone` & `iPad`
- [x] Moves counter
- [x] Timer
- [x] Solution validator
- [x] Rendering backend implemented on top of `SpriteKit`
- [x] Shuffling
- [x] Haptic Feedback for supported devices
- [x] Minimal supported `iOS` deployment target is `11.0`

# ⏱ Futher Improvements / Current Limitations
- [ ] Only **portrait** mode 
- [ ] Game **timer** works even when the app is in background (for a while). Ideally it needs to be paused/resumed when entering/resuming the app
- [ ] Missing **unit tests** coverage, despite the possibility to test most of the code
- [ ] Ideally, the in-game state needs to be modelled by **state machines** (`playing`, `shuffling`, `game over` and `puzzle solved` states, and when **solver** is implemented a new state for `solving` needs to be modelled as well)
- [ ] Missing **solver**: can be implemented by using `A*` or `BFS` algorithms. Since it's an `NP-complete` algorithm, it needs to be carefully designed and tested (performance implications)
- [ ] Add **macOS** target

# 👨‍💻 Author 
[Astemir Eleev](https://github.com/jVirus)

# 🔖 Licence
The project is available under the [MIT licence](https://github.com/jVirus/ios-15-puzzle/blob/master/LICENSE)

The project uses assets from [kenney.nl](https://kenney.nl) under [CC0 1.0 Universal (CC0 1.0)
Public Domain Dedication licence](https://creativecommons.org/publicdomain/zero/1.0/)
