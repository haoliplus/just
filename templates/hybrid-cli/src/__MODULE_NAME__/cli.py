from __future__ import annotations

import argparse
import json
from pathlib import Path


def build_parser() -> argparse.ArgumentParser:
    parser = argparse.ArgumentParser(prog="__APP_NAME__")
    parser.add_argument("--format", choices=("text", "json"), default="text")
    parser.add_argument("--cwd", default=".", help="Working directory to report")
    return parser


def main() -> int:
    args = build_parser().parse_args()
    payload = {
        "tool": "__APP_NAME__",
        "cwd": str(Path(args.cwd).resolve()),
        "runtime": "python",
    }

    if args.format == "json":
        print(json.dumps(payload, ensure_ascii=True))
    else:
        print(f"{payload['tool']}: cwd={payload['cwd']} runtime={payload['runtime']}")

    return 0


if __name__ == "__main__":
    raise SystemExit(main())
