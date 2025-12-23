#!/usr/bin/env python3
import sys, os

CONF = os.path.expanduser("~/dotfiles/decman/source.py")
os.makedirs(os.path.dirname(CONF), exist_ok=True)

def dm_sync():
    # Determine if we are adding or removing based on the first argument
    cmd, pkg = ("remove", sys.argv[2]) if sys.argv[1] in ["remove", "del"] else ("add", sys.argv[1])
    
    # Read existing config or start fresh
    lines = open(CONF, "r").readlines() if os.path.exists(CONF) else ["decman.packages = ()\n"]
    exists = any(f"'{pkg}'" in l or f'"{pkg}"' in l for l in lines)

    if cmd == "add" and not exists:
        with open(CONF, "a") as f: 
            f.write(f"decman.packages += ('{pkg}',)\n")
        print(f"Added '{pkg}' to configuration.")
        
    elif cmd == "remove" and exists:
        with open(CONF, "w") as f: 
            f.writelines(l for l in lines if f"'{pkg}'" not in l and f'"{pkg}"' not in l)
        print(f"Removed '{pkg}' from configuration.")

if __name__ == "__main__":
    if len(sys.argv) > 1: 
        dm_sync()
