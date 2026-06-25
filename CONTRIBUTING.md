# Contributing to timeverse-vben-admin

Thanks for your interest in contributing! üéâ This skill helps the community build better Vben Admin projects faster. Every contribution counts.

## üìã Table of Contents

- [Code of Conduct](#code-of-conduct)
- [How to Contribute](#how-to-contribute)
  - [Reporting Bugs](#reporting-bugs)
  - [Suggesting Features](#suggesting-features)
  - [Improving Docs](#improving-docs)
  - [Adding Templates](#adding-templates)
- [Style Guide](#style-guide)
- [Commit Messages](#commit-messages)
- [Pull Request Process](#pull-request-process)

## üìú Code of Conduct

This project follows the [Contributor Covenant](https://www.contributor-covenant.org/). Be respectful, inclusive, and constructive.

## ü§ù How to Contribute

### Reporting Bugs

Open an issue with:

- Clear, descriptive title
- Steps to reproduce
- Expected vs actual behavior
- Vben Admin version (`package.json` ‚Ü?`vben` package version)
- Node / pnpm version
- Screenshots / error logs

### Suggesting Features

Open an issue with the `enhancement` label. Describe:

- The problem you're trying to solve
- The proposed solution
- Example trigger phrases or use cases
- Whether it should be opt-in or default

### Improving Docs

Doc improvements are always welcome:

- Fix typos / grammar
- Add missing examples
- Clarify confusing sections
- Translate to other languages (welcome: English / Chinese / Japanese / Spanish)

### Adding Templates

We love new templates! Suggested slots:

- `templates/dashboard.md` ‚Ä?analytics / workspace dashboards
- `templates/role-management.md` ‚Ä?role/permission CRUD
- `templates/department-tree.md` ‚Ä?org tree
- `templates/file-upload.md` ‚Ä?upload to OSS / S3
- `templates/i18n-keys.md` ‚Ä?locale workflow
- `templates/api-error-handler.md` ‚Ä?global error handler

Each template should be a **complete, copy-paste ready** example with:

- Route definition
- API stub
- i18n keys
- View + Editor
- Mock data
- Notes on customization

## üé® Style Guide

### Markdown

- Use ATX headings (`#` not `===` underlines)
- Use fenced code blocks with language hints (```ts, ```vue, ```bash)
- Use emoji sparingly: ‚ú?‚ù?üí° ‚ö†Ô∏è
- Wrap code in backticks for inline references
- Link to Vben docs when referencing official APIs

### Code Examples

- Use TypeScript, not JavaScript
- Use Composition API with `<script setup lang="ts">`
- Use namespace for API types (`export namespace SystemUserApi`)
- Use `requestClient` from `#/api/request`
- Use `useVbenForm` / `useVbenVxeGrid` over raw UI library APIs
- Always include i18n keys; never hardcode Chinese in templates

### YAML / Front-matter

- Keep `name` in kebab-case, ‚â?32 chars
- Pin `version` to semver
- Always include `description` and `author`

## üí¨ Commit Messages

We follow [Conventional Commits](https://www.conventionalcommits.org/):

```
<type>(<scope>): <subject>

<body>

<footer>
```

Types:

- `feat` ‚Ä?new feature
- `fix` ‚Ä?bug fix
- `docs` ‚Ä?docs only
- `style` ‚Ä?formatting
- `refactor` ‚Ä?code change that neither fixes a bug nor adds a feature
- `test` ‚Ä?adding tests
- `chore` ‚Ä?build / tooling

Examples:

```
feat(templates): add dashboard template
fix(permissions): correct mixed mode example
docs(readme): clarify install steps
```

## üîÑ Pull Request Process

1. **Fork** the repo
2. **Create a feature branch**: `git checkout -b feat/my-change`
3. **Make your changes** following the style guide
4. **Test locally**: ensure all code samples in templates are syntactically valid
5. **Commit** with conventional commit messages
6. **Push** to your fork: `git push origin feat/my-change`
7. **Open a Pull Request** with:
   - Clear description of the change
   - Link to any related issue
   - Screenshots (if visual)
8. **Wait for review** ‚Ä?maintainers will review within 3-5 days
9. **Address feedback** ‚Ä?push additional commits to the same branch

## ‚ú?Checklist Before Submitting

- [ ] All code examples compile
- [ ] Markdown renders correctly (no broken links)
- [ ] New files have appropriate front-matter
- [ ] PR description is clear
- [ ] Linked any related issues

## üìû Questions?

Open a [Discussion](https://github.com/elimyliu/timeverse-vben-admin/discussions) or comment on a related issue.

Thanks again for contributing! üíú
