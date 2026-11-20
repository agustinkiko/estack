# Python patterns

Code examples for each rule in `SKILL.md`. Python 3.12 syntax.

## Tagged unions and exhaustive `match`

```python
from dataclasses import dataclass
from typing import Literal, assert_never

# Don't: a flag and optional fields allow states that contradict.
@dataclass
class DiffState:
    loading: bool
    diff: GitDiff | None = None
    error: str | None = None

# Do: only valid states exist.
@dataclass(frozen=True, slots=True)
class Loading:
    kind: Literal["loading"] = "loading"

@dataclass(frozen=True, slots=True)
class Ready:
    diff: GitDiff
    kind: Literal["ready"] = "ready"

@dataclass(frozen=True, slots=True)
class Failed:
    error: str
    kind: Literal["error"] = "error"

type DiffState = Loading | Ready | Failed

def label(state: DiffState) -> str:
    match state:
        case Loading():
            return "Loading"
        case Ready(diff=diff):
            return f"{len(diff.files)} files"
        case Failed(error=error):
            return f"Error: {error}"
        case _:
            assert_never(state)
```

Add a fourth variant and the checker fails on `assert_never` until
`label` handles it.

## Distinct types

```python
from typing import NewType
from uuid import UUID

AgentId = NewType("AgentId", str)

def parse_agent_id(raw: str) -> AgentId:
    UUID(raw)  # raises ValueError if raw is not a UUID
    return AgentId(raw)

def focus_agent(agent_id: AgentId) -> None:
    ...  # agent_id is trusted

focus_agent("abc")                  # checker error: str is not AgentId
focus_agent(parse_agent_id(raw))    # ok
```

Call `AgentId(...)` only inside `parse_agent_id`.

## Validate at the edge

```python
from typing import Literal
from pydantic import BaseModel, ConfigDict

class User(BaseModel):
    model_config = ConfigDict(frozen=True, extra="ignore")
    id: UUID
    role: Literal["admin", "member"]

def parse_user(payload: object) -> User:
    return User.model_validate(payload)
```

Code after `parse_user` takes a `User`, never a `dict`. Do not check the
fields again deeper in.

## Removing a `cast`

```python
# Don't
user = cast(User, json.loads(body))

# Don't: the guard claims more than it checks.
def is_user(data: object) -> TypeIs[User]:
    return isinstance(data, dict) and "id" in data

# Do
user = User.model_validate_json(body)
```

Find why the checker cannot infer the type:

- No tag field: add `kind` and use a tagged union.
- The source type is too wide, such as `dict[str, object]`: parse it.
- Untyped edge: parse with the model that owns the shape.

## Honest `TypeIs`

```python
from collections.abc import Sequence
from typing import TypeIs

def is_str_seq(values: Sequence[object]) -> TypeIs[Sequence[str]]:
    return all(isinstance(v, str) for v in values)
```

The narrowed type must fit inside the input type. `list` does not allow
that, so `list[object]` to `list[str]` fails the checker. Use `Sequence`.

## Keyword-only arguments

```python
# Don't: swap the two paths and nothing complains.
def move(src: Path, dest: Path, overwrite: bool = False) -> None: ...

# Do
def move(src: Path, *, dest: Path, overwrite: bool = False) -> None: ...

move(old, dest=new)
```

## No mutable defaults

```python
# Don't: every call shares the same list.
def add_tag(tag: str, tags: list[str] = []) -> list[str]: ...

# Do
def add_tag(tag: str, tags: list[str] | None = None) -> list[str]:
    tags = [] if tags is None else tags
    ...

@dataclass
class Job:
    steps: list[str] = field(default_factory=list)
```

## Errors

```python
class PaymentDeclined(Exception):
    def __init__(self, order_id: OrderId, reason: str) -> None:
        super().__init__(f"order {order_id}: {reason}")
        self.order_id = order_id
        self.reason = reason

try:
    charge(order)
except PaymentDeclined as exc:
    log.warning("payment declined", extra={"order_id": exc.order_id})
    raise
```

Catch only what this layer can act on (`core:principle-boundary-discipline`).

## Tests

```python
def test_export_writes_one_row_per_user(tmp_path: Path) -> None:
    out = tmp_path / "users.csv"
    export_users([alice, bob], out)
    assert out.read_text().splitlines()[1:] == ["alice,admin", "bob,member"]
```

Use a real file in `tmp_path`, not a mocked `open`.
