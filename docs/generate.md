# AI Generate

These commands use `uv` to run a standalone Python script that calls either OpenAI or OpenRouter.

## Requirements

- `uv`
- `OPENAI_API_KEY` or `OPENROUTER_API_KEY`

## Commands

Generate an image:

```bash
just -g generate img 1080 1200 "prompt for image generation"
```

Generate audio:

```bash
just -g generate audio alloy "text to generate audio"
```

## Notes

- Image output defaults to `outputs/*.png`
- Audio output defaults to `outputs/*.mp3`
- OpenRouter is preferred automatically when `OPENROUTER_API_KEY` is set
- Image size is normalized to the nearest provider-supported size or aspect ratio

OpenAI image sizes:

- `1024x1024`
- `1536x1024`
- `1024x1536`

OpenRouter image aspect ratios currently mapped by the script:

- `1:1`
- `2:3`
- `3:2`
- `3:4`
- `4:3`
- `4:5`
- `5:4`
- `9:16`
- `16:9`
- `21:9`

Useful environment variables:

- `OPENAI_IMAGE_MODEL`
- `OPENAI_AUDIO_MODEL`
- `OPENROUTER_IMAGE_MODEL`
- `OPENROUTER_AUDIO_MODEL`
- `OPENROUTER_SITE_URL`
- `OPENROUTER_APP_NAME`
- `JUST_GENERATE_OUTPUT_DIR`
