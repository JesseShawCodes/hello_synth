import AudioToolbox

public func HelloSynthAUFactory(
    componentDescription: AudioComponentDescription,
    options: AudioComponentInstantiationOptions = []
) throws -> AUAudioUnit {
    try HelloSynthAudioUnit(componentDescription: componentDescription, options: options)
}
