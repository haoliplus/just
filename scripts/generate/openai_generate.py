#!/usr/bin/env -S uv run --script
# /// script
# requires-python = ">=3.11"
# dependencies = [
#   "openai>=1.0.0",
# ]
# ///

from __future__ import annotations

import argparse
import base64
import os
import re
from datetime import datetime
from pathlib import Path

from openai import OpenAI


OUTPUT_DIR = Path(os.getenv("JUST_GENERATE_OUTPUT_DIR", "outputs"))
SUPPORTED_IMAGE_SIZES = ((1024, 1024), (1536, 1024), (1024, 1536))
AUDIO_FORMATS = {"mp3", "opus", "aac", "flac", "wav", "pcm"}
OPENROUTER_IMAGE_ASPECTS = {
    "1:1": (1024, 1024),
    "2:3": (832, 1248),
    "3:2": (1248, 832),
    "3:4": (864, 1184),
    "4:3": (1184, 864),
    "4:5": (896, 1152),
    "5:4": (1152, 896),
    "9:16": (768, 1344),
    "16:9": (1344, 768),
    "21:9": (1536, 672),
}


def detect_provider() -> str:
    forced = os.getenv("JUST_GENERATE_PROVIDER")
    if forced:
        return forced

    if os.getenv("OPENROUTER_API_KEY"):
        return "openrouter"

    if os.getenv("OPENAI_API_KEY"):
        return "openai"

    return "openai"


def default_image_model(provider: str) -> str:
    if provider == "openrouter":
        return os.getenv("OPENROUTER_IMAGE_MODEL", "openai/gpt-5-image-mini")

    return os.getenv("OPENAI_IMAGE_MODEL", "gpt-image-1")


def default_audio_model(provider: str) -> str:
    if provider == "openrouter":
        return os.getenv("OPENROUTER_AUDIO_MODEL", "openai/gpt-audio-mini")

    return os.getenv("OPENAI_AUDIO_MODEL", "gpt-4o-mini-tts")


def build_client(provider: str) -> OpenAI:
    if provider == "openrouter":
        api_key = os.getenv("OPENROUTER_API_KEY")
        if not api_key:
            raise ValueError("OPENROUTER_API_KEY is required for provider=openrouter")

        default_headers = {}
        site_url = os.getenv("OPENROUTER_SITE_URL")
        app_name = os.getenv("OPENROUTER_APP_NAME")
        if site_url:
            default_headers["HTTP-Referer"] = site_url
        if app_name:
            default_headers["X-Title"] = app_name

        return OpenAI(
            api_key=api_key,
            base_url=os.getenv("OPENROUTER_BASE_URL", "https://openrouter.ai/api/v1"),
            default_headers=default_headers or None,
        )

    api_key = os.getenv("OPENAI_API_KEY")
    if not api_key:
        raise ValueError("OPENAI_API_KEY is required for provider=openai")

    return OpenAI(
        api_key=api_key,
        base_url=os.getenv("OPENAI_BASE_URL") or None,
    )


def slugify(text: str, limit: int = 40) -> str:
    value = re.sub(r"[^a-zA-Z0-9]+", "-", text.strip().lower()).strip("-")
    return (value or "output")[:limit].rstrip("-")


def timestamp() -> str:
    return datetime.now().strftime("%Y%m%d-%H%M%S")


def ensure_parent(path: Path) -> None:
    path.parent.mkdir(parents=True, exist_ok=True)


def choose_image_size(width: int, height: int) -> tuple[int, int]:
    exact = (width, height)
    if exact in SUPPORTED_IMAGE_SIZES:
        return exact

    target_ratio = width / height

    def score(size: tuple[int, int]) -> tuple[float, int]:
        sw, sh = size
        ratio_delta = abs((sw / sh) - target_ratio)
        area_delta = abs((sw * sh) - (width * height))
        return (ratio_delta, area_delta)

    return min(SUPPORTED_IMAGE_SIZES, key=score)


def choose_openrouter_aspect(width: int, height: int) -> tuple[str, tuple[int, int]]:
    target_ratio = width / height

    def score(item: tuple[str, tuple[int, int]]) -> tuple[float, int]:
        _, (sw, sh) = item
        ratio_delta = abs((sw / sh) - target_ratio)
        area_delta = abs((sw * sh) - (width * height))
        return (ratio_delta, area_delta)

    return min(OPENROUTER_IMAGE_ASPECTS.items(), key=score)


def default_image_path(prompt: str, width: int, height: int) -> Path:
    OUTPUT_DIR.mkdir(parents=True, exist_ok=True)
    return OUTPUT_DIR / f"img-{timestamp()}-{width}x{height}-{slugify(prompt)}.png"


def default_audio_path(text: str, voice: str, response_format: str) -> Path:
    OUTPUT_DIR.mkdir(parents=True, exist_ok=True)
    return OUTPUT_DIR / f"audio-{timestamp()}-{voice}-{slugify(text)}.{response_format}"


def generate_image(
    client: OpenAI,
    provider: str,
    prompt: str,
    width: int,
    height: int,
    out: str | None,
    model: str,
    quality: str,
) -> int:
    if provider == "openrouter":
        aspect_ratio, (chosen_width, chosen_height) = choose_openrouter_aspect(width, height)
    else:
        aspect_ratio = None
        chosen_width, chosen_height = choose_image_size(width, height)

    out_path = Path(out) if out else default_image_path(prompt, chosen_width, chosen_height)
    ensure_parent(out_path)

    if provider == "openrouter":
        response = client.chat.completions.create(
            model=model,
            messages=[{"role": "user", "content": prompt}],
            extra_body={
                "modalities": ["image", "text"],
                "image_config": {"aspect_ratio": aspect_ratio},
            },
        )
        payload = response.model_dump()
        message = payload["choices"][0]["message"]
        image = message["images"][0]
        image_url = (
            image.get("image_url", {}).get("url")
            or image.get("imageUrl", {}).get("url")
            or image.get("url")
        )
        if not image_url or "," not in image_url:
            raise ValueError("OpenRouter response did not include a base64 image payload")

        image_base64 = image_url.split(",", 1)[1]
    else:
        response = client.images.generate(
            model=model,
            prompt=prompt,
            size=f"{chosen_width}x{chosen_height}",
            quality=quality,
        )
        image_base64 = response.data[0].b64_json

    out_path.write_bytes(base64.b64decode(image_base64))

    print(f"saved={out_path}")
    print(f"provider={provider}")
    print(f"model={model}")
    print(f"requested_size={width}x{height}")
    print(f"used_size={chosen_width}x{chosen_height}")
    if aspect_ratio:
        print(f"aspect_ratio={aspect_ratio}")
    return 0


def generate_audio(
    client: OpenAI,
    provider: str,
    text: str,
    voice: str,
    out: str | None,
    model: str,
    response_format: str,
    instructions: str | None,
    speed: float,
) -> int:
    out_path = Path(out) if out else default_audio_path(text, voice, response_format)
    ensure_parent(out_path)

    if provider == "openrouter":
        response = client.chat.completions.create(
            model=model,
            messages=[{"role": "user", "content": text}],
            modalities=["text", "audio"],
            audio={"voice": voice, "format": response_format},
            extra_body={
                "instructions": instructions,
                "speed": speed,
            },
        )
        payload = response.model_dump()
        audio = payload["choices"][0]["message"].get("audio") or {}
        audio_data = audio.get("data")
        if not audio_data:
            raise ValueError("OpenRouter response did not include audio data")
        out_path.write_bytes(base64.b64decode(audio_data))
    else:
        with client.audio.speech.with_streaming_response.create(
            model=model,
            voice=voice,
            input=text,
            response_format=response_format,
            instructions=instructions,
            speed=speed,
        ) as response:
            response.stream_to_file(out_path)

    print(f"saved={out_path}")
    print(f"provider={provider}")
    print(f"model={model}")
    print(f"voice={voice}")
    print(f"format={response_format}")
    return 0


def build_parser() -> argparse.ArgumentParser:
    provider = detect_provider()
    parser = argparse.ArgumentParser(
        description="Generate image or audio assets with OpenAI or OpenRouter."
    )
    parser.add_argument("--provider", choices=("openai", "openrouter"), default=provider)
    subparsers = parser.add_subparsers(dest="command", required=True)

    image_parser = subparsers.add_parser("image", help="Generate an image from a prompt")
    image_parser.add_argument("--width", type=int, required=True)
    image_parser.add_argument("--height", type=int, required=True)
    image_parser.add_argument("--prompt", required=True)
    image_parser.add_argument("--out")
    image_parser.add_argument("--model", default=default_image_model(provider))
    image_parser.add_argument("--quality", default="high", choices=("low", "medium", "high", "auto"))

    audio_parser = subparsers.add_parser("audio", help="Generate audio from text")
    audio_parser.add_argument("--voice", required=True)
    audio_parser.add_argument("--text", required=True)
    audio_parser.add_argument("--out")
    audio_parser.add_argument("--model", default=default_audio_model(provider))
    audio_parser.add_argument("--format", default="mp3", choices=sorted(AUDIO_FORMATS))
    audio_parser.add_argument("--instructions")
    audio_parser.add_argument("--speed", type=float, default=1.0)

    return parser


def main() -> int:
    parser = build_parser()
    args = parser.parse_args()

    try:
        client = build_client(args.provider)
    except ValueError as exc:
        parser.error(str(exc))

    if args.command == "image":
        return generate_image(
            client=client,
            provider=args.provider,
            prompt=args.prompt,
            width=args.width,
            height=args.height,
            out=args.out,
            model=args.model,
            quality=args.quality,
        )

    return generate_audio(
        client=client,
        provider=args.provider,
        text=args.text,
        voice=args.voice,
        out=args.out,
        model=args.model,
        response_format=args.format,
        instructions=args.instructions,
        speed=args.speed,
    )


if __name__ == "__main__":
    raise SystemExit(main())
