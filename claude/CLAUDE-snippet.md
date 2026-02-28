# CLAUDE.md snippet for OpenSpec + reqstool integration

Add the following to your project's `CLAUDE.md` file. This tells Claude to read
the reqstool-openspec conventions when creating spec.md files, replacing the need
to modify the openspec-propose SKILL.md.

---

## OpenSpec + reqstool Integration

When creating or modifying OpenSpec spec.md files, **always read `.claude/reqstool-openspec-conventions.md` first**.
reqstool is the SSOT for requirements and verification scenarios — spec.md files reference IDs only,
never duplicating requirement text or GIVEN/WHEN/THEN steps. Always validate with `openspec validate --all --strict`.
