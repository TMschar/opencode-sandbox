---
name: js-ts
description: Skill for JavaScript and TypeScript
---

# TypeScript and JavaScript

## Rules

- Use undefined instead of null.
- Never export *. Only export specifics that are needed.

## TypeScript specific rules

- Never use any unless you are specifically told to.
- Use type and not interface.
- Never use enum. Use an object with "as const" instead.
- When possible, use the Effect-TS library (if already present in project or if greenfield project without previous standards)
- Prefer Effect-TS types and data structures over built-in JS/TS structures and types when possible
