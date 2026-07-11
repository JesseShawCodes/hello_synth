# Hello Synth

A minimal AUv3 instrument for iOS that plays a monophonic sine wave when you send MIDI note on/off events.

## What’s in the project

- **HelloSynth** — host app (required container for the extension)
- **HelloSynthAU** — Audio Unit extension with:
  - `SineWaveDSP` — oscillator + MIDI handling
  - `HelloSynthAudioUnit` — `AUAudioUnit` subclass with `internalRenderBlock`
  - `AudioUnitViewController` — simple “Hello Synth” label UI

## Open in Xcode

```bash
open HelloSynth.xcodeproj
```

1. Select the **HelloSynth** scheme.
2. Set your **Development Team** on both targets (Signing & Capabilities).
3. Connect an iPhone and build/run the host app once (this installs the extension).

## Test in GarageBand

1. Open **GarageBand** on the device.
2. Create a new song → add a software instrument track.
3. Tap the instrument slot → **Plug-ins & EQ** → **Audio Unit Extensions**.
4. Choose **Hello Synth**.
5. Open the keyboard and play a note — you should hear a sine wave.

## Architecture

```
GarageBand (host)
    └── HelloSynthAU.appex
            ├── MIDI note on/off → frequency + isNoteOn
            └── internalRenderBlock → sin(phase) * amplitude
```

## Next steps

- ADSR envelope
- Polyphony (voice array)
- Low-pass filter
- `AUParameterTree` for host automation
- SwiftUI plugin UI
