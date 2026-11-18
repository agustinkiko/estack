# Docker Compose over SSH

A host that runs a plain git checkout with Docker Compose. If the host
runs code from release folders, use `compose-release-ssh` instead.

## Status

Every service in the compose project is running or healthy. A service
that keeps restarting is down.

## Current version

The commit of the checkout on the host. First confirm that the running
containers start from that checkout. Compose shows the config file path
of each project. If the path is outside the checkout, stop. The checkout
is not what runs, so a deploy from it ships the wrong code.

## Deploy

1. Check out the target branch on the host and pull it.
2. Rebuild and restart with Compose.
3. Other branches may run on the same host. Check ports before you start
   a second copy.

## Logs

Compose logs for the project, from the deploy start time.

## Rollback

Check out the commit from Current version, then rebuild and restart.
Confirm Current version shows that commit again.
