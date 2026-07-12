import AVFoundation

enum AudioUnitDiscovery {
    static func helloSynthComponents() -> [AVAudioUnitComponent] {
        let description = AudioComponentDescription(
            componentType: kAudioUnitType_MusicDevice,
            componentSubType: 0,
            componentManufacturer: 0,
            componentFlags: 0,
            componentFlagsMask: 0
        )

        return AVAudioUnitComponentManager.shared()
            .components(matching: description)
            .filter { component in
                component.name.localizedCaseInsensitiveContains("Hello Synth")
                    || component.audioComponentDescription.componentSubType == fourCharCode("HlSy")
            }
    }

    static func allInstrumentExtensions() -> [AVAudioUnitComponent] {
        let description = AudioComponentDescription(
            componentType: kAudioUnitType_MusicDevice,
            componentSubType: 0,
            componentManufacturer: 0,
            componentFlags: 0,
            componentFlagsMask: 0
        )

        return AVAudioUnitComponentManager.shared()
            .components(matching: description)
            .sorted { $0.name < $1.name }
    }

    private static func fourCharCode(_ string: String) -> UInt32 {
        var result: UInt32 = 0
        for scalar in string.utf8.prefix(4) {
            result = (result << 8) | UInt32(scalar)
        }
        return result
    }
}
