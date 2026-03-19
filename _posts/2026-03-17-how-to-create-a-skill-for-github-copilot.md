---
layout: post
title: "How to create a Skill for GitHub Copilot"
description: "A pragmatic intro to Copilot Skills, including structure, setup, and a real review workflow example."
date: 2026-03-17 23:59
author: Robert Muehsig
tags: [AI, GitHub Copilot, Skills, Review]
language: en
---

{% include JB/setup %}

This is probably old news for hardcore AI enthusiasts, but I only recently stumbled across **[Skills](https://agentskills.io/home)**.
Since we are fully invested in the GitHub Copilot tooling world in our [product primedocs](https://www.primedocs.io/), I thought this might be worth a quick write-up.

## What is a Skill?

A Skill is technically "just" a Markdown file with instructions for the LLM.
In practice, a Skill can include all kinds of things:

- Use tool X for task Y.
- Execute these steps in exactly this order.
- Watch out for these product-specific rules.

A Skill bundles a workflow you would otherwise have to explain again and again.

## How do you create a Skill?

*I can only speak for GitHub here, but other tools (for example Claude) understand similar concepts too and may look for files in different locations.*

For [GitHub Copilot](https://docs.github.com/en/copilot/how-tos/use-copilot-agents/coding-agent/create-skills), create a folder under `.github/skills` named after your skill.
Inside that folder, add a `SKILL.md` with metadata and your actual instructions.
GitHub and VS Code also support alternative locations such as `.claude/skills`, `.agents/skills`, and personal skills in `~/.copilot/skills`.

Schematically, it looks like this:

```text
your-repo/
|-- .github/
|   |-- copilot-instructions.md
|   |-- skills/
|   |   |-- review/
|   |   |   |-- SKILL.md
|   |   |
|   |   |-- architecture-check/
|   |       |-- SKILL.md
```

__Note:__ You can also place additional assets/tools inside the skill directory.


A minimal `SKILL.md` can look like this:

```md
---
name: review
description: "Use when reviewing pull requests for risks, regressions, and compatibility issues."
---

# Review Workflow

1. Summarize what changed.
2. Identify functional risks and breaking changes.
3. Check backward compatibility.
4. Suggest concrete fixes with file references.
```

Quick checklist:

- `SKILL.md` must be named exactly `SKILL.md`.
- The `name` field is required.
- The `description` field is required.
- Use lowercase names with hyphens (for example `review-skill`).
- Keep the directory name and `name` aligned.

## Isn't there already a `copilot-instructions.md` file?

Yes, fair question: is this duplicate?

Short answer:

- **`copilot-instructions.md`** is more "always on" (global behavior).
- **Skills** are more "on demand" for a specific workflow.

Or in other words: *Instructions* are guardrails, *Skills* are playbooks.

## Example: My Review Skill

Right now, my main task is less writing code and more reviewing and judging it: is this actually good for the product or not?

For that, I built my own review skill that combines two things:

- It respects our general coding guidelines.
- It focuses on product-specific pitfalls, for example when components are no longer backward compatible.

That saves me time in every review and gives me much more consistent results.

## How do you use the Skill?

### Option 1: via Copilot CLI

In Copilot CLI, you can invoke a skill in chat with a slash command:

```bash
/review "Review this PR and focus on backward compatibility risks."
```

If you need to start an interactive session first, use your local `copilot` CLI entrypoint and then run the slash command.

### Option 2: in Visual Studio Code

In [VS Code you can use skills as well](https://code.visualstudio.com/docs/copilot/customization/agent-skills) (for example via chat slash commands).
In full Visual Studio, I still have not seen equivalent skill support as of March 2026.

### Option 3: in Visual Studio IDE

*(Edit 19.03.2026)*

With the latest Visual Studio update, you can now invoke skills in "Agent" mode as well. There’s no UI to select a skill yet, but if you explicitly specify which skill you want to use, Visual Studio loads it correctly.

## Summary

Skills are not magic: in the end, they are structured instructions in a Markdown file.
Still, the leverage is huge, because you can standardize recurring workflows instead of prompting from scratch every single time.

If you already work heavily with GitHub Copilot, Skills are, in my opinion, a quick "low effort / high impact" step.

Hope this helps!
