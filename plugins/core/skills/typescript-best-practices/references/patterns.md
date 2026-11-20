# TypeScript patterns

Code examples for each rule in `SKILL.md`.

## Branded types

Check once at the edge. Code after that trusts the type.

```ts
type AgentId = string & { readonly __brand: "AgentId" };

function isAgentId(input: string): input is AgentId {
  return isUUID(input);
}

function parseAgentId(input: string): AgentId {
  if (!isAgentId(input)) throw new Error(`Invalid agent id: ${input}`);
  return input;
}

function focusAgent(id: AgentId): void {
  /* id is trusted */
}
```

Use the `readonly __brand: "X"` shape. Do not invent a second convention.

## Discriminated unions

```ts
// Don't: a boolean and optional fields allow states that contradict.
type DiffState = { loading: boolean; diff?: GitDiff; error?: string };

// Do: only valid states exist.
type DiffState =
  | { kind: "loading" }
  | { kind: "ready"; diff: GitDiff }
  | { kind: "error"; error: string };
```

Pick one field name (`kind`, `type`, or `tag`) per repo.

## Build legal shapes

```ts
type NonEmpty<T> = [T, ...T[]];

// Don't: every caller must remember the length check.
function pickWinner(entries: string[]): string {
  if (entries.length === 0) throw new Error("no entries");
  return entries[Math.floor(Math.random() * entries.length)];
}

// Do: an empty value of this type cannot exist.
function pickWinner(entries: NonEmpty<string>): string {
  return entries[Math.floor(Math.random() * entries.length)];
}

const isNonEmpty = <T>(arr: T[]): arr is NonEmpty<T> => arr.length > 0;
```

```ts
type Pairs<T> = [T, T][];

// Don't: a comment holds the rule.
type TimeRange = { start: Date; end: Date }; // start <= end

// Do: a negative range cannot be written. Derive the end when needed.
type TimeRange = { start: Date; durationMs: number };
```

## Simplest total type

```ts
// Fine: [] sums to 0.
const sum = (xs: number[]) => xs.reduce((a, b) => a + b, 0);

// Don't: the `!` hides a crash.
function newestSession(sessions: Session[]): Session {
  return sessions.at(0)!;
}

// Do: make the input stricter, and the assertion goes away.
function newestSession(sessions: NonEmpty<Session>): Session {
  return sessions[0];
}
```

Returning `Session | undefined` is the other honest signature.

## Schemas before hand-written guards

```ts
import { z } from "zod";

const UserSchema = z.object({
  id: z.string().uuid(),
  role: z.enum(["admin", "member"]),
});

type User = z.infer<typeof UserSchema>;

function parseUser(input: unknown): User {
  return UserSchema.parse(input);
}
```

Use `safeParse` when failure is an expected branch. When the type comes
first, annotate the schema so the compiler rejects one that proves less:

```ts
type User = { id: string; name: string };
const userSchema: z.ZodType<User> = z.object({ id: z.string(), name: z.string() });
```

## Removing an `as`

Find why TypeScript cannot infer the type:

- No discriminant: add one and use a discriminated union.
- The source type is too wide, such as `Record<string, unknown>`: narrow it.
- Untyped edge: parse with the schema that owns the shape.
- The type cannot be expressed: use a brand or `satisfies`.

## Narrowing and exhaustiveness

```ts
function area(s: Shape): number {
  switch (s.kind) {
    case "circle":
      return Math.PI * s.radius ** 2;
    case "rect":
      return s.width * s.height;
    default: {
      const _exhaustive: never = s;
      return _exhaustive;
    }
  }
}
```

In a `void` switch, write `void _exhaustive;` in place of the `return`.

## `satisfies`, not `as`

```ts
// Don't: widens, and loses the literal types.
const config = { theme: "dark", cols: 3 } as Config;

// Do: checks the value, and config.theme stays "dark".
const config = { theme: "dark", cols: 3 } satisfies Config;
```

## Parse at the edge

- Wire formats (proto, JSON-RPC): ignore unknown fields, so a newer
  server does not break an older client.
- Saved JSON: store a version number, and wrap the parse in try/catch.
- Never validate again deep in a call chain.

## Derive types

```ts
// Don't: a second copy of the shape drifts when the schema changes.
type CheckSummary = { totalCount: number; checks: { name: string; status: string }[] };

// Do: derive it from the generated type.
import type { ChecksMessage } from "<generated module>";
function renderChecks(s: Pick<ChecksMessage, "totalCount" | "checks">) {}
```

## Object arguments

```ts
// Don't: swap two numbers and it still compiles.
openFile(uri, 10, 1, 10, 1);

// Do
openFile({ uri, selection: { startLine: 10, startColumn: 1, endLine: 10, endColumn: 1 } });
```
