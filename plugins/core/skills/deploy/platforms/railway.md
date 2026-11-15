# Railway

`<target>` is `<project>/<service>/<environment>`. Prefer the Railway MCP
tools when connected. Otherwise use the `railway` CLI.

## Status

- MCP: `environment-status`, `list-services`.
- CLI: `railway status`

## Current version

- MCP: `list-deployments`. Take the latest successful deployment ID.

## Deploy

- Normal path: merge to the branch the service watches. Railway builds it.
- Manual: MCP `redeploy`, or CLI `railway up --service <service>`.

## Logs

- MCP: `get-logs`.
- CLI: `railway logs --service <service>`

## Rollback

- MCP: `redeploy` the deployment ID from Current version.
- Or the Railway dashboard: Deployments, then Redeploy on the healthy one.
