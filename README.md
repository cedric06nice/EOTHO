# Eat Out To Help Out Calculator

An iPhone and iPad app that worked out the UK's **Eat Out to Help Out** discount on a restaurant bill. I built it in about five days in August 2020.

**Status: retired.** The app was removed from the App Store after the scheme closed on 31 August 2020. It was free and was downloaded 1,325 times.

Portfolio page, with support and privacy policy: **https://cedric06nice.com/eat-out-to-help-out/**

<p>
  <img src="screenshots/en-GB/iPhone%2011%20Pro%20Max-0-Main-screen.png" width="200" alt="Empty calculator with covers, food and discount fields">
  <img src="screenshots/en-GB/iPhone%2011%20Pro%20Max-1-Calculator.png" width="200" alt="Custom adding-machine keypad with £38.40 entered">
  <img src="screenshots/en-GB/iPhone%2011%20Pro%20Max-2-Screen-with-result.png" width="200" alt="Result: £19.20 saving for 2 covers">
  <img src="screenshots/en-GB/iPhone%2011%20Pro%20Max-3-Screen-with-percentage.png" width="200" alt="Result with a 20% house discount: £15.36 saving">
</p>

## Why it exists

In August 2020, the scheme gave diners 50% off food and non-alcoholic drinks, Monday to Wednesday, up to £10 per person. The ePOS system at my restaurant couldn't apply the discount yet, so staff had to work out every eligible bill by hand. I built this so my team could get it right at the table. I then published it on the App Store, where other restaurants used it too.

## How it works

1. Enter the number of covers.
2. Total the food and soft drinks on the built-in adding-machine keypad, which has `+`, `−`, `=` and `C`.
3. Optionally, enter a house discount as a percentage, then tap **Calculate**.

The calculation, in `ViewController.calculate()`:

```text
discounted = food − food × discount%
perHead    = discounted ÷ covers
saving     = perHead ≥ £20 ? covers × £10 : covers × perHead ÷ 2
```

Example: 2 covers and £38.40 gives a saving of £19.20. With a 20% house discount the saving is £15.36.

## Tech

- **Swift 5 and UIKit**, laid out in storyboards with Auto Layout.
- **A custom keypad** (`EOTHO/Keyboard/`). It loads from a XIB, is set as the food field's `inputView`, and reports back through a `KeyboardDelegate` protocol.
- **fastlane snapshot.** UI tests in `EatOutToHelpOutScreeshots/` capture the App Store screenshots on 9 iPhone and iPad simulators.
- No third-party dependencies, no network access, no persisted data.
- Runs on iOS 13.0 or later, on iPhone and iPad. Portrait only on iPhone; any orientation on iPad.

```text
EOTHO/
├── ViewController.swift      # form, validation, calculation
├── Keyboard/                 # adding-machine keypad (XIB + delegate)
├── Base.lproj/Main.storyboard
└── Assets.xcassets/
EatOutToHelpOutScreeshots/    # UI tests driving fastlane snapshot
fastlane/                     # Snapfile, Fastfile
```

## Build

Open `EOTHO.xcodeproj` in Xcode and run the **EOTHO** scheme on a simulator.

To regenerate the screenshots:

```bash
bundle install
bundle exec fastlane snapshot
```

`bundle exec fastlane screenshots` also frames the screenshots and uploads them to App Store Connect. Don't run it now that the app is retired.

## Release history

- **1.1** (August 2020): partly fixed text being cut off at larger text sizes.
- **1.0** (August 2020): first release.

## What I'd do differently today

- **SwiftUI with Dynamic Type from the start.** Version 1.1 only partly fixed text being cut off at larger sizes.
- **`Decimal` for money.** With `Double`, a bill can come out a penny wrong.
- **The rules as a pure, unit-tested function.** This would cover the £10 cap, the order the discounts are applied in, and the Monday-to-Wednesday check. The app left the day check to staff.
- **VoiceOver labels on the keypad,** and accessibility identifiers in the UI tests rather than tapping buttons by their visible text.
- **An end date built in,** so the app could tell people when the scheme had closed.

## Privacy

The app collected nothing. It had no accounts, analytics, ads, network requests or stored data. See the full [privacy policy](https://cedric06nice.com/eat-out-to-help-out/#privacy).

## Disclaimer

This is an unofficial app. It is not affiliated with or endorsed by HM Treasury, HMRC or Apple. Eat Out to Help Out was a UK Government scheme that ran in August 2020.

© 2020 cedric06nice. All rights reserved.
