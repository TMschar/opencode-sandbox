---
name: effect-ts
description: Use when writing TypeScript code with Effect library - provides patterns for Effect.gen, services, layers, typed errors, Schema validation, and observability; consult effect-docs MCP for detailed API reference
---

# TypeScript code with Effect-TS

If the Effect-MCP is not activated, ask to have it activated before you continue doing Effect related work.

## Pointers

- Use Schema.TaggedError for errors
- Most Effect code should be written as services.
  Use Effect.Service when reasonable (e.g. when something doesn't make sense to be in a single function/Effect.gen)
- Use pipe where you can to keep code clear, concise, clean and easy to read
- Always handle all errors
- For making HTTP requests, use Effect HTTP library
- Where arguments and such may be accidentally passed in as flipped. Use branded types (with Effect Schema).
- Convert non effect code to effect when they are throwing Exceptions or returning promises (Effect.try, Effect.tryPromise)
- Add spans to code. Also annotate these spans.
- Add logging to code, not to verbose.
- Never comment code unless you need to explain WHY something is done. If you need to comment what is being done. You are doing it wrong and should give up.
- Test code with vitest, @effect/vitest
- When writing tests, never write tautological tests
- If possible, both code in a way that supports unit tests but also if the code supports it, also write unit tests.
- Write integration tests, use testcontainers for this.
- When SQL is needed, use effect/sql and effect/sql-pg
- Do not use features such as Effect.catchAll unless there is a good reason to. In this case, get explicit permission. Let the TypeScript compiler catch any non-handled errors.

## Rules

**One `Effect.provide`** per application at the top level
**Services should not leak requirements** - methods return `Effect<A, E, never>`
**Add observability where usable** - spans, logs, annotations
**Use `NodeRuntime.runMain` (or equivalent Deno/Bun)** for application entry points (graceful shutdown)
**Use `Effect.fn`** for functions that return Effects (automatic tracing)

## MCP Tool Usage

**Use the `effect-docs` MCP tools** for detailed API reference:
- `effect_docs_search`: Search documentation by keyword
- `get_effect_doc`: Retrieve full documentation by ID
