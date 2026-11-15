# Vercel

`<target>` is the Vercel project name.

## Status

```bash
vercel ls <target>
```

## Current version

```bash
vercel ls <target> --prod
```

Take the newest `Ready` deployment URL.

## Deploy

- Normal path: merge to `main`. Vercel builds it.
- Manual: `vercel --prod`

## Logs

```bash
vercel logs <deployment-url>
```

## Rollback

```bash
vercel rollback <deployment-url-from-current-version>
```
