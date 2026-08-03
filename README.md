# viaO

A scalable Flutter starter using Provider, feature-first organization, named
routes, responsive UI helpers, centralized theming, and isolated reusable
widgets.

The app bundles General Sans for global typography and branded headings. It
opens with a responsive branded splash screen before routing to Home.

## Structure

```text
assets/
  fonts/
  images/
lib/
  app/                    # bootstrap, root app, provider registration
  core/
    constants/            # app-wide values and typed asset paths
    extensions/           # BuildContext responsive helpers
    routes/               # route names and route generation
    screens/              # app-wide fallback screens
    theme/                # colors and light/dark ThemeData
    widgets/              # reusable app-wide widgets
  features/
    auth/
      providers/
      screens/
      services/
      widgets/
    home/
      models/
      providers/
      screens/
      services/
      widgets/
    splash/
      screens/
    settings/
      providers/
      screens/
      widgets/
```

## Adding a feature

Create a folder in `lib/features`, keep business state inside its provider,
external data access inside services/repositories, and split reusable UI into
one widget per file. Register app-level providers in
`lib/app/app_providers.dart` and routes in `lib/core/routes`.

For custom fonts, add licensed files to `assets/fonts`, declare the family in
`pubspec.yaml`, and apply the family once in `AppTheme`.

Authentication uses one reusable gradient scaffold for Login and onboarding:
Create Account → Verify Email → Profile Setup → Vehicle Details → Permissions.
Font families remain centralized in `AppFonts` and `AppTextStyles`.
