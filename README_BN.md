# SM TV — Android MVP

এটি SM TV random-video-chat অ্যাপের প্রথম Android project structure।

## এখন যা আছে
- SM TV branding ও mobile UI
- Login / Sign Up screens
- Random matching flow
- Video call UI
- Next / Cancel flow
- People / Profile screens
- Camera ও microphone permission প্রস্তুত
- WebView-based Android shell

## Android Studio
1. Android Studio খুলুন
2. এই project folder `SMTV_Android_MVP` Open করুন
3. Gradle Sync করুন
4. Android phone/emulator চালু করে Run দিন

## গুরুত্বপূর্ণ
এটি এখনো production live-video service নয়। আসল OmeTV-style 1-to-1 video call চালাতে backend signaling, WebRTC peer connection, matchmaking queue, authentication/database, moderation, report/block এবং abuse prevention যুক্ত করতে হবে।
