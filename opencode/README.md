# Opencode Agents Configuration

This directory contains agent configurations for opencode commands.

## Structure

Each agent is defined as a JSON file with the following schema:

```json
{
  "name": "agent-name",
  "description": "Brief description of what this agent does",
  "prompt": "The prompt to use when invoking this agent",
  "category": "development|research|learning|security",
  "fabric_pattern": "optional: name of fabric pattern this maps to"
}
```

## Categories

### Development
- `code-review` - Review code for bugs and best practices
- `test-generator` - Generate unit tests for code
- `refactor` - Suggest refactoring improvements
- `debug-helper` - Help debug code errors
- `create-visualization` - Create Mermaid diagrams

### Research
- `summarize` - Summarize content (maps to fabric create_summary)
- `analyze-claims` - Analyze claims for accuracy
- `extract-insights` - Extract key insights (maps to fabric extract_wisdom)
- `note-summarizer` - Convert notes to structured report
- `research-gather` - Aggregate research on topics

### Security
- `threat-model` - Create STRIDE threat models (maps to fabric create_stride_threat_model)

### Learning
- `generate-quiz` - Generate quiz questions (maps to fabric create_quiz)
- `dev-quiz` - Interactive programming quizzes
- `learning-path` - Suggest learning paths for technologies

## Usage

Invoke agents from the command line:

```bash
opencode <agent-name> [options] <input>
```

Examples:

```bash
# Review code
opencode code-review mycode.py

# Generate tests
opencode test-generator myapp.js

# Summarize a document
opencode summarize README.md

# Create a threat model
opencode threat-model system-design.md
```

## Fabric Integration

Agents that map to fabric patterns include the `fabric_pattern` field. These use the corresponding fabric prompt from the fabric/patterns directory.

## Creating New Agents

1. Create a new JSON file in this directory
2. Follow the schema above
3. Choose an appropriate category
4. If mapping to a fabric pattern, include the pattern name
5. Update this README with the new agent

## Best Practices

- Keep prompts clear and specific
- Include examples in prompts where helpful
- Test agents with various inputs
- Update documentation as agents evolve
