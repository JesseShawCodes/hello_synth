import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack(spacing: 20) {
            Image(systemName: "waveform.path")
                .font(.system(size: 56))
                .foregroundStyle(.tint)

            Text("Hello Synth")
                .font(.largeTitle.bold())

            Text("This app hosts the AUv3 instrument extension.\n\nIn GarageBand, add a new instrument and look under Audio Units → Hello Synth.")
                .multilineTextAlignment(.center)
                .foregroundStyle(.secondary)
                .padding(.horizontal)
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
