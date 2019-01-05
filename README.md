# Docker: `journald-cloudwatch-logs`

### Overview

The native CloudWatch Logs daemon wants to read log files from disk.  This causes a double-write and seek overhead. JournalD stores its logs in a binary format and normally does not emit to disk, comprehensively at least.  By tapping into the JournalD API directly, we can minimize overhead by improving the contract between JournalD and CloudWatch Logs.

#### Docker objectives:
1. Reproducible build environment for `journald-cloudwatch-logs`
2. Clean Docker images of target platforms combined with the binary.
3. Binary artifacts capable of running on target platforms
