import SwiftUI

// Everything about the logo that isn't layout: its colors and the long letter path.
// The shapes come from the logo SVG on Wikimedia Commons. It's Rockstar's trademark,
// so this is for fan use only.

let logoBox = CGRect(x: 10, y: 28, width: 980, height: 744)

let pink = Color(hex: 0xFF2B90)
let ink = Color(hex: 0x1D0030)

let purple = LinearGradient(
    colors: [Color(hex: 0x350054), Color(hex: 0x6D016D)],
    startPoint: .top, endPoint: .bottom)

let sunset = LinearGradient(
    colors: [Color(hex: 0x2B60DA), Color(hex: 0xFF4CB9), Color(hex: 0xE6953E)],
    startPoint: .top, endPoint: .bottom)

let gold = LinearGradient(
    stops: [
        .init(color: Color(hex: 0xFFBC24), location: 0),
        .init(color: Color(hex: 0xFF49B9), location: 0.29),
        .init(color: Color(hex: 0xBC0082), location: 0.75),
        .init(color: Color(hex: 0x6D016D), location: 1),
    ],
    startPoint: .top, endPoint: .bottom)

let disclaimer = "Fan made. Not affiliated with Rockstar Games."

extension Color {
    // Color(hex: 0xFF2B90)
    init(hex: UInt) {
        self.init(
            red: Double(hex >> 16 & 0xFF) / 255,
            green: Double(hex >> 8 & 0xFF) / 255,
            blue: Double(hex & 0xFF) / 255
        )
    }
}

// The words "grand theft auto".
let logoWords = """
M479.4,439.3c0,11-7,16.5-21.1,16.3h-53 c-14.1,0-21.1-5.4-21.1-16.3v-74.1h-10.5v-32.6h10.5v-16.1h42.4v16.1h52.7 v32.6h-52.7v57.7h10.5v-49.5h42.2V439.3z
M331.4,179.2H321.2v70.6h10.3V179.2z
M373.9,307c0,10.9-7,16.3-21.1,16.3h-74V290.7h52.7v-8.3h-31.6 c-14.4,0-21.4-5.4-21.1-16.3V162.9c0-11,7-16.6,21.1-16.6h74V307z
M437.3,179.2h-10.3v16.3h10.3V179.2z
M458.7,318.5c-4.8,0-9.4-1.5-13.9-4.4 c-5-3.5-7.5-7.4-7.5-11.9V228.4h-10.3v75.9h-42.4V146.3h74 c14.1,0,21.1,5.5,21.1,16.6v35.2c0,6.6-3.5,11.1-10.5,13.7 c7,2.6,10.5,7.2,10.5,13.7v66.8h53v18.6h-0.1v5.8h31.6 c14.1,0,21.1,5.5,21.1,16.6v122.2H542.9V349.7h-10.3v105.9H490.2V318.5H458.7z
M543.3,228.4h-10.3v21.4h10.3V228.4z
M511.6,282.4c-14.1,0-21.1-5.4-21.1-16.3 v-54.3c0-10.7,7-16.1,21.1-16.3h31.6v-16.3h-10.3v8h-42.4V162.9 c0-11,7-16.6,21.1-16.6h53c14.1,0,21.1,5.5,21.1,16.6v119.5H511.6z
M649.2,282.4V179.2h-10.3v103.2H596.5V146.3h42.4v8.3 c7-5.5,17.6-8.3,31.6-8.3c4.8,0,9.4,1.5,13.9,4.4 c4.8,3.3,7.2,7.3,7.2,12.2v119.5H649.2z
M755.1,179.2h-10.3v70.6h10.3 V179.2z
M723.5,282.4c-14.4,0-21.4-5.4-21.1-16.3V162.9 c-0.2-11,6.9-16.6,21.1-16.6h31.6v-35.4h42.4v171.5H723.5z
M648.8,349.7 h-10.3v16.3h10.3V349.7z
M691.2,439.3c0,10.9-7,16.3-21.1,16.3h-53 c-14.1,0-21.1-5.4-21.1-16.3V333.4c0-11,7-16.6,21.1-16.6h53 c14.1,0,21.1,5.5,21.1,16.6v73h-52.7v16.6h10.3v-8.3h42.4V439.3z
M744.4,398.1v57.5h-42.4V333.4c0-10.9,7-16.4,21.1-16.6h70.7v32.9H744.4v8 h49.3v40.4H744.4z
M407,555h-10.3v21h10.3V555z
M375.3,608.7 c-14.1,0-21.1-5.5-21.1-16.4v-56.9c0-10.7,7-16.2,21.1-16.4h31.7v-16.4 h-10.3v8h-42.5v-24.4c0-11.1,7-16.6,21.1-16.6h53.1 c14.1,0,21.1,5.5,21.1,16.6v122.3H375.3z
M555.8,592.3 c0,10.9-7,16.4-21.1,16.4h-53.1c-14.1,0-21.1-5.5-21.1-16.4v-122.6h42.5 V576h10.3V469.8h42.5V592.3z
M668.9,592.3c0,11.1-7,16.5-21.1,16.4h-53.1 c-14.1,0-21.1-5.5-21.1-16.4v-81.6h-10.6v-32.7h10.6v-12.4h42.5v12.4h52.8 v32.7H616.1v65.2h10.6v-56.9h42.3V592.3z
M732.6,502.7h-10.3v73.3h10.3V502.7z
M908.9,439.3c0,11-7,16.5-21.1,16.3h-53c-14.1,0-21.1-5.4-21.1-16.3 v-74.1h-10.5v-32.6h10.5v-16.1h42.4v16.1h52.7v32.6h-52.7v57.7h10.5v-49.5 h42.2V439.3z
M775.1,592.3c0,10.9-7,16.4-21.1,16.4h-53.1 c-14.1,0-21.1-5.5-21.1-16.4V486.4c0-11.1,7-16.6,21.1-16.6h53.1 c14.1,0,21.1,5.5,21.1,16.6V592.3z
"""
