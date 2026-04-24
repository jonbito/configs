---
name: commit
description: Create or draft a Conventional Commits compliant git commit with a meaningful body and git trailers for staged changes. Use when the user asks to commit, write a commit message, or generate a commit message.
---

# Git Commit

Create a Conventional Commits 1.0.0 compliant commit for staged changes.
Default to a full decision-record style message: subject, explanatory body, and
git trailers. Do **not** create a subject-only commit unless the user explicitly
asks for a one-line message.

## Guardrails

- Only commit staged changes; do not stage, unstage, or amend unless asked.
- If no changes are staged, report that and stop.
- If the user asks only to draft or generate a message, print the message and do
  not run `git commit`.
- Use a temp file or multiple `-m` flags so Git receives the body and trailers.
- If verification was not run, say so honestly with a `Not-tested:` trailer.

## Process

1. Review staged changes:
   - `git status --short`
   - `git diff --staged --stat`
   - `git diff --staged`
2. Identify the commit intent:
   - What problem, behavior, or workflow does this change address?
   - What constraints or tradeoffs are visible in the diff?
   - What verification has already been run, if any?
3. Choose the narrowest commit type and scope that match the staged changes.
4. Write a multi-part message:
   - Subject: short Conventional Commit summary.
   - Body: why this change exists and the useful context for future readers.
   - Trailers: verification, risks, and any durable decision context.
5. Commit using a message file:

   ```sh
   msg_file="$(mktemp)"
   cat > "$msg_file" <<'EOF'
   <type>[optional scope][!]: <description>

   <body explaining intent and context>

   Tested: <verification performed>
   Not-tested: <known gaps, if any>
   EOF
   git commit --file "$msg_file"
   rm -f "$msg_file"
   ```

## Conventional Commit Format

```text
<type>[optional scope][!]: <description>

[optional body]

[optional footer(s)]
```

Structure:

- `type` is required and should be a noun such as `feat` or `fix`
- `scope` is optional and should be a short noun describing the affected area, wrapped in parentheses
- `!` immediately before the colon marks a breaking change
- `description` is required and should be a short imperative summary of the change
- `body` is optional in the spec but required by this skill unless the user asks
  for a one-line message; start it one blank line after the description
- `footer(s)` are optional in the spec but use trailers by default; start them
  one blank line after the body and follow git trailer format such as `Refs: #123`
- Use `BREAKING CHANGE:` in a footer to describe a breaking change; `BREAKING-CHANGE:` is also valid

Common types:

- `feat`: new feature
- `fix`: bug fix
- `docs`: documentation changes
- `style`: formatting-only changes
- `refactor`: code restructuring without changing behavior
- `perf`: performance improvements
- `test`: adding or updating tests
- `build`: build system or dependencies
- `ci`: CI configuration changes
- `chore`: maintenance tasks
- `revert`: revert a previous change

Examples:

```text
feat(auth): add OAuth2 login support

Users need a first-party login path that works with the existing auth
middleware, so the provider setup is wired through the current session flow
instead of introducing a parallel callback path.

Tested: npm test -- auth
Confidence: high
Scope-risk: moderate
```

```text
fix(api): handle null response from user endpoint

The API client now treats empty user payloads as missing records instead of
passing null into downstream normalization, which keeps callers on the existing
error-handling path.

Tested: npm test -- user-client
Not-tested: Live upstream API behavior
```

```text
feat(config)!: drop support for legacy configuration keys

Configuration loading now rejects the retired key names so invalid settings fail
early instead of being silently interpreted as extension directives.

BREAKING CHANGE: legacy configuration keys are no longer accepted
Tested: npm test -- config
Rejected: Runtime compatibility shim | would keep ambiguous legacy behavior
```

Rules:

- Use lowercase commit types consistently
- Do not capitalize the description just for style; keep it natural and consistent
- Do not end the description with a period
- Separate the description, body, and trailer/footer sections with blank lines
- Wrap the body at about 72 characters when practical
- Use the body to explain context and intent, not to repeat the description
- Use the imperative mood in the description, for example `fix(tests): add unit tests for user authentication`
- Use `feat` for new features and `fix` for bug fixes; other types are allowed but do not imply semantic version changes unless they include a breaking change
- Prefer useful trailers when they add durable context:
  - `Tested:` exact checks run
  - `Not-tested:` known gaps or "Not run" with a reason
  - `Constraint:` external constraint shaping the change
  - `Rejected:` alternative considered and why it was not used
  - `Confidence:` low, medium, or high
  - `Scope-risk:` narrow, moderate, or broad
  - `Directive:` warning for future modifiers
