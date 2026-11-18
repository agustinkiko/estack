# Docker Compose release folders over SSH

A host that keeps one folder per release. The containers mount code from
the current folder. Use `compose-ssh` when the host runs a plain git
checkout.

## Status

Every service in the compose project is running or healthy.

## Current version

Two facts for each service: the release folder it mounts its code from,
and the config file it started from. Compose records that file in a
label on each container. Read it there. Do not assume it sits in the
code folder, because a config-only change can live in a folder of its
own.

- Every service must mount code from the same folder. If they differ, a
  release is half done. Stop and ask.
- Services may have started from different config files. Take the
  newest one. It must define every service the same way as the file
  that service started from. If it does not, stop and ask.

## Deploy

1. Stop if the release changes dependencies or images. This process
   ships code only.
2. Make a new release folder. Never reuse or overwrite an existing one.
   The old folders are the rollback history.
3. Copy the code for the new commit into it. Copy the files that are not
   in git from the current release.
4. Make the new release config from the config file in Current version.
   Change only the code folder. Save the old config in the new folder as
   its rollback config.
5. Compare the two configs. Only the code folder may differ. Any other
   change, such as a new env var, needs its own yes.
6. Dry run each service first. Then replace the services one at a time,
   in the order the repo gives.
7. Never deploy from an old checkout on the host. It may not be what
   runs.

## Logs

Compose logs for the replaced services, from the deploy start time.

## Rollback

Start each service again from the rollback config, in the same order.
Confirm Current version shows the old code folder again. Database changes do not roll back this way.
