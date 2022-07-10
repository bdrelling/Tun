// Copyright © 2022 Brian Drelling. All rights reserved.

import Foundation
import MusicKit
import SwiftUI

struct NoteFrequencyTable: View {
    private let tableBackgroundColor: Color = .primary.opacity(0.15)
    private let cellBackgroundColor: Color = .theme.backgroundColor
    private let textColor: Color = .primary
    private let borderWidth: CGFloat = 0.5

    private let rowHeight: CGFloat = 40
    private let headerColumnWidth: CGFloat = 60
    private let frequencyColumnWidth: CGFloat = 100

    private var minimumTableWidth: CGFloat {
        self.headerColumnWidth + (CGFloat(Octave.allCases.count) * self.frequencyColumnWidth)
    }

    var body: some View {
        GeometryReader { geometry in
            ScrollView(.horizontal, showsIndicators: true) {
                VStack(alignment: .leading, spacing: self.borderWidth) {
                    self.headerRow
                    self.frequencyRows
                }
                // TODO: When this is set, the view centers in the ScrollView instead of left-aligning.
                .frame(width: self.tableWidth(using: geometry))
                .background(self.tableBackgroundColor)
                .foregroundColor(self.textColor)
            }
            .background(self.cellBackgroundColor)
        }
    }

    @ViewBuilder private var headerRow: some View {
        HStack(spacing: self.borderWidth) {
            Group {
                Text("Note")
                    .fontWeight(.bold)
                    .frame(width: self.headerColumnWidth)

                ForEach(Octave.allCases) { octave in
                    VStack(spacing: 2) {
                        Text("\(octave.rawValue)")
                            .fontWeight(.bold)
                        Text(octave.name)
                            .font(.caption)
                    }
                    .frame(minWidth: self.frequencyColumnWidth, maxWidth: .infinity)
                }
            }
            .padding(.vertical, 8)
            .frame(maxHeight: .infinity)
            .background(self.cellBackgroundColor)
        }
        .frame(maxWidth: .infinity)
    }

    private var frequencyRows: some View {
        ForEach(Semitone.allCases) { semitone in
            HStack(spacing: self.borderWidth) {
                Group {
                    Text(semitone.name)
                        .fontWeight(.bold)
                        .frame(width: self.headerColumnWidth)

                    ForEach(Octave.allCases) { octave in
                        let note = Note(semitone, octave: octave.rawValue)
                        Text("\(note.frequency, specifier: "%.2f") Hz")
                            .lineLimit(1)
                            .minimumScaleFactor(0.5)
                            .frame(minWidth: self.frequencyColumnWidth, maxWidth: .infinity)
                    }
                }
                .padding(.vertical, 8)
                .frame(maxHeight: .infinity)
                .background(self.cellBackgroundColor)
            }
            .frame(maxWidth: .infinity)
        }
    }

    private func tableWidth(using geometry: GeometryProxy) -> CGFloat {
        if geometry.size.width > self.minimumTableWidth {
            return geometry.size.width
        } else {
            return self.minimumTableWidth
        }
    }
}

struct NoteRow {}

// MARK: - Previews

@available(iOS 16.0, macOS 12.0, *)
@available(tvOS, unavailable)
@available(watchOS, unavailable)
struct NoteFrequencyTable_Previews: PreviewProvider {
    static var previews: some View {
        NoteFrequencyTable()
            .previewMatrix(.fixedSize(width: 400, height: 500))
//            .previewMatrix(.sizeThatFits)
    }
}
