//
//  ContentView.swift
//  CircularProgressBarTest
//
//  Created by Scholar on 7/31/25.
//

import SwiftUI

struct ContentView: View {
    
    @State private var totalHours: Double = 80
    @State private var hoursCompleted: Double = 40
    
    var percentageCompletion: Double {
        return hoursCompleted / totalHours
    }
    
    var body: some View {
        VStack(spacing: 40) {
            VStack(spacing: 16) {
                Text("Progress Control")
                    .font(.title2)
                    .fontWeight(.semibold)
                    .foregroundColor(.primary)
                
                HStack(spacing: 16) {
                    Text("0 hrs")
                        .font(.caption)
                        .fontWeight(.medium)
                        .foregroundColor(.secondary)
                    
                    Slider(value: $hoursCompleted, in: 0...totalHours)
                        .accentColor(.orange)
                        .animation(.easeInOut(duration: 0.3), value: hoursCompleted)
                    
                    Text("\(Int(totalHours)) hrs")
                        .font(.caption)
                        .fontWeight(.medium)
                        .foregroundColor(.secondary)
                }
                .padding(.horizontal)
            }
            .padding(.horizontal, 20)
            
            // Enhanced Circular Progress Bar
            ZStack {
                // Background shadow circle
                Circle()
                    .stroke(Color.black.opacity(0.1), lineWidth: 2)
                    .frame(width: 220, height: 220)
                    .offset(x: 2, y: 2)
                
                // Background track
                Circle()
                    .stroke(
                        LinearGradient(
                            colors: [Color.gray.opacity(0.2), Color.gray.opacity(0.1)],
                            startPoint: .topLeading,
                            endPoint: .bottomTrailing
                        ),
                        lineWidth: 18
                    )
                    .frame(width: 200, height: 200)
                
                // Progress arc with gradient
                Circle()
                    .trim(from: 0, to: CGFloat(percentageCompletion))
                    .stroke(
                        LinearGradient(
                            colors: [
                                Color.orange.opacity(0.8),
                                Color.orange,
                                Color.red.opacity(0.8)
                            ],
                            startPoint: .topLeading,
                            endPoint: .bottomTrailing
                        ),
                        style: StrokeStyle(lineWidth: 18, lineCap: .round)
                    )
                    .frame(width: 200, height: 200)
                    .rotationEffect(.degrees(-90))
                    .shadow(
                        color: Color.orange.opacity(0.3),
                        radius: 8,
                        x: 0,
                        y: 0
                    )
                    .animation(.easeInOut(duration: 0.5), value: percentageCompletion)
                
                // Inner content area
                VStack(spacing: 8) {
                    Text("\(Int(percentageCompletion * 100))")
                        .font(.system(size: 48, weight: .bold, design: .rounded))
                        .foregroundColor(.primary)
                        .contentTransition(.numericText())
                        .animation(.easeInOut(duration: 0.3), value: percentageCompletion)
                    
                    Text("%")
                        .font(.title2)
                        .fontWeight(.medium)
                        .foregroundColor(.secondary)
                    
                    // Progress indicator dots
                    HStack(spacing: 4) {
                        ForEach(0..<5, id: \.self) { index in
                            Circle()
                                .frame(width: 6, height: 6)
                                .foregroundColor(
                                    percentageCompletion >= Double(index) / 4.0 ?
                                    Color.orange : Color.gray.opacity(0.3)
                                )
                                .scaleEffect(
                                    percentageCompletion >= Double(index) / 4.0 ? 1.2 : 1.0
                                )
                                .animation(
                                    .easeInOut(duration: 0.3).delay(Double(index) * 0.1),
                                    value: percentageCompletion
                                )
                        }
                    }
                    .padding(.top, 4)
                }
            }
            .frame(width: 240, height: 240)
            .background(
                Circle()
                    .fill(
                        RadialGradient(
                            colors: [
                                Color.white,
                                Color.gray.opacity(0.05)
                            ],
                            center: .center,
                            startRadius: 5,
                            endRadius: 120
                        )
                    )
                    .frame(width: 240, height: 240)
                    .shadow(
                        color: Color.black.opacity(0.1),
                        radius: 20,
                        x: 0,
                        y: 10
                    )
            )
            
            Spacer()
        }
        .padding(.top, 40)
        .background(
            LinearGradient(
                colors: [
                    Color(.systemBackground),
                    Color.gray.opacity(0.02)
                ],
                startPoint: .top,
                endPoint: .bottom
            )
            .ignoresSafeArea()
        )
    }
}

#Preview {
    ContentView()
}
