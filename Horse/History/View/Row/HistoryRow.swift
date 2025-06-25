import SwiftUI

struct HistoryRow: View {
    let result: RaceResult
    let isExpanded: Bool
    
    var body: some View {
        VStack(spacing: 4) {
            HStack {
                VStack(alignment: .leading) {
                    Text("Заезд на " + String(format: "%.0f м", result.length))
                        .font(.title3.weight(.medium))
                    
                    Text(String(format: "%.2f сек.", result.duration))
                        .font(.footnote)
                        .foregroundStyle(.secondary)
                }
                        
                Spacer()
                
                VStack(alignment: .trailing, spacing: 4) {
                    Text("🏆 \(result.winnerName)")
                        .font(.headline.weight(.regular))
                    
                    Text(String(format: "%.2f сек", result.winnerTime))
                        .font(.footnote)
                        .foregroundStyle(.secondary)
                }
                
                Image(systemName: "chevron.right")
                    .font(.body)
                    .rotationEffect(.degrees(isExpanded ? 90 : 0))
            }
            .padding([.top, .horizontal], 12)
            .padding(.bottom, isExpanded ? 0 : 12)
            
            if isExpanded {
                Rectangle()
                    .fill(.secondary.opacity(0.2))
                    .frame(height: 1)
                
                VStack(spacing: 6) {
                    ForEach(result.placements, id: \.self) { placement in
                        HStack {
                            Text("#\(placement.place)")
                                .frame(width: 24, alignment: .leading)
                            
                            Text(placement.name)
                            
                            if placement.place == 1 {
                                Text("🏆")
                            }
                            
                            Spacer()
                            
                            Text(String(format: "%.2f c.", placement.time))
                        }
                        .font(.footnote)
                        .padding(.horizontal, 12)
                        
                        let isLast = placement.place == result.placements.count
                        if !isLast {
                            Rectangle()
                                .fill(.secondary.opacity(0.2))
                                .frame(height: 1)
                                .padding(.leading, 12)
                        }
                    }
                }
                .padding(.top, 6)
                .padding(.bottom, 12)
            }
        }
        .geometryGroup()
        .background(Color(.systemBackground))
        .clipShape(RoundedRectangle(cornerRadius: 8))
    }
}
