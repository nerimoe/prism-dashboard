# prism_dashboard

`prism_dashboard` is the new Flutter Web admin console for PRiSM Next.

The UI is built around store operations rather than backend table shapes:

- Live operations are player-first. A player appears once, and all active plus stopped-but-unpaid sessions under that player are flat timing items in the selected player's detail.
- Player presence is derived from whether at least one timing item is still running. Account status (`active`, `disabled`, `banned`) is shown separately and never means "在场" or "离店" by itself.
- Staff-facing copy avoids backend terms: sessions are shown as `计时项` or `费用` in the UI.
- The account menu is available on both the compact app bar and desktop sidebar. Choosing `退出登录` revokes the administrator session on the backend, clears the locally saved token even if the revoke request cannot reach the server, and returns the panel to the login screen.
- The login card shows the Dashboard build version. After login, the desktop sidebar and the compact account menu show both the frontend build and the backend version returned by public `GET /version`; unavailable legacy backends are shown as unknown without blocking login.
- The installation flow asks for the store time zone and keeps the generated integration and machine keys in memory until staff acknowledge a non-dismissible one-time-secret dialog. Normal settings saves merge into the raw settings document so editing the store name or coin cooldown never deletes Home Assistant credentials or unrelated extension settings.
- The player preview shows stay duration, current estimated total, wallet balance, and per-session impact.
- The selected player's bill keeps the compact `pricingCharges` summary and adds `pricingSegments` for the actual charged ISO time range, matched rule range, duration, final segment amount, and an interval-cap badge only after that interval has reached its cap. When legacy data has only `pricingCharges`, the detail area explicitly reports that the billing detail is unavailable. `globalCapWindows` are grouped by their anchored cap window; each collapsed row shows the local anchor date plus rule label, complete range, historical included amount, current participating amount, cap target, and current included result. Expanded rows list the participating items without presenting a cap difference as a discount.
- Live desk metrics are derived from the live player RPC response. Do not show placeholder operational numbers unless a real backend read model provides them.
- Browser previews and click checks must run against the local PRiSM Bun backend. The app may use mocked HTTP clients in widget tests, but visible screens must not be validated with preview stubs or hard-coded demo rows.
- The live desk matches the approved `player-first-session-detail-v9.html` shell: 230px grouped text sidebar, compact four-metric strip, player table on the left, and the selected player's bill table on the right. The sidebar contains one entry per real module; sub-workflows such as store settings, staff users, and access keys live inside their module tabs instead of duplicating sidebar destinations.
- On desktop, the live player and bill panels keep their natural height when the visible rows fit; they scroll internally only when content exceeds the available workspace height.
- Stopping one session only ends that timer and leaves it unpaid. The stopped item remains visible in the player's bill as `已停止 / 待结账`, and player-level checkout settles it together with any still-running timing items.
- Starting an extra timing item lets staff choose the pricing plans for that specific item. A mahjong timer, a music game timer, and a custom service timer under the same player can therefore keep separate billing behavior.
- The live desk can start the first timer for a player who is not currently on the live list. Live operations poll every 20 seconds, while the device dashboard polls every 15 seconds when no device command is in flight.
- The live desk's temporary price change is a real settlement override: staff enter the final amount and reason, then the dashboard calls the staff checkout override RPC.
- Player profiles display migrated external bindings such as QQ numbers from the staff player list response.
- Player profiles use a searchable roster on the left and a structured detail view on the right; search matches display name, migrated identity values such as QQ, account status, and balance text.
- Player profiles default current holdings to backend-classified available assets and provide `可用` / `无效` / `全部` filters. Invalid rows show backend-provided reasons such as holding expiry or archived definitions; the Flutter client never recalculates availability from its own clock.
- Player profiles use the dedicated wallet-adjustment RPC for balance corrections, identify asset adjustments by the selected holding ID, and load full settlement detail when a history row is opened.
- Pricing configuration is a real multi-plan editor: time-based plans can contain multiple priority rules with weekdays, specific dates, time pickers, numeric steppers, and a day-ring preview; global cap timelines select which time-based plans participate and edit cap-only rules; fixed-charge plans are edited separately without fake time rules. Pricing plans sit above the editor, while the day-ring preview and effective timing list stay in the left column and editable fields stay in the right column, so preview refreshes do not disturb staff input. Saved archived time rules stay out of the active timing list and are shown in a separate archive section.
- Pricing plan cards and details expose a copyable `计费方案 ID`; this is the value external entry points, self-service pages, and bot plugins should pass as `pricingConfigIds`, for example in AstrBot `login_pricing_configs`.
- Copy is written for store staff, with developer payload fields hidden from normal workflows.
- Migrated legacy names, asset codes, and ledger reasons are softened at the UI edge so staff see Chinese operational wording while API payloads keep the original IDs.
- Text fields remain the right control for free-form content such as plan names, rule labels, search terms, staff notes, and display copy. Numeric business values such as prices, caps, minutes, limits, and stock counts use direct number inputs with optional +/- micro-adjust buttons; staff must never be forced to click up from zero for normal values. Money fields accept decimals, and time-rule unit prices may be negative for additive discount timers. Structured pickers are reserved for values where free typing causes real mistakes: dates, clock times, status choices, and switches.
- Archived business objects stay out of the primary working lists. Pricing plans, pricing rules, asset definitions, presents, and service items each use a dedicated collapsed archive section with restore actions inside it.
- Asset and gift management is split into four business tabs: `资产定义`, `计费效果`, `礼物`, and `兑换码`. Each tab owns its primary action inside that tab (`添加资产`, `添加计费效果`, `新建礼物`, `生成兑换码`) instead of sharing a global action row, so staff never open a pricing-effect form while they are working in redeem-code results.
- Asset and gift tabs switch content immediately on click. Do not wait for the underline animation before showing the selected tab's workspace; staff often bounce between assets, effects, gifts, and codes while checking one setup.
- Asset definitions use a workspace layout instead of large form dialogs: staff select an asset from the list, review its detail, edit its name, category, stack behavior, pricing effect, active window, expiry window, and archive state in the side panel, and save without losing context. New assets also open as a draft detail panel.
- Pricing effects have their own tab with active and archived effect lists. Creating an effect opens an inline workbench that groups fields into basic information, settlement behavior, targeting scope, and active window.
- Present management uses a list/detail workspace. Creating a present opens an inline workbench instead of a modal, so staff can keep the existing present list and selected detail in view while adding content rows. The detail panel shows gift content by configured asset name, not backend type/code pairs, and includes linked redeem-code counts so staff can see whether a gift is already bound to usable, used-up, or revoked codes before archiving it.
- Gift content should be treated as versioned once codes are bound to it. A future edit flow may allow direct edits before any code exists, but once a gift has codes or redemption history, staff should archive it and create a replacement gift so old CDKs keep their original meaning.
- Redeem code management does not expand every code into the page. The tab behaves like an operations query desk: staff can filter by bound present, usage status, player display name, code text, redemption date range, and code availability window, then sort by creation time, redemption time, expiry time, usage count, or present name. The count chips themselves remain usage-status filters (`全部` / `可继续使用` / `已使用` / `不可使用`). Every code row has its own clipboard action, so staff copy the specific code they need without selecting a bulk text block. Code generation opens an inline generation panel, supports both one-off codes and batch creation with prefix, count, use limit, active time, and expiry time, and does not interrupt the current query result. Used-code rows expose a `查看玩家` action that jumps to the player profile.
- Batch redeem-code results remain in a dedicated result panel until staff clear them. The panel previews the first 20 values and can copy the complete batch without depending on the shortened list view.
- Viewer-role staff can still browse, filter, refresh, copy, and open audit details, but mutation controls are disabled or omitted across live operations, players, assets, pricing, devices, and system administration. Manager/owner users keep ordinary business write workflows; staff-account and access-key management remain owner-only and are not requested for other roles.
- Time display is centralized in `lib/src/shared/time_format.dart` and converted through the configured store time zone: timestamps use `YYYY-MM-DD HH:mm`, date-only values use `YYYY-MM-DD`, and pure clock values such as timeline ticks use `HH:mm`. Report date pickers also produce UTC query boundaries from that store time zone rather than the browser machine time zone.

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
- **Display labels (`token_role_labels.dart`)**:
  - `tokenRoleLabel` maps backend API token roles to staff-facing Chinese copy outside feature screens, keeping raw role names out of normal UI literals.

## API Contract Notes

- Dart models accept the current staff RPC view fields, including backend names such as `staffUsers`, `apiTokens`, `assetDefinitions`, `businessItems`, `pricingConfigs`, nested settings, and report `summary` payloads.
- `ApiToken.token` is treated as a one-time secret: it can be read after creation, but it is omitted from `toJson()` and not printed by model `toString()`.
- `PrismApiClient` exposes the staff session operations needed by the live desk: preview one timing item, checkout one timing item, preview all, checkout all, stop one timing item, list active timing items, and bulk checkout. Live desk session rows read `endedAt` for stopped-but-unpaid timers and show the stop time in the bill, while the duration comes from the backend `elapsedMinutes`.
- Player list models include `identities`, so migrated QQ/Aime/scan bindings can be shown without a second detail lookup. The player detail panel can remove a single binding through the staff identity delete RPC.
- Player ledger and timer history rows open secondary detail dialogs. The compact detail panel shows recent rows with full local date and time, while the dialogs expose the full visible list and per-record fields such as linked staff action, transaction batch, duration, and current billing impact.
- Player redeem records are loaded from `/rpc/staff/players/:playerId/redeem-records` and shown as a normal audit section in the player detail panel, with the gift name, code, and full local redemption time.
- Player asset preview rows use backend `availability` and `unavailableReasons`, plus the holding's active and expiry windows. Available assets are shown by default; staff can switch to invalid or all holdings to inspect expired monthly cards, future-dated gifts, missing definitions, and archived definitions without changing stored data.
- Player asset actions are driven by active asset definitions: staff choose a named asset from the configured catalog when granting, and adjust a specific holding from that asset row instead of entering raw `type`/`code` values.
- Asset management keeps staff on configured business objects: asset category is selected from known categories, pricing effects are selected from saved effects, present grants select an active asset definition, and redeem codes select an active present instead of asking for backend IDs.
- Pricing effect dialogs expose business targeting controls: staff can limit an effect to selected timing names, saved pricing plans, and specific pricing rules. The UI writes those choices to the effect `config` so settlement applies the asset only to the matching charges.
- Pricing effect creation now uses the same inline workspace pattern as assets, presents, and redeem codes, so complex targeting controls no longer live in a modal dialog.
- Asset, pricing effect, present, and redeem code APIs follow the staff RPC contract: asset definitions use `name/status`, may bind `pricingEffectId`, and carry optional active/expiry windows; presents own multiple grant rows; redeem codes reference `presentId` with `maxUseCount` instead of carrying grant rows directly. Staff redeem-code rows read `usageCount` plus redemption people/times, which are aggregated from redemption records so migrated used CDKs are visible as used and staff can see who used them.
- Asset, present, redeem code, and present-content windows are edited with Material date/time pickers. If a redeem code or present is expired, redemption is rejected; if only a present grant row is expired, the redemption is recorded and that content is skipped.
- Pricing APIs use the backend `time.priority`, `time.cap`, and `charge.fixed` shapes directly. Time rules are sent under `provider.rules`, time ranges live in `timeRange` or migrated `dateTimeRange`, and price fields live in `pricing`. Global cap timelines send `provider.includedPricingConfigIds` plus cap rules whose `priceCap` sits on the rule itself, while preserving the edited `timeRange` instead of falling back to full-day `00:00-00:00`. Fixed charges send `provider.label` and `provider.amount`. Timeline previews read backend `segments` and render the day ring from backend `startMinute` / `endMinute`; closed segments legitimately omit pricing and are rendered with a zero display amount. `time.cap` previews use the same ring and display each segment's cap amount, so cross-day and migrated date-scoped rules stay aligned with settlement behavior. Existing pricing configs keep their original type when edited; staff must click `新建方案` to add a separate global cap timeline.
- Pricing amount inputs preserve decimal values when saving `unitPrice`, `priceCap`, and fixed-charge `amount`; integer-only controls are reserved for actual integer concepts such as minutes, priority, and usage counts.
- The pricing screen keeps "new plan" as an explicit draft state. Clicking `新建方案` opens a fresh editor and saves with `POST /rpc/staff/pricing-configs`; selecting an existing row exits draft mode and saves with `PATCH`.
- Saved time rules are archived rather than removed from a pricing config. New unsaved draft rows can be removed, but existing rules are saved back with `status: "archived"` so settlement history and cap tracking can still resolve their rule ids. Archived rules are edited from a dedicated archive section and can be restored from there; they should not appear in the active timing list or day-ring preview. Editing an archived pricing config saves back to the same config id and keeps it archived/disabled until staff explicitly restore it.
- Service item APIs use the staff business item contract: create requests include `kind`, `name`, `price`, optional issued content (`assetType`/`assetCode`), sale window dates, and `metadata: null` unless an advanced workflow provides metadata. Normal UI copy uses `下架`, `恢复售卖`, `待出品`, `核销`, and `取消订单` instead of raw backend state names.
- Device APIs read facility states from `/rpc/staff/device-states`, machine software connections from `/rpc/staff/machine-connections`, and recent commands from `/rpc/staff/device-commands`. The device page separates `设施设备` from `游戏机器`: Home Assistant / facility rows show door, power, AC, and light status; machine rows show WebSocket online state, capabilities, and last heartbeat. Staff with write access can send power, door-open, AC-temperature, coin, and Aime actions through `POST /rpc/staff/device-actions`, which returns the created command so immediate executor failures can be shown inline. All-facility power commands legitimately return a null `deviceId` with `target.all = true`; their audit rows render the user-facing label `所有设备`. The dashboard converts raw device/command statuses into staff-facing labels such as `在线`, `离线`, `故障`, `待执行`, `已确认`, and `已超时`, while keeping payload and metadata details out of the normal view.
- Dashboard API parsing follows only the current response field names. Facility actions send the displayed device name as `target.ref`; Home Assistant entity IDs remain backend/audit identifiers and are not rendered on facility cards or used as staff input. Game-machine actions continue to use the machine ID as `target.id`.
- Report APIs use the staff `reports/summary`, `reports/settlements`, and `reports/players` RPCs with ISO query parameters generated from picker-based date ranges. Settlement and player lists use `limit`/`offset` pages and explicit load-more actions instead of silently truncating results. The summary's legacy `assetGrantTotal` field is rendered as asset-ledger entry count, not as a sum of unrelated asset quantities.
- System APIs use staff settings, staff users, and API token RPCs directly. Staff enable/disable actions send backend `status` values, and newly created API token secrets are shown once in a dedicated dialog. Created API token roles are limited to store integrations (`integration`, shown as `机器人/店内入口`) and machine software (`machine`, shown as `机器软件接入`); the dashboard defaults new keys to `integration`, and shared player API tokens are no longer created from Staff Web.
- Access-key creation failures must stay visible in the creation dialog. If the backend rejects a request because the staff role is not allowed, the token service is unavailable, or the session expired, the dialog shows the backend message instead of silently staying open.
- `test/copy_constraints_test.dart` guards normal feature UI copy against developer-facing words such as raw provider/session/payload/metadata labels.

Useful commands:

```bash
flutter pub get
# Generated model files are ignored by Git; run code generation after checkout.
flutter pub run build_runner build --delete-conflicting-outputs
# Clean code generation cache
flutter pub run build_runner clean
flutter analyze --no-pub
flutter test --no-pub
flutter build web --no-pub # local build after code generation
```

The root `bun run prism-dashboard:build` wrapper runs model generation before the release build.

Startup does not contact an API until staff explicitly submit the login or
setup screen's server connection action. The login screen renders immediately;
loading saved preferences and persisting changes never blocks it. API requests
have a 10-second timeout.

From the repository root, use:

```bash
bun run prism-dashboard:analyze
bun run prism-dashboard:test
bun run prism-dashboard:build
```

The root build wrapper injects the shared SemVer from `prism-next/package.json` and this submodule's Git short revision through Dart defines. Use the root `bun run version:bump patch|minor|major` command to keep `pubspec.yaml` synchronized with the backend release version.
