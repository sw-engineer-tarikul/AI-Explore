#!/usr/bin/env python3
"""
Launcher for Fabro web-page automation.
Allows triggering requirement-driven page generation without editing web/BRIEF.md.
"""

import argparse
import subprocess
import sys


def main():
    parser = argparse.ArgumentParser(
        description="Launch Fabro web-page automation with a custom requirement."
    )
    parser.add_argument(
        "requirement",
        nargs="?",
        default=None,
        help="Requirement for the page (omit to be prompted)",
    )
    parser.add_argument(
        "-d", "--detach", action="store_true", help="Run in background and print run ID"
    )
    parser.add_argument(
        "--dry-run", action="store_true", help="Simulate execution without running LLMs"
    )

    args = parser.parse_args()

    requirement = args.requirement
    if not requirement:
        print("\n=== Data Engine Page Generation ===")
        print("Enter your requirement for the landing page below.")
        print("(Press Enter to use default Data Engine landing page requirement)\n")
        try:
            val = input("Requirement: ").strip()
            requirement = (
                val
                if val
                else "Data Engine landing page: highlight instant type coercion, field validation, and clean minimal design"
            )
        except (KeyboardInterrupt, EOFError):
            print("\nAborted.")
            sys.exit(0)

    print(f"\nLaunching Fabro workflow with requirement: {requirement}\n")

    cmd = [
        "docker",
        "exec",
        "-i",
        "fabro-server",
        "fabro",
        "run",
    ]
    if args.dry_run:
        cmd.append("--dry-run")
    if args.detach:
        cmd.append("-d")

    cmd.extend(
        [
            "--target",
            "sw-engineer-tarikul/AI-Explore@main",
            "--goal",
            requirement,
            "sw-engineer-tarikul/AI-Explore@main:web-page",
        ]
    )

    result = subprocess.run(cmd)
    sys.exit(result.returncode)


if __name__ == "__main__":
    main()
