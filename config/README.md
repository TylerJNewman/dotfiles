# Configuration Files

This directory contains configuration files for various tools and applications.

## Directory Structure

- `ripgrep/` - Configuration for the ripgrep search tool
- `starship/` - Configuration for the Starship prompt

## Ripgrep Configuration

The `ripgrep/ripgreprc` file contains configuration for the [ripgrep](https://github.com/BurntSushi/ripgrep) search tool. It sets default options for search behavior, such as:

- Smart case sensitivity
- Follow symbolic links
- Show line numbers
- Custom color settings
- File type definitions

The configuration is automatically loaded by setting the `RIPGREP_CONFIG_PATH` environment variable in the main `zshrc` file.

## Starship Configuration

The `starship/starship.toml` file configures the [Starship](https://starship.rs/) prompt. It customizes:

- Prompt format and appearance
- Which modules are displayed
- Module-specific settings
- Color scheme

For more information on customizing Starship, see the [Starship Guide](../docs/guides/starship-guide.md).

## Adding New Configurations

When adding configuration for a new tool:

1. Create a new subdirectory with the tool's name
2. Add the configuration file(s) to that directory
3. Update the `setup-links.sh` script to create the necessary symlinks
4. Update the main `zshrc` file if environment variables need to be set
5. Document the configuration in this README.md file

## Best Practices

- Keep configuration files minimal and focused
- Add comments explaining non-obvious settings
- Follow the tool's recommended configuration format
- Test changes to ensure they work as expected
- Document any custom settings or modifications 