# prism_dashboard

`prism_dashboard` is the new Flutter Web admin console for PRiSM Next.

The UI is built around store operations rather than backend table shapes:

- Live operations are player-first. A player appears once, and their active sessions are flat details below the selected player.
- Player presence is derived from running timing items. An account can be usable, disabled, or banned; "在场/离店" is shown separately from that account status.
- Staff-facing copy avoids backend terms: sessions are shown as `计时项` or `费用` in the UI.
- The player preview shows stay duration, current estimated total, wallet balance, and per-session impact.
- The live desk matches the approved `player-first-session-detail-v9.html` shell: 230px grouped text sidebar, compact four-metric strip, player table on the left, and the selected player's bill table on the right.
- On desktop, the live player and bill panels keep their natural height when the visible rows fit; they scroll internally only when content exceeds the available workspace height.
- Stopping one session only ends that timer and leaves it unpaid; player-level checkout settles all unpaid sessions together.
- Pricing configuration uses time pickers, date pickers, segmented controls, switches, and numeric steppers instead of raw `HH:mm`, ISO, or millisecond fields.
- Copy is written for store staff, with developer payload fields hidden from normal workflows.

## Shared Admin Components

Commonly used UI blocks live in `lib/src/shared/`:
- **Layouts (`admin_layout.dart`)**:
  - `AdminWorkspace`: Standard page shell with title, subtitle, actions, and responsive page padding.
  - `AdminSplitPane`: Split layout (3:2) for desktop, auto-collapses to single detail panel on mobile.
  - `AdminDetailPanel`: Elegant detail card wrapper with internal scrolling support.
  - `FormSheet`: Bottom drawer on mobile, floating Dialog on desktop for form operations.
- **Tables (`admin_tables.dart`)**:
  - `AdminTablePanel`: Layout panel wrapping header titles, action buttons, list views with built-in Loading/Empty scaffold, and Y-axis internal scrolling limit.
- **Controls & Forms (`admin_forms.dart`)**:
  - `AdminToolbar`: Standard wrap-aligned toolbar row.
  - `StepperNumberField`: Numeric stepper with `-`/`+` click bounds.
  - `DateRangePickerButton`: Material-standard range selection button.
  - `ConfirmActionDialog`: Two-step verification alert for destructive operations.
- **Data Visuals (`widgets.dart`)**:
  - `MoneyText`: Currency styling with standard color highlights (red for negative values).
  - `DateTimeText`: Auto local-formatted timestamp labels.
  - Status helper pills: `PlayerStatusPill`, `ArchiveStatusPill`, `OrderStatusPill`, `DeviceStatusPill`, `StaffRolePill`, `StaffUserStatusPill`, `ApiTokenStatusPill`.

## API Contract Notes

- Dart models accept the current staff RPC view fields, including backend names such as `staffUsers`, `apiTokens`, `assetDefinitions`, `businessItems`, `pricingConfigs`, nested settings, and report `summary` payloads.
- `ApiToken.token` is treated as a one-time secret: it can be read after creation, but it is omitted from `toJson()` and not printed by model `toString()`.
- `PrismApiClient` exposes the staff session operations needed by the live desk: preview one timing item, checkout one timing item, preview all, checkout all, stop one timing item, list active timing items, and bulk checkout.

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
