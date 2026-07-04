# prism_dashboard

`prism_dashboard` is the new Flutter Web admin console for PRiSM Next.

The UI is built around store operations rather than backend table shapes:

- Live operations are player-first. A player appears once, and their active sessions are flat details below the selected player.
- Staff-facing copy avoids backend terms: sessions are shown as `计时项` or `费用` in the UI.
- The player preview shows stay duration, current estimated total, wallet balance, and per-session impact.
- The live desk matches the approved `player-first-session-detail-v9.html` shell: 230px grouped text sidebar, compact four-metric strip, player table on the left, and the selected player's bill table on the right.
- On desktop, the live player and bill panels keep their natural height when the visible rows fit; they scroll internally only when content exceeds the available workspace height.
- Stopping one session only ends that timer and leaves it unpaid; player-level checkout settles all unpaid sessions together.
- Pricing configuration uses time pickers, date pickers, segmented controls, switches, and numeric steppers instead of raw `HH:mm`, ISO, or millisecond fields.
- Copy is written for store staff, with developer payload fields hidden from normal workflows.

Useful commands:

```bash
flutter pub get
# Run code generation for freezed models
flutter pub run build_runner build --delete-conflicting-outputs
# Clean code generation cache
flutter pub run build_runner clean
flutter analyze --no-pub
flutter test --no-pub
flutter build web --no-pub
```

From the repository root, use:

```bash
bun run prism-dashboard:analyze
bun run prism-dashboard:test
bun run prism-dashboard:build
```
