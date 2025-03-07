# SuperWhisper Rules and Best Practices

## CRITICAL RULES

1. **ALWAYS create a backup before modifying prompt.md**
   ```bash
   cp prompt.md prompt.md.backup
   ```
   This is a non-negotiable requirement. No exceptions.

2. **Never modify the XML tag structure**
   The XML tags are critical for proper functioning. Do not alter, remove, or add tags without thorough testing.

3. **Maintain the output format**
   Commands must be wrapped in `<sw_response_content>` tags without any markdown formatting or code blocks.

## File Modification Guidelines

### When Modifying prompt.md:
- ✅ Create a backup first
- ✅ Preserve all XML tags exactly as they are
- ✅ Keep the same overall structure
- ✅ Maintain bullet points in requirements and formatting rules
- ✅ Test changes with `./test-whisper.sh` before committing
- ❌ Do not add markdown formatting to the output format
- ❌ Do not remove essential instructions
- ❌ Do not change the output tag structure

### When Modifying test-whisper.sh:
- ✅ Create a backup first
- ✅ Ensure examples are realistic and useful
- ✅ Maintain the same output format
- ❌ Do not add code blocks to the output

## Testing Requirements

After any changes to prompt.md:
1. Run `./test-whisper.sh` with no arguments to test a random example
2. Run `./test-whisper.sh "your test command"` with at least 3 different test cases
3. Verify that the output is correctly formatted without code blocks
4. Ensure the commands are optimized for macOS with zsh
5. Check that aliases are properly utilized

## Documentation Updates

When enhancing SuperWhisper:
1. Update README.md to reflect new capabilities
2. Document any new environment-specific features
3. Add examples of new command patterns
4. Keep the documentation in sync with the actual capabilities

## Version Control

1. Commit changes with descriptive messages
2. Include the type of change in the commit message (e.g., "feat: Add support for natural language commands")
3. Consider creating branches for significant changes

## Recovery Procedure

If changes break functionality:
1. Restore from backup: `cp prompt.md.backup prompt.md`
2. Test to verify functionality is restored
3. Make smaller, incremental changes and test after each one

Remember: The primary goal of SuperWhisper is to accurately convert voice commands to shell commands optimized for your specific environment. All changes should support this goal while maintaining reliability and accuracy. 