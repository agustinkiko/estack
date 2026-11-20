---
name: python-best-practices
description: Use when reading, writing, or reviewing any .py or .pyi file. Python rules for type hints, tagged unions with match, NewType, validation at the edge, exhaustive matches, no `cast` or `Any`, and errors.
paths: ["**/*.py", "**/*.pyi"]
---

# Python best practices

Apply `core:principle-type-system-discipline` first. This skill is the
Python syntax for it. Examples for each rule are in
`references/patterns.md`.

Run the type checker the repo uses (mypy or pyright) on every change. New
code passes it in strict mode. On Python before 3.11 or 3.13, import
`assert_never` and `TypeIs` from `typing_extensions`.

| Rule | Summary |
|---|---|
| Type every signature | Every function has typed parameters and a return type. Use `list[str]` and `X \| None`, not `List` and `Optional`. |
| Tagged unions | One frozen dataclass per variant, each with a `Literal` `kind` field, joined with `\|`. No class with many `Optional` fields. |
| Distinct types | `UserId = NewType("UserId", str)` for a value with its own meaning. Create it only in a parse function that checks it. |
| Frozen values | `@dataclass(frozen=True, slots=True)` or a frozen Pydantic model for values. Mutate only where state must change. |
| `object`, not `Any` | Outside data is `object` until parsed. `Any` turns the checker off. |
| Schemas before guards | Validate outside data with the repo's library (Pydantic, msgspec, attrs with cattrs) and let the model own the type. Never add a library for one check. |
| No `cast` | `cast` and `# type: ignore` are claims nobody checked. Use them only after a check. Every ignore names its error code and the reason. |
| Narrowing order | `match` on the tag, then `isinstance`, then a `TypeIs` function, then `cast`. |
| Honest type guards | A `TypeIs` function checks every part of its claim. Name it `is_x`. |
| Exhaustiveness | End each `match` on a union with `case _: assert_never(x)`. A new variant then fails the checker. |
| Keyword-only arguments | Put `*` before parameters a caller could swap: `def move(src: Path, *, dest: Path)`. |
| No mutable defaults | `items: list[str] \| None = None`, or `field(default_factory=list)` in a dataclass. |
| Errors | Raise a specific exception class that callers can catch. Never a bare `except:`, and never `except Exception: pass`. |
| Logging | `log = logging.getLogger(__name__)` with an ID to debug from. No `print` in shipped code. |
| Paths and time | `pathlib.Path`, not string paths. Time-zone-aware `datetime.now(UTC)`, never naive `datetime.now()`. |
| Tests | pytest. Real objects over mocks. `tmp_path` for files, `monkeypatch` for env vars. |
