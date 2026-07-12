# Hello Synth

A minimal AUv3 instrument that plays a monophonic sine wave on MIDI note on/off. Builds for **iOS** and **macOS** from one codebase.

## Project structure

| Target | Platform | Purpose |
|--------|----------|---------|
| HelloSynth | iOS | Host app |
| HelloSynthAU | iOS | Audio Unit extension |
| HelloSynthMac | macOS | Host app |
| HelloSynthAUMac | macOS | Audio Unit extension |

Shared synth code lives in `HelloSynthAU/` (DSP, MIDI, render block).

## Open in Xcode

```bash
open HelloSynth.xcodeproj
```

Set your **Development Team** on all four targets.

---

## macOS — GarageBand on MacBook

1. Select scheme **HelloSynthMac** → run on **My Mac**.
2. Open the Hello Synth app once (confirms the extension is installed).
3. Open **GarageBand** → New Project → **Software Instrument**.
4. Select the track → **Library** panel → **Plug-ins** → **Audio Units** → **HlSy** → **Hello Synth**.
5. Play with a MIDI keyboard or **Window → Show Musical Typing**.

### Debug with GarageBand as host

Select scheme **HelloSynthAUMac** → Run → choose **GarageBand** as the host app.

---

## iOS — GarageBand on iPhone/iPad

1. Select scheme **HelloSynth** → run on a physical device.
2. Open GarageBand → New song → **Software Instrument**.
3. Sound browser → **External** tab → **Audio Unit Extensions** → **Hello Synth**.

> **Note:** Plug-ins & EQ is for effects only. Instruments use the External tab.

---

## Troubleshooting

| Symptom | Fix |
|--------|-----|
| Not in GarageBand | Run the host app first; use the correct browser path above |
| Host app says "Not found" | Check signing on both app + extension targets |
| Still missing | Quit GarageBand → Clean Build Folder → reinstall → reopen GarageBand |
| iOS only | Restart the device after first install |

## Architecture

```
GarageBand (host)
    └── HelloSynthAU.appex / HelloSynthAUMac.appex
            ├── MIDI note on/off → frequency + isNoteOn
            └── internalRenderBlock → sin(phase) * amplitude
```
