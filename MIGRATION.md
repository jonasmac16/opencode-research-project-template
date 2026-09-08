# Retrofitting an existing project

This file and `tools/apply-to-project.sh` belong on the `migration-tools` branch, not the template `main` branch.

From a checkout of the `migration-tools` branch:

```sh
./tools/apply-to-project.sh /path/to/existing-analysis
```

The default behavior preserves conflicting files. Use `--force` only when you intentionally want the template copy to replace a conflicting project-local path; the replaced path is first renamed with a timestamped `.bak.*` suffix.

The script writes only inside the target project and does not modify `~/.config/opencode/`.

After applying the project-local files, start OpenCode in the target repository and run:

```text
/init-analysis
/init
/review-init    # optional
```

For an established repository, `/init-analysis` should infer as much as possible from existing code/docs and ask only consequential unresolved scientific/language questions before pruning support.
