# PeerNODE

Serverless P2P messaging — no servers, no middlemen.

## Features
- End-to-end encrypted chat (Ed25519 / PointyCastle)
- Drift SQLite reactive streams (Contacts, Messages, Groups, Polls)
- Deep-link integration (`peernode://` URI scheme via `uni_links`)
- QR identity sharing (`qr_flutter`)
- WhatsApp-style Clear Chat History (`clearChatHistory` / `clearGroupHistory`)
- Self-destruct message timer fields + service
- Poll voting (`poll_model.dart`)
- WebRTC signaling (`flutter_webrtc`)
- P2P networking (`nearby_connections`, `libp2p` placeholder)
- Media pipeline: compression, thumbnail extraction, on-demand extraction
- Android Foreground Service for silent message reception
- Dark theme (`#1E1E2E` / `#64FFDA` teal)

## Build
```bash
flutter pub get
flutter build apk --release
```

## Security
- Crypto identity: device-local Ed25519 keys, `flutter_secure_storage`
- P2P identity: local QR scanning only
- All messaging data: local Drift SQLite only
- No confidential data pushed to unverified repos without APK verification

## Verified Release
Repo verified by user. APK pushed to releases upon successful `flutter build apk --release` (blocked locally by deprecated Android v1 embedding; cloud Actions pipeline `.github/workflows/android_build.yml` handles build/upload).
# PeerMESH
