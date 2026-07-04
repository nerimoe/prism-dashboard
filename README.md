# prism_dashboard

`prism_dashboard` is the new Flutter Web admin console for PRiSM Next.

The UI is built around store operations rather than backend table shapes:

- Live operations are player-first. A player appears once, and all active sessions under that player are flat timing items in the selected player's detail.
- Player presence is derived from whether at least one timing item is still running. Account status (`active`, `disabled`, `banned`) is shown separately and never means "在场" or "离店" by itself.
- Staff-facing copy avoids backend terms: sessions are shown as `计时项` or `费用` in the UI.
- The player preview shows stay duration, current estimated total, wallet balance, and per-session impact.
- Live desk metrics are derived from the live player RPC response. Do not show placeholder operational numbers unless a real backend read model provides them.
- Browser previews and click checks must run against the local PRiSM Bun backend. The app may use mocked HTTP clients in widget tests, but visible screens must not be validated with preview stubs or hard-coded demo rows.
- The live desk matches the approved `player-first-session-detail-v9.html` shell: 230px grouped text sidebar, compact four-metric strip, player table on the left, and the selected player's bill table on the right. The sidebar contains one entry per real module; sub-workflows such as store settings, staff users, and access keys live inside their module tabs instead of duplicating sidebar destinations.
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
- Asset, present, and redeem code APIs follow the staff RPC contract: asset definitions use `name/status`, presents own their grant rows, and redeem codes reference `presentId` with `maxUseCount` instead of carrying grant rows directly.
- Pricing APIs use the backend `time.priority` provider shape: rules are sent under `provider.rules`, time ranges live in `timeRange`, and price fields live in `pricing`. Timeline previews read backend `segments` and render them as staff-facing day segments.
- Service item APIs use the staff business item contract: create requests include `kind`, `name`, `price`, optional issued content (`assetType`/`assetCode`), sale window dates, and `metadata: null` unless an advanced workflow provides metadata. Normal UI copy uses `下架`, `恢复售卖`, `待出品`, `核销`, and `取消订单` instead of raw backend state names.
- Device APIs read `deviceStates` and `commands` from staff RPCs. The dashboard converts raw device/command statuses into staff-facing labels such as `在线`, `离线`, `故障`, `待执行`, `已确认`, and `已超时`, while keeping payload and metadata details out of the normal view.
- Report APIs use the staff `reports/summary`, `reports/settlements`, and `reports/players` RPCs with ISO query parameters generated from picker-based date ranges. The UI shows store-facing metrics, settlement rows, and player rankings without exposing raw report IDs or ISO input fields.
- System APIs use staff settings, staff users, and API token RPCs directly. Staff enable/disable actions send backend `status` values, and newly created API token secrets are shown once in a dedicated dialog.
- `test/copy_constraints_test.dart` guards normal feature UI copy against developer-facing words such as raw provider/session/payload/metadata labels.

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
