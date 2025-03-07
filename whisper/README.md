# SuperWhisper Documentation

## Overview
SuperWhisper converts voice commands to shell commands using AI. The system uses a structured prompt with XML tags to ensure accurate conversion, optimized for macOS with zsh.

## Files
- `prompt.md` - The AI prompt with XML tag structure
- `test-whisper.sh` - Test script to demonstrate functionality
- `index.md` - Directory overview
- `RULES.md` - **CRITICAL** rules and best practices for modifying SuperWhisper

## Prompt Structure
The prompt in `prompt.md` uses these XML tags:

```
<role>             - Defines the AI's role
<instructions>     - Core task instruction
<requirements>     - Key requirements as bullet points
<context>          - Environment and user context
<formatting-rules> - Rules for formatting different elements
<output-format>    - Output structure specification
<examples>         - Example voice commands and shell commands
<style>            - Style guidance for generated commands
<system_context>   - System information
<application_context> - Application information
<user_message>     - User's voice command
```

## Output Format
SuperWhisper outputs raw shell commands without any markdown formatting or code blocks. The commands are wrapped in `<sw_response_content>` tags for easy extraction.

## Environment Awareness
SuperWhisper is configured to understand your macOS environment:
- Uses macOS-specific commands and paths
- Recognizes your shell aliases (eza, rg, fd, bat, z, etc.)
- Understands common directories and tools
- Optimized for zsh on macOS

## Advanced Integrations
SuperWhisper is aware of your powerful development tools and integrations:
- **Package Managers**: npm, yarn, pnpm, bun with their shortcuts
- **Container Tools**: Docker, Kubernetes with aliases
- **Build Tools**: Turborepo, GitHub CLI
- **AI Assistants**: Continue, Cursor, AI-explain/refactor commands
- **Navigation**: Zoxide (z), directory shortcuts, fuzzy finding
- **Python Tools**: Python3, uv package manager

## Natural Language Understanding
SuperWhisper can interpret natural language commands and convert them to appropriate shell commands:
- "Show me large files" → `du -sh * | sort -hr | head -10`
- "Find text in files and save results" → `rg 'pattern' --type=js > results.txt`
- "Jump to my projects and list recent files" → `z projects && eza -la --sort=modified`

## Task Patterns
SuperWhisper understands common task patterns and uses the most efficient tools:
- File searching: Prefers `fd` over `find`
- Text searching: Prefers `rg` over `grep`
- Directory navigation: Prefers `z` over `cd`
- File viewing: Prefers `bat` over `cat`
- Git operations: Uses `g` aliases or `hub` commands
- Process management: Uses `ps aux | rg pattern` or `killport number`

## macOS Integration
SuperWhisper is optimized for macOS-specific commands:
- Clipboard operations with `pbcopy` and `pbpaste`
- Opening files and applications with `open`
- System preferences with `defaults`
- Package management with `brew`
- Power management with `pmset`
- Screenshots with `screencapture`

## Making Updates
⚠️ **IMPORTANT**: Always follow the guidelines in `RULES.md` when making changes.

When updating the prompt:
1. **ALWAYS create a backup of prompt.md before making changes**
   ```bash
   cp prompt.md prompt.md.backup
   ```
   This is a non-negotiable requirement. No exceptions.
2. Maintain the XML tag structure exactly
3. Keep bullet points in requirements, formatting-rules, etc.
4. Ensure examples follow the format with <sw_response_content> tags
5. Test changes with `./test-whisper.sh`

## Usage
Run the test script to see the converter in action:
```bash
./test-whisper.sh
```

Or test with a specific voice command:
```bash
./test-whisper.sh "your voice command here"
``` 