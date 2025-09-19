import SwiftUI

struct ControlCenterView: View {
    @State private var isWifiOn = true
    @State private var isBluetoothOn = true
    @State private var isAirplaneMode = false
    @State private var isFocusOn = false
    @State private var isPersonalHotspotOn = false
    @State private var brightness: Double = 0.7
    @State private var volume: Double = 0.6
    
    var body: some View {
        ZStack {
            LinearGradient(
                gradient: Gradient(colors: [
                    Color(red: 0.7, green: 0.8, blue: 0.9),
                    Color(red: 0.9, green: 0.7, blue: 0.8)
                ]),
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
            
            ScrollView {
                VStack(spacing: 16) {
                    HStack {
                        Image(systemName: "plus")
                        Spacer()
                        Image(systemName: "power")
                    }
                    .foregroundStyle(.white)
                    HStack(spacing: 16) {
                        VStack(spacing: 12) {
                            HStack(spacing: 12) {
                                ControlButton(
                                    icon: "airplane",
                                    isOn: $isAirplaneMode,
                                    activeColor: .orange
                                )
                                
                                ControlButton(
                                    icon: "antenna.radiowaves.left.and.right",
                                    isOn: .constant(true),
                                    activeColor: .blue
                                )
                            }
                            
                            HStack(spacing: 12) {
                                ControlButton(
                                    icon: "wifi",
                                    isOn: $isWifiOn,
                                    activeColor: .blue
                                )
                                
                                ControlButton(
                                    icon: "link",
                                    isOn: .constant(false),
                                    activeColor: .gray
                                )
                            }
                        }
                        
                        
                        MusicPlayerCard()
                    }
                    
                    HStack(spacing: 16) {
                        VStack(spacing: 12) {
                            HStack(spacing: 12) {
                                ControlButton(
                                    icon: "personalhotspot",
                                    isOn: $isPersonalHotspotOn,
                                    activeColor: .blue
                                )
                                
                                ControlButton(
                                    icon: "link",
                                    isOn: .constant(false),
                                    activeColor: .gray
                                )
                            }
                            HStack(spacing: 12) {
                                ControlButton(
                                    icon: "wifi",
                                    isOn: $isWifiOn,
                                    activeColor: .blue
                                )
                                
                                ControlButton(
                                    icon: "link",
                                    isOn: .constant(false),
                                    activeColor: .gray
                                )
                            }
                        }
                        HStack(spacing: 12) {
                            BrightnessVolumeControl(
                                icon: "sun.max.fill",
                                value: $brightness,
                                color: Color(0xFFC900)
                            )
                            
                            BrightnessVolumeControl(
                                icon: "speaker.slash.fill",
                                value: $volume,
                                color: .gray
                            )
                        }
                    }
                    
                    HStack {
                        FocusModeCard(isOn: $isFocusOn)
                        ControlButton(
                            icon: "qrcode.viewfinder",
                            isOn: .constant(false),
                            activeColor: .gray,
                            size: .medium
                        )
                        ControlButton(
                            icon: "video.slash",
                            isOn: .constant(false),
                            activeColor: .gray,
                            size: .medium
                        )
                    }
                    
                    HStack(spacing: 16) {
                        ControlButton(
                            icon: "flashlight.on.fill",
                            isOn: .constant(false),
                            activeColor: .white,
                            size: .medium
                        )
                        
                        ControlButton(
                            icon: "timer",
                            isOn: .constant(false),
                            activeColor: .gray,
                            size: .medium
                        )
                        
                        ControlButton(
                            icon: "waveform",
                            isOn: .constant(false),
                            activeColor: .gray,
                            size: .medium
                        )
                        
                        ControlButton(
                            icon: "record.circle",
                            isOn: .constant(false),
                            activeColor: .gray,
                            size: .medium
                        )
                    }
                    
                    HStack(spacing: 16) {
                        ControlButton(
                            icon: "waveform",
                            isOn: .constant(false),
                            activeColor: .gray,
                            size: .medium
                        )
                        
                        ControlButton(
                            icon: "arrow.up.right.and.arrow.down.left",
                            isOn: .constant(false),
                            activeColor: .gray,
                            size: .medium
                        )
                    }
                }
                .padding(.horizontal, 20)
                .padding(.top, 20)
            }
            .padding()
        }
        .ignoresSafeArea()
    }
}

struct ControlButton: View {
    let icon: String
    @Binding var isOn: Bool
    let activeColor: Color
    var size: ButtonSize = .small
    
    enum ButtonSize {
        case small, medium
        
        var dimension: CGFloat {
            switch self {
            case .small: return 55
            case .medium: return 68
            }
        }
    }
    
    var body: some View {
        Button(action: {
            isOn.toggle()
        }) {
            ZStack {
                RoundedRectangle(cornerRadius: size == .small ? 20 : 24)
                    .fill(isOn ? activeColor : Color.white.opacity(0.3))
                    .frame(width: size.dimension, height: size.dimension)
                
                Image(systemName: icon)
                    .font(.system(size: size == .small ? 20 : 24, weight: .medium))
                    .foregroundColor(isOn ? (activeColor == .white ? .black : .white) : .white)
            }
        }
        .buttonStyle(PlainButtonStyle())
    }
}

struct MusicPlayerCard: View {
    var body: some View {
        VStack {
            RoundedRectangle(cornerRadius: 24)
                .fill(Color.white.opacity(0.3))
                .frame(width: 170, height: 136)
                .overlay(
                    VStack(spacing: 8) {
                        HStack {
                            Spacer()
                            Button(action: {}) {
                                Image(systemName: "antenna.radiowaves.left.and.right")
                                    .font(.system(size: 16, weight: .medium))
                                    .foregroundColor(.white)
                            }
                        }
                        .padding(.top, 12)
                        .padding(.trailing, 12)
                        
                        Spacer()
                        
                        Text("Not Playing")
                            .font(.system(size: 14, weight: .medium))
                            .foregroundColor(.white)
                        
                        HStack(spacing: 20) {
                            Button(action: {}) {
                                Image(systemName: "backward.fill")
                                    .font(.system(size: 16, weight: .medium))
                                    .foregroundColor(.white)
                            }
                            
                            Button(action: {}) {
                                Image(systemName: "play.fill")
                                    .font(.system(size: 20, weight: .medium))
                                    .foregroundColor(.white)
                            }
                            
                            Button(action: {}) {
                                Image(systemName: "forward.fill")
                                    .font(.system(size: 16, weight: .medium))
                                    .foregroundColor(.white)
                            }
                        }
                        
                        Spacer()
                    }
                )
        }
    }
}

struct BrightnessVolumeControl: View {
    let icon: String
    @Binding var value: Double
    let color: Color
    
    @State private var isDragging = false
    @State private var dragOffset: CGFloat = 0
    @State private var lastDragValue: Double = 0
    
    private let controlHeight: CGFloat = 156
    private let controlWidth: CGFloat = 78
    private let indicatorHeight: CGFloat = 4
    private let cornerRadius: CGFloat = 24
    
    var body: some View {
        RoundedRectangle(cornerRadius: 24)
            .fill(Color.white.opacity(0.3))
            .frame(width: controlWidth, height: controlHeight)
            .overlay(
                // Filled portion (represents the current value)
                RoundedRectangle(cornerRadius: cornerRadius)
                    .fill(color.opacity(0.8))
                    .frame(height: max(cornerRadius * 2.0, controlHeight * value))
                    .animation(.easeOut(duration: 0.2), value: value)
                    .clipped(),
                alignment: .bottom
            )
            .overlay(
                // White indicator line
                RoundedRectangle(cornerRadius: indicatorHeight / 2)
                    .fill(Color.white)
                    .frame(width: controlWidth - 16, height: indicatorHeight)
                    .offset(y: -((controlHeight - 32) * value) + (controlHeight - 32) / 2.0)
                    .animation(.easeOut(duration: isDragging ? 0.0 : 0.2), value: value)
                    .opacity(value > 0.02 ? 1.0 : 0.0)
            )
            .overlay(
                VStack(spacing: 4) {
                    Spacer()
                    Image(systemName: icon)
                        .font(.system(size: 20, weight: .medium))
                        .foregroundColor(color == Color(0xFFC900) ? Color(0xFFC900) : .white)
                        .padding(.bottom, 19)
                }
            )
    }
}

struct FocusModeCard: View {
    @Binding var isOn: Bool
    
    var body: some View {
        Button(action: {
            isOn.toggle()
        }) {
            RoundedRectangle(cornerRadius: 24)
                .fill(Color.white.opacity(0.3))
                .frame(height: 68)
                .overlay(
                    HStack {
                        Image(systemName: "moon.fill")
                            .font(.system(size: 20, weight: .medium))
                            .foregroundColor(.white)
                            .frame(width: 40, height: 40)
                            .background(
                                Circle()
                                    .fill(Color.white.opacity(0.2))
                            )
                        
                        Text("Focus")
                            .font(.system(size: 18, weight: .medium))
                            .foregroundColor(.white)
                        
                        Spacer()
                        
                        Image(systemName: "chevron.right")
                            .font(.system(size: 14, weight: .medium))
                            .foregroundColor(.white.opacity(0.7))
                    }
                    .padding(.horizontal, 16)
                )
        }
        .buttonStyle(PlainButtonStyle())
    }
}

struct ContentView: View {
    var body: some View {
        ControlCenterView()
    }
}

#Preview {
    ContentView()
}
