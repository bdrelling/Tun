import InstrumentKit
import MusicKit
import SwiftUI
import TunerKit

struct NotePickerButton: View {
    @Binding var selection: Note?
    
    let data: TunerData
    
    @State private var isShowingNotePicker = false

    var body: some View {
        Group {
            Button(action: self.showNotePicker) {
                if let selectedNote = self.selection {
                    Text(selectedNote.name)
                } else {
                    Text("Select a Note")
                        .opacity(0.35)
                }
            }
        }
        .padding()
        .background {
            RoundedRectangle(cornerRadius: 10)
                .stroke(.white)
                .opacity(0.35)
        }
        .font(.title2)
        .sheet(isPresented: self.$isShowingNotePicker) {
            NotePicker(selection: self.$selection)
        }
    }
    
    private func showNotePicker() {
        self.isShowingNotePicker.toggle()
    }
}

// MARK: - Previews

struct ActiveNoteView_Previews: PreviewProvider {
    static var previews: some View {
        NotePickerButton(
            selection: .constant(.standard),
            data: .mocked()
        )
        .background(Color.theme.inactiveTunerBackgroundColor)
        .previewMatrix(.sizeThatFits)
    }
}
