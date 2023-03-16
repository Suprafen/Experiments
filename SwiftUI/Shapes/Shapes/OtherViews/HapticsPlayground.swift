//
//  HapticsPlayground.swift
//  Shapes
//
//  Created by Ivan Pryhara on 15.03.23.
//

import SwiftUI
import CoreHaptics

struct HapticsPlayground: View {
    
    @State private var engine: CHHapticEngine?
    
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
            .onAppear(perform: prepareHaptics)
            .onTapGesture(perform: complexSuccess )
        
    }
    
    func playHaptics() {
        let generator = UINotificationFeedbackGenerator()
        generator.notificationOccurred(.warning)
    }
    
    func prepareHaptics() {
        guard CHHapticEngine.capabilitiesForHardware().supportsHaptics else {
            print("Haptics failed.")
            return
        }
        
        do {
            engine = try CHHapticEngine()
            try engine?.start()
            
        } catch {
            print("There was an error creating the engione with: \(error.localizedDescription)")
        }
    }
    
    func complexSuccess() {
        guard CHHapticEngine.capabilitiesForHardware().supportsHaptics else { return }
        
        var events: [CHHapticEvent] = []
        let intensity = CHHapticEventParameter(parameterID: .hapticIntensity, value: 1)
        let sharpness = CHHapticEventParameter(parameterID: .hapticSharpness, value: 1)
        let event = CHHapticEvent(eventType: .hapticTransient, parameters: [intensity, sharpness], relativeTime: 0)
        events.append(event)
        
        do {
            let pattern = try CHHapticPattern(events: events, parameters: [])
            let player = try engine?.makePlayer(with: pattern)
            try player?.start(atTime: 0)
        } catch {
            print("failed to play taht pattern with: \(error.localizedDescription)")
        }
    }
}

struct HapticsPlayground_Previews: PreviewProvider {
    static var previews: some View {
        HapticsPlayground()
    }
}
