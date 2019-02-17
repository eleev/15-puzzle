# ios-15-puzzle [![Awesome](https://cdn.rawgit.com/sindresorhus/awesome/d7305f38d29fed78fa85652e3a63e154dd8e8829/media/badge.svg)](https://github.com/sindresorhus/awesome)

[![Language](https://img.shields.io/badge/language-Swift-orange.svg)]()
[![Framework](https://img.shields.io/badge/framework-SpriteKit-red.svg)]()
[![License](https://img.shields.io/badge/license-MIT-blue.svg)]()

![](logo-15_puzzle.png)

**Last Update: 17/February/2019.**

# ✍️ About
🧩 Classic 15 Puzzle game for iOS.

# 👻 Features
- [x] Supports both `iPhone` & `iPad`
- [x] Moves counter
- [x] Timer
- [x] Solution validator
- [x] Rendering backend implemented on top of `SpriteKit`
- [x] Shuffling
- [x] Haptic Feedback for supported devices
- [x] Minumal supported `iOS` deplyment target is `11.0`

# ⏱ Futher Improvements / Current Limitations
- [ ] Only **pornraint** mode 
- [ ] Game **timer** works even when the app is in background (for a while). Ideally it needs to be paused/resumed when entering/resuming the app
- [ ] Missing **unit tests** coverage, dispite the possiblity to test most of the code
- [ ] Ideally, the in-game state needs to be modeled by using **state machienes** (`playing`, `shuffling`, `game over` and `puzzle solved` states, and when **solver** is implemented a new state for `solving` needs to be modeled as well)
- [ ] Missing **solver**: can be implemented by using `A*` or `BFS` algorithms. Since it's an `NP-complete` algorithm, it needs to be carefully designed and tested (performance implications)
- [ ] Wish to add **macOS** target
- [ ] Was not able to implement shader **CRT** effect for cell's screes because of the time restrictions

# 📺 Demo 

# 👨‍💻 Author 
[Astemir Eleev](https://github.com/jVirus)

# 🔖 Licence
The project is availabe under the [MIT licence](https://github.com/jVirus/ios-15-puzzle/blob/master/LICENSE)

The project uses assets from [kenney.nl](https://kenney.nl) under [CC0 1.0 Universal (CC0 1.0)
Public Domain Dedication licence](https://creativecommons.org/publicdomain/zero/1.0/)
