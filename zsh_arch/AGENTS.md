# AGENTS.md - Development Guidelines for HyDE Zsh Configuration

## Build/Lint/Test Commands

### Syntax Validation
```bash
# Check zsh syntax for all .zsh files
find . -name "*.zsh" -exec zsh -n {} \;

# Validate specific file
zsh -n .zshrc

# Check for shell script issues with shellcheck (if available)
shellcheck .zshrc user.zsh functions/*.zsh
```

### Single Test Execution
```bash
# Test zsh configuration loading
zsh -c 'source .zshrc; echo "Configuration loaded successfully"'

# Test specific function
zsh -c 'source functions/error-handlers.zsh; command_not_found_handler test'
```

### Full Test Suite
```bash
# Run all syntax checks
./test-config.sh  # Create this script if needed

# Validate plugin loading
zsh -c 'source user.zsh; echo "Plugins loaded: $plugins"'
```

## Code Style Guidelines

### File Structure
- Use `.zsh` extension for all zsh-specific files
- Keep functions in `functions/` directory
- Completions in `completions/` directory
- Main configuration in `.zshrc`
- User customizations in `user.zsh`

### Naming Conventions
- Functions: `lowercase_with_underscores` (e.g., `command_not_found_handler`)
- Variables: `UPPERCASE_WITH_UNDERSCORES` for global, `lowercase` for local
- Aliases: Short, memorable names (e.g., `ll`, `la`, `lt`)

### Formatting
- Use 4 spaces for indentation (consistent with zsh best practices)
- One command per line unless logically grouped
- Add comments for complex logic: `# Brief description`
- Group related aliases/functions with section headers

### Imports and Dependencies
- Source files explicitly: `source $ZDOTDIR/functions/error-handlers.zsh`
- Check command availability: `if command -v "tool" &>/dev/null; then`
- Use absolute paths when possible for reliability

### Error Handling
- Check exit codes: `if [[ $? -ne 0 ]]; then`
- Provide meaningful error messages with color codes
- Return appropriate exit codes (127 for command not found, etc.)
- Use `local` for function variables to avoid pollution

### Performance
- Defer heavy operations when possible
- Cache expensive operations
- Use lazy loading for plugins: `zstyle ':omz:plugins:*' autoload yes`
- Minimize startup time impact

### Security
- Avoid hardcoded paths when possible
- Validate inputs to functions
- Don't expose sensitive information in configuration
- Use secure practices for file operations

### Best Practices
- Test configurations in isolated environments
- Document complex functions with comments
- Keep configurations modular and reusable
- Follow zsh plugin standards for compatibility
- Use version control for configuration changes