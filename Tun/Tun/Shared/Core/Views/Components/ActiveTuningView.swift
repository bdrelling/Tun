import InstrumentKit
import MusicKit
import SwiftUI
import TunerKit

struct ActiveTuningView: View {
    @Binding var selection: Tuning
    let data: TunerData

    var body: some View {
        HStack(spacing: 16) {
            ForEach(self.selection.notes) { note in
                Group {
                    if let closestNote = self.closestNote {
                        Text(note.name)
                            .fontWeight(note == closestNote ? .bold : .medium)
                            .opacity(note == closestNote ? 1 : 0.65)
                    } else {
                        Text(note.name)
                    }
                }
                .foregroundColor(.white)
            }
        }
        .padding()
    }

    private var closestNote: Note? {
        self.selection.notes.closest(to: self.data.frequency)
    }
}

// MARK: - Previews

struct ActiveTuningView_Previews: PreviewProvider {
    static var previews: some View {
        ActiveTuningView(
            selection: .constant(Instrument.guitar.standardTuning),
            data: .mocked()
        )
        .background(Color.theme.inactiveTunerBackgroundColor)
        .previewMatrix(.sizeThatFits)
    }
}
