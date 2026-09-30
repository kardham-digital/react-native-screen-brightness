# Conventions

## Commits

```text
<type>: <description>
<platform>: <type> <description>
```

- `type` — `feat`, `fix`, `chore`, `refactor`, `docs`, `test`.
- `platform` — `Android` or `iOS`, only when the change is limited to one
  platform.
- `description` — English, imperative mood, starting lowercase, no trailing
  period.

No `Co-Authored-By` trailer.

Examples: `docs: document platform prerequisites`,
`iOS: fix brightness not restored on background`.

## Branches

```text
<type>/<short-description>
```

`short-description` in kebab-case, English: `docs/platform-prerequisites`.

## Hook

`.githooks/commit-msg` checks the commit subject. Enable it once per clone:

```bash
git config core.hooksPath .githooks
```
