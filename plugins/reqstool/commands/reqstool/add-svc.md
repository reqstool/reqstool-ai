---
name: "Reqstool: Add SVC"
description: Add a new Software Verification Case and update subproject filters
category: Requirements
tags: [reqstool, svc, verification, add]
---

**Argument**: Requirement ID to verify and/or a description of the test scenario.

Examples:
- `/reqstool:add-svc CORE_0005` — will draft a GIVEN/WHEN/THEN based on the requirement
- `/reqstool:add-svc CORE_0005: GIVEN a Maven project WHEN the resolver scans THEN classpath is returned`
