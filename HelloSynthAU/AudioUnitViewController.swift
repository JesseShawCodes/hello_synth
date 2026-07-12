import CoreAudioKit
#if os(iOS)
import UIKit
#elseif os(macOS)
import AppKit
#endif

public final class AudioUnitViewController: AUViewController {
    public override func viewDidLoad() {
        super.viewDidLoad()

        #if os(iOS)
        view.backgroundColor = .systemBackground

        let label = UILabel()
        label.text = "Hello Synth"
        label.font = .systemFont(ofSize: 24, weight: .semibold)
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(label)

        NSLayoutConstraint.activate([
            label.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            label.centerYAnchor.constraint(equalTo: view.centerYAnchor),
        ])
        #elseif os(macOS)
        let label = NSTextField(labelWithString: "Hello Synth")
        label.font = .systemFont(ofSize: 24, weight: .semibold)
        label.alignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(label)

        NSLayoutConstraint.activate([
            label.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            label.centerYAnchor.constraint(equalTo: view.centerYAnchor),
        ])
        #endif
    }
}
