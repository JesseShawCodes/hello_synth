import AudioToolbox
import AVFoundation

public final class HelloSynthAudioUnit: AUAudioUnit {
    private let dsp = SineWaveDSP()
    private var outputBus: AUAudioUnitBus!
    private var _outputBusArray: AUAudioUnitBusArray!

    public override init(
        componentDescription: AudioComponentDescription,
        options: AudioComponentInstantiationOptions = []
    ) throws {
        try super.init(componentDescription: componentDescription, options: options)

        let format = AVAudioFormat(standardFormatWithSampleRate: 44100, channels: 2)!
        outputBus = try AUAudioUnitBus(format: format)
        _outputBusArray = AUAudioUnitBusArray(audioUnit: self, busType: .output, busses: [outputBus])

        maximumFramesToRender = 4096
    }

    public override var outputBusses: AUAudioUnitBusArray {
        _outputBusArray
    }

    public override var canProcessInPlace: Bool {
        true
    }

    public override var internalRenderBlock: AUInternalRenderBlock {
        let dsp = self.dsp

        return { _, _, frameCount, _, outputData, renderEvent, _ in
            dsp.processMIDI(eventList: renderEvent)
            dsp.render(frameCount: frameCount, bufferList: outputData)
            return noErr
        }
    }

    public override func allocateRenderResources() throws {
        try super.allocateRenderResources()
        dsp.sampleRate = outputBus.format.sampleRate
    }
}
