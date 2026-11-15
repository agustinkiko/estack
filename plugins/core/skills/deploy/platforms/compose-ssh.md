# Docker Compose over SSH (home lab)

`<target>` is `<user>@<host>:<app-dir>`. Split it into `<user>@<host>`
and `<app-dir>`.

## Status

```bash
ssh <user>@<host> "cd <app-dir> && docker compose ps"
```

## Current version

```bash
ssh <user>@<host> "cd <app-dir> && git rev-parse --short HEAD"
```

## Deploy

```bash
ssh <user>@<host> "cd <app-dir> && git fetch && git checkout <branch> && git pull && docker compose up -d --build"
```

## Logs

```bash
ssh <user>@<host> "cd <app-dir> && docker compose logs --since 5m"
```

## Rollback

```bash
ssh <user>@<host> "cd <app-dir> && git checkout <version> && docker compose up -d --build"
```

## Notes

Other branches may run on the same host. Check ports before starting a
second copy.
