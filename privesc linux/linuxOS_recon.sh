#!/usr/bin/env bash
# Recon script: runs a set of system enumeration commands and saves output to a text file.

set -u  # don't use -e; we want to continue even if some commands fail

HOSTNAME="$(hostname 2>/dev/null || echo unknown-host)"
TS="$(date +"%Y%m%d-%H%M%S")"
OUTFILE="recon_${HOSTNAME}_${TS}.txt"

# Pretty printers
hr() { printf '\n%s\n\n' "============================================================"; }
run() {
  local desc="$1"; shift
  local cmd="$*"
  hr | tee -a "$OUTFILE"
  printf '[%s] %s\n' "$(date -u +"%Y-%m-%dT%H:%M:%SZ")" "$desc" | tee -a "$OUTFILE"
  printf 'Command: %s\n\n' "$cmd" | tee -a "$OUTFILE"
  eval "$cmd" 2>&1 | tee -a "$OUTFILE"
}

# Start
hr | tee "$OUTFILE"
printf 'System Recon Report for %s @ %s (UTC)\n' "$HOSTNAME" "$(date -u +"%Y-%m-%d %H:%M:%S")" | tee -a "$OUTFILE"
hr | tee -a "$OUTFILE"

# Identity
run "Current user identity (id / whoami)" 'id; echo; whoami'

# Sudo privileges (may prompt if allowed)
# -n option avoids hanging when password is required in non-interactive runs.
if sudo -n true 2>/dev/null; then
  run "Sudo privileges (sudo -l)" 'sudo -n -l'
else
  run "Sudo privileges (sudo -l) ? may require password" 'sudo -l'
fi

# SUID root binaries
run "SUID binaries owned by root (find / -user root -perm /4000)" 'find / -user root -perm /4000 2>/dev/null'
run "SUID binaries (alternative syntax: -perm -4000)" 'find / -perm -4000 2>/dev/null'

# OS details
run "Kernel and OS release (uname -a)" 'uname -a'
run "Issue banner (/etc/issue)" 'cat /etc/issue 2>/dev/null || echo "/etc/issue not readable"'
# Try both correct and common-typo filenames
run "OS release (/etc/os-release)" 'cat /etc/os-release 2>/dev/null || echo "/etc/os-release not present"'
run "OS release (typo variant: /etc/os-relase)" 'cat /etc/os-relase 2>/dev/null || echo "/etc/os-relase not present"'

# Cron and scheduled tasks
run "User crontab (crontab -l)" 'crontab -l 2>/dev/null || echo "No user crontab or not permitted"'
run "Cron directories listing (ls -la /etc/cron*)" 'ls -la /etc/cron* 2>/dev/null'
run "System crons in /etc/cron.d/*" 'cat /etc/cron.d/* 2>/dev/null || echo "/etc/cron.d/* not readable or empty"'
run "CRON entries in /var/log/syslog (grep \"CRON0\")" 'grep "CRON0" /var/log/syslog 2>/dev/null || echo "No matches or syslog not present"'

# Network listeners
run "Network sockets (netstat -tulpn)" 'netstat -tulpn 2>/dev/null || echo "netstat not available or requires sudo"'

# /opt inspection
run "Check /opt directory" 'ls -la /opt 2>/dev/null || echo "/opt not present or not readable"'

# Root-owned processes
run "Processes owned by root (ps aux | grep \"^root\")" 'ps aux 2>/dev/null | grep "^root" || echo "No matches or ps failed"'

hr | tee -a "$OUTFILE"
printf 'Output saved to: %s\n' "$OUTFILE" | tee -a "$OUTFILE"
hr | tee -a "$OUTFILE"
``
