# Railway

Use the Railway MCP tools when connected. Otherwise use the `railway`
CLI.

## Status

Each service in the environment has a successful latest deployment.

## Current version

The latest successful deployment ID of each service, and the commit it
built.

## Deploy

- Normal path: merge to the branch the service watches. Railway builds
  each merge.
- A manual upload lasts only until the next merge, or the next variable
  change, on that branch.

## Logs

Deployment logs for each service, from the deploy start time. A build
that crashes before the app starts may show no app logs at all.

## Rollback

Redeploy the deployment ID from Current version. A redeploy reuses that
deployment's settings, including its start command.
