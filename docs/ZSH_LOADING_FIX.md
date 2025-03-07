# ZSH Module Loading Fix

## Problem

The shell was experiencing lag and errors due to:

1. Syntax errors in some module files (`dev-workflow.zsh` and `productivity.zsh`)
2. Issues with the subdirectory module loading process

## Solution

A minimal fix was implemented in `zsh/zshrc`:

1. Added special handling for problematic files:
   - Unalias commands before loading to prevent conflicts
   - Load these files individually with proper error handling

2. Improved subdirectory module loading:
   - Skip the configs directory since we handle it separately
   - Add a check to skip non-existent files
   - Maintain error handling

## Files Modified

- `zsh/zshrc`: Updated module loading logic

## Testing

To test this fix, simply restart your terminal or run:

```bash
source ~/.zshrc
```

The shell should now start quickly without errors. 