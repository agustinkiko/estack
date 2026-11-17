---
name: change
description: Use for any infrastructure or pipeline change (Terraform, Kubernetes, CI/CD, cloud config). Adds the ticket, plan, review, and approval steps on top of the core workflow.
---

# Change

The company process (ticket key, reviewers, approver, change window,
change tool, incident process) is in the "Process" section of the repo's
`AGENTS.md`. This skill never holds company details.

## 1. Ticket

Every change links to a ticket. No ticket? Stop and ask.

## 2. Build and plan

1. `core:dev-start`, then make the change.
2. Save the plan to `.artifacts/<task>/plan.txt`:

   | Tool | Plan command |
   |---|---|
   | Terraform | `terraform plan -out=plan.tfplan && terraform show -no-color plan.tfplan` |
   | Kubernetes | `kubectl diff -f <manifests>` |
   | Helm | `helm diff upgrade <release> <chart>` (helm-diff plugin) |

3. Read the plan. List every destroy and replace.

## 3. Review

`core:dev-ship`. Add the ticket link, the plan, and the destroy/replace
list to the PR body. Request the reviewers from `AGENTS.md`.

## 4. Apply

- Non-production: after review.
- Production: only after approval in the change tool, inside the change
  window. Then `core:deploy`, or the apply step the repo's pipeline runs.
