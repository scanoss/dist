# Earnie v0.7.0

Released 2026-11-01.

Images:

- `ghcr.io/scanoss/earnie/earnie-api:v0.7.0`
- `ghcr.io/scanoss/earnie/earnie-web:v0.7.0`

## Earnie v0.7.0

A new look for the console. Every page keeps its place and its workflow; what changes is how it reads.

### What's new

**A refreshed console**
- New typography: serif page titles and figures, a sans for text and a monospace for data.
- Calmer colour. Orange now marks only the primary action, keyboard focus, alerts and reachable findings. The dark theme is a neutral near-black instead of navy.
- Page headers open with a one-line verdict, show where the data comes from, and keep the longer description in a popover.
- Lists of policies, scans and self-checks carry a verdict mark in a left gutter, so the state of each row reads at a glance.
- Settings and scan configuration read as a spec sheet: a label and its value on each row.
- Members and Policies end with a provenance footer that includes the organization's last sign-in.
- Page-level empty states show the Earnie owl.

**Filtering**
- One filter bar across the console: type a field, pick a value, and each filter becomes a token you can edit or remove. It now filters Policies, the Inventory lists, Scan history, Self-checks, the organization and settings lists, and the Review filter row. Its field picker is searchable.

**Dashboards**
- Dashboards read as one ruled report grid.
- Gate over time draws stacked bars of projects by gate, per day.
- The organization status line takes the same verdict shape as page headers.
- The dashboard cards no longer open a View drawer.

### Fixes
- The Projects table stays inside its dashboard card.
- Audit log event labels read as product copy instead of internal event names.
- The logo, favicons and browser theme colour match the console's ink colour.

### Upgrading
No new `tenant.env` keys, no removed keys, and no new database migrations. Follow the usual upgrade steps.

