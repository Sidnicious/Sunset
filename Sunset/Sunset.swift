import Foundation
import IOKit

let kMaxDisplays: UInt32 = 16

struct Display {
    
    let id: CGDirectDisplayID
    
    init(_ id: CGDirectDisplayID) {
        self.id = id
    }
    
    func setTemperature(_ temperature: Double) {
        let whitepoint = temperatureToRGB(temperature)
        
        CGSetDisplayTransferByFormula(id,
            0, CGGammaValue(whitepoint.0), 1,
            0, CGGammaValue(whitepoint.1), 1,
            0, CGGammaValue(whitepoint.2), 1
        )
    }
    
    static func onlineDisplays() -> [Display] {
        var displays = [CGDirectDisplayID](repeating: 0, count: Int(kMaxDisplays))
        var numDisplays: UInt32 = 0
        CGGetOnlineDisplayList(kMaxDisplays, &displays, &numDisplays)
        return Array(Array(displays[0..<Int(numDisplays)].map { Display($0) }))
    }
}

class TemperatureManager {
    
    var displays: [Display] = []
    var dispatch_source: DispatchSourceTimer! = nil
    var current: Double = 6500 {
        didSet {
            for display in displays {
                display.setTemperature(current)
            }
        }
    }
    var target: Double = 6500 {
        didSet {
            if dispatch_source != nil { return }
            // TODO: switch to DisplayLink
            dispatch_source = DispatchSource.makeTimerSource(flags: [], queue: DispatchQueue.global())
            dispatch_source.scheduleRepeating(deadline: .now(), interval: .milliseconds(50))
            dispatch_source.setEventHandler {
                let diff = self.target - self.current
                if abs(diff) < 5 {
                    self.current = self.target
                    self.dispatch_source = nil
                    return
                }
                self.current = self.current + diff * 0.2
            }
            dispatch_source.resume()
        }
    }
    
    func scanDisplays() {
        displays = Display.onlineDisplays()
    }
}
