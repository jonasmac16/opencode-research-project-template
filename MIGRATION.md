# Retrofitting an existing project

This file and `tools/apply-to-project.sh` belong on the `migration-tools` branch, not the template `main` branch.

From a checkout of the `migration-tools` branch:

```sh
./tools/apply-to-project.sh /path/to/existing-analysis
```

The default behavior preserves conflicting files. Use `--force` only when you intentionally want the template copy to replace a conflicting project-local path; the replaced path is first renamed with a timestamped `.bak.*` suffix.

The script writes only inside the target project and does not modify `~/.config/opencode/`.
