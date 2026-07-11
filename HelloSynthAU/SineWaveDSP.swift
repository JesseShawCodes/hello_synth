import AudioToolbox
import AVFoundation

/// Real-time sine oscillator. State is updated on the audio render thread.
final class SineWaveDSP {
    var phase: Float = 0
    var frequency: Float = 440
    var amplitude: Float = 0.5
    var isNoteOn: Bool = false
    var sampleRate: Double = 44100

    func processMIDI(eventList: UnsafePointer<AURenderEvent>?) {
        var event: UnsafePointer<AURenderEvent>? = eventList

        while let current = event {
            let head = current.pointee.head

            if head.eventType == .MIDI {
                let data = current.pointee.MIDI.data
                let status = data.0 & 0xF0

                if status == 0x90 && data.2 > 0 {
                    let note = data.1
                    frequency = 440 * pow(2, (Float(note) - 69) / 12)
                    isNoteOn = true
                } else if status == 0x80 || (status == 0x90 && data.2 == 0) {
                    isNoteOn = false
                }
            }

            if let next = head.next {
                event = UnsafePointer(next)
            } else {
                event = nil
            }
        }
    }

    func render(frameCount: AUAudioFrameCount, bufferList: UnsafeMutablePointer<AudioBufferList>) {
        let bufferPointer = UnsafeMutableAudioBufferListPointer(bufferList)

        for frame in 0..<Int(frameCount) {
            let value: Float
            if isNoteOn {
                value = sin(phase) * amplitude
                phase += (2 * Float.pi * frequency) / Float(sampleRate)
                if phase > 2 * Float.pi {
                    phase -= 2 * Float.pi
                }
            } else {
                value = 0
            }

            for buffer in bufferPointer {
                guard let data = buffer.mData else { continue }
                let samples = data.assumingMemoryBound(to: Float.self)
                samples[frame] = value
            }
        }
    }
}
