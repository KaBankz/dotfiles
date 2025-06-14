# Fish Configuration Guide

## Directory Structure

```plaintext
fish/
├── conf.d/         # Config files
├── functions/      # Custom functions
├── config.fish     # Legacy config file
├── fish_variables  # Auto-generated variables
└── completions/    # Custom command completions
```

**Startup Loading Order:**

1. `conf.d/` files (alphanumerically)
2. `config.fish` (if present)
3. `fish_variables` (auto-managed)

**Lazy Loaded:**

- `functions/` - loaded when function is called
- `completions/` - loaded when completing commands

## Best Practices

**Recommended Structure:**

- Put all configuration (env vars, abbreviations, etc.) in `conf.d/`
  - Name the files with a number prefix to control loading order
    - Example: `01-env.fish`, `10-abbr.fish`, etc.
- Put custom functions in `functions/`
  - All files inside `functions/` are lazy-loaded, unlike `conf.d/` files
- Avoid using `config.fish` unless overriding other configs

**Performance Tips:**

- Prefer `abbr` over `alias` for simple text replacements
- Prefer functions over `alias` for complex aliases
- Split configs into multiple files rather than one monolithic file

**`alias` vs `abbr` Explained:**

- `alias` is a compatibility helper that creates fish functions behind the scenes
- `abbr` are expansions that simply replace text input with defined replacements
- Both work well, but `abbr` is slightly faster since no function creation is needed
- `alias` is much more convenient than deciding whether to create an `abbr` or function for an alias

## Converting Aliases to Functions

```fish
alias -s <alias_name> "<command>"
```

Example: `alias -s ls "ls -lah"`

This writes a function called `<alias_name>.fish` to the `functions/` directory.

## Files to Avoid Editing

- `fish_variables` - Auto-generated, don't manually edit
- `completions/` - Only needed for custom completions

---

*Use this config as a reference for your own fish setup.*
