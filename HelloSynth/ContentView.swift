import SwiftUI

struct ContentView: View {
    @State private var helloSynthFound = false
    @State private var allInstruments: [String] = []

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                HStack {
                    Image(systemName: "waveform.path")
                        .font(.system(size: 40))
                        .foregroundStyle(.tint)
                    Text("Hello Synth")
                        .font(.largeTitle.bold())
                }

                GroupBox("Extension status") {
                    Label(
                        helloSynthFound ? "Registered on this Mac" : "Not found — see steps below",
                        systemImage: helloSynthFound ? "checkmark.circle.fill" : "exclamationmark.triangle.fill"
                    )
                    .foregroundStyle(helloSynthFound ? .green : .orange)

                    if !allInstruments.isEmpty {
                        Text("All AU instruments detected: \(allInstruments.count)")
                            .font(.caption)
                            .foregroundStyle(.secondary)
                    }
                }

                #if os(iOS)
                iosGarageBandInstructions
                iosTroubleshooting
                #elseif os(macOS)
                macGarageBandInstructions
                macTroubleshooting
                #endif
            }
            .padding()
        }
        .onAppear(perform: refreshStatus)
    }

    #if os(iOS)
    private var iosGarageBandInstructions: some View {
        GroupBox("GarageBand iOS — correct path for instruments") {
            VStack(alignment: .leading, spacing: 8) {
                Text("Do NOT use Plug-ins & EQ — that is for effects.")
                    .font(.subheadline.bold())
                Text("1. New song → + → Software Instrument")
                Text("2. In the Sound browser, swipe to the External tab")
                Text("3. Tap Audio Unit Extensions")
                Text("4. Choose Hello Synth")
                Text("5. Open the keyboard and play a note")
            }
            .font(.subheadline)
            .frame(maxWidth: .infinity, alignment: .leading)
        }
    }

    private var iosTroubleshooting: some View {
        GroupBox("If it still does not appear") {
            VStack(alignment: .leading, spacing: 8) {
                Text("1. Run this Hello Synth app on your iPhone from Xcode (not Simulator)")
                Text("2. Confirm both targets have your Development Team set")
                Text("3. Settings → General → VPN & Device Management → trust your developer cert")
                Text("4. Delete Hello Synth from the device, Clean Build Folder in Xcode, reinstall")
                Text("5. Restart the iPhone (iOS sometimes delays AU registration)")
                Text("6. In Xcode: scheme HelloSynthAU → run with GarageBand as host")
            }
            .font(.subheadline)
            .frame(maxWidth: .infinity, alignment: .leading)
        }
    }
    #endif

    #if os(macOS)
    private var macGarageBandInstructions: some View {
        GroupBox("GarageBand Mac — how to load Hello Synth") {
            VStack(alignment: .leading, spacing: 8) {
                Text("1. Build & run the HelloSynthMac app once from Xcode")
                Text("2. Open GarageBand → New Project → Software Instrument")
                Text("3. With the track selected, open the Library panel (left)")
                Text("4. Choose Plug-ins → Audio Units → HlSy → Hello Synth")
                Text("5. Play the track with your MIDI keyboard or musical typing (Window → Show Musical Typing)")
            }
            .font(.subheadline)
            .frame(maxWidth: .infinity, alignment: .leading)
        }
    }

    private var macTroubleshooting: some View {
        GroupBox("If it still does not appear") {
            VStack(alignment: .leading, spacing: 8) {
                Text("1. Select scheme HelloSynthMac and run on My Mac")
                Text("2. Set Development Team on HelloSynthMac and HelloSynthAUMac targets")
                Text("3. Quit GarageBand, rebuild, run HelloSynthMac again, then reopen GarageBand")
                Text("4. In Xcode: scheme HelloSynthAUMac → run with GarageBand as host")
                Text("5. Check ~/Library/Audio/Plug-Ins/Components/ after a Release archive install")
            }
            .font(.subheadline)
            .frame(maxWidth: .infinity, alignment: .leading)
        }
    }
    #endif

    private func refreshStatus() {
        let matches = AudioUnitDiscovery.helloSynthComponents()
        helloSynthFound = !matches.isEmpty
        allInstruments = AudioUnitDiscovery.allInstrumentExtensions().map(\.name)
    }
}

#Preview {
    ContentView()
}
