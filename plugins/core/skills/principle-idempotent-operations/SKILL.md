---
name: principle-idempotent-operations
description: Apply when writing jobs, queue tasks, webhooks, migrations, backfills, deploy or setup scripts, or anything that can run twice. A second run must give the same result as the first.
---

# Idempotent operations

- Assume every job runs twice. Queues retry, people rerun scripts, and
  deploys restart halfway.
- Check before you create: upsert, `IF NOT EXISTS`, or a unique key that
  rejects the copy. Never "insert, then hope".
- Give each request or event an ID. Record the ID when the work is done.
  A repeat with the same ID does nothing.
- Key each side effect so a repeat can see it already happened. Emails,
  payments, and external API calls cannot be undone.
- A script that changes data takes a dry run and prints what it would
  change. The real run changes only rows the dry run listed.
- Prove it: run the operation twice in a test and assert the second run
  changed nothing.
