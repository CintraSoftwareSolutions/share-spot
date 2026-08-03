# viaO feature structure

The app is organized by user role so guest and host work can evolve without
mixing their screens or state.

```text
features/
  common/   # Pre-role flows and composition (auth, splash, settings)
  guest/    # Guest-only screens, providers, services and models
  host/     # Host-only screens, providers, services and models
  shared/   # Reusable role-neutral widgets and their display models
```

Dependency rules:

- `guest` and `host` may use `shared` and `core`.
- `shared` must not import from `guest` or `host`.
- `guest` and `host` must not import from each other.
- `common` may compose guest and host entry points where the current role is
  selected.
- `shared` contains no screens, providers, services, repositories or API calls.
- Host and guest screens pass their own data and callbacks into shared widgets.
- Put a widget in `shared` only when both roles genuinely use the same UI.

Each role feature keeps its own providers, screens, services, repositories and
API integration. Display-only models may live beside shared widgets; backend
DTOs and domain models stay inside the relevant role. Global routes remain in
`core`, while global Provider registration remains in `app`.
