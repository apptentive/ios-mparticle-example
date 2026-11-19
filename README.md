# Apptentive iOS Example

Example of a basic integration of an app with the Apptentive iOS SDK with mParticle.

## Requirements

- iOS 15.0+
- mParticle Apple SDK 9.x
- Apptentive kit for mParticle: `mParticle-Apptentive-7` (Apptentive iOS SDK 7.x)

The kit is maintained by mParticle in the [mParticle/mparticle-apple-sdk](https://github.com/mParticle/mparticle-apple-sdk/tree/main/Kits/apptentive/apptentive-7) repository.

## Setup

1. Run `pod install` and open `iOSExample.xcworkspace`.
2. In `AppDelegate.m`, replace the placeholders with your mParticle key and secret.
3. In the mParticle dashboard, connect the Apptentive integration with your Apptentive app key and signature.
4. Build and run. With the verbose log level, the Xcode console shows `Included kits: { Apptentive }` once the kit is active.

## Notes

- mParticle 9 no longer intercepts app delegate calls, so `AppDelegate.m` handles push notification events explicitly:
  - The device token and notification taps go to mParticle, and the kit passes them on to Apptentive.
  - Remote notifications from Apptentive go to `Apptentive.shared` directly, because the kit passes Apptentive an empty fetch completion handler. Other remote notifications go to mParticle. As a result, Apptentive pushes don't appear in mParticle's "push received" stats.
  - `willPresentNotification` goes to mParticle and then to `Apptentive.shared`, which hides Apptentive pushes in the foreground (Apptentive shows its own local notification instead). The kit doesn't forward this call.
- To test push notifications, use a real device, select a development team with the Push Notifications capability for `com.apptentive.iOSExample`, and upload an APNs key or certificate in the Apptentive dashboard.
- With CocoaPods and `use_frameworks!`, import the mParticle headers with `@import mParticle_Apple_SDK_ObjC;`.
- The Podfile's `post_install` hook raises pods that still declare iOS 13 to iOS 15, which Xcode 27 requires.

## QA notes

**Before testing**
- Set the mParticle key and secret in `AppDelegate.m`, and connect Apptentive in the mParticle dashboard. Without this the kit stays inactive: the survey event does nothing, and tapping Message Center only logs "Apptentive kit is not active yet".
- Push notifications need a real device, a development team with the Push Notifications capability for `com.apptentive.iOSExample`, and an APNs key or certificate in the Apptentive dashboard.

**What to check**
- The Xcode console shows `Included kits: { Apptentive }` after launch.
- Tapping the survey row shows the survey targeted to `survey_event`.
- Tapping Message Center opens Message Center.
- A reply sent from the Apptentive dashboard arrives as a push (app in the background) or as a single banner (app in the foreground). Tapping it opens Message Center.

**Known differences from a plain mParticle integration**
- Apptentive pushes don't appear in mParticle's "push received" stats, because the example sends them to Apptentive directly (see Notes).
- The kit itself doesn't forward `willPresentNotification` and passes Apptentive an empty fetch completion handler. Apps that forward push events only to mParticle may show two banners for an Apptentive message in the foreground, and new messages from a background push may arrive only on the next app launch. The example works around both, so QA shouldn't see them here.

## Testing an unreleased Apptentive SDK

To check the kit against a local checkout of [apptentive-kit-ios](https://github.com/apptentive/apptentive-kit-ios), uncomment this line in the Podfile and run `pod install`:

```ruby
pod 'ApptentiveKit', :path => '../apptentive-kit-ios'
```

Comment it out again and run `pod install` to go back to the released SDK.
