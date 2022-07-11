// Copyright © 2022 Brian Drelling. All rights reserved.

import KippleUI
import MusicKit
import SwiftUI

struct NotePicker: View {
    @Environment(\.dismiss) private var dismiss
    
    private let itemHeight: CGFloat = 60
    private let itemVerticalSpacing: CGFloat = 20
    private let itemHorizontalSpacing: CGFloat = 40

    @Binding var selection: Note?
    
    @State private var selectedSemitone: Semitone?
    @State private var selectedOctave: Octave?

    var body: some View {
        NavigationView {
            VStack(spacing: self.itemVerticalSpacing) {
//                NotePickerItem(action: self.clearSelectedNote) {
//                    Text("Clear")
//                }
//                .frame(height: 60)
                
                HStack(spacing: self.itemHorizontalSpacing) {
                    ScrollViewReader { reader in
                        ScrollView(showsIndicators: false) {
                            VStack(spacing: self.itemVerticalSpacing) {
                                ForEach(Semitone.allCases) { semitone in
                                    SemitoneItem(semitone: semitone, selection: self.$selectedSemitone)
                                }
                            }
                            .frame(maxWidth: .infinity)
                        }
                        .onAppear {
                            if let selectedSemitone = self.selectedSemitone {
                                reader.scrollTo(selectedSemitone.id)
                            }
                        }
                    }
                    
                    ScrollViewReader { reader in
                        ScrollView(showsIndicators: false) {
                            VStack(spacing: self.itemVerticalSpacing) {
                                ForEach(Octave.allCases) { octave in
                                    OctaveItem(octave: octave, selection: self.$selectedOctave)
                                }
                            }
                            .frame(maxWidth: .infinity)
                        }
                        .onAppear {
                            if let selectedOctave = self.selectedOctave {
                                reader.scrollTo(selectedOctave.id)
                            }
                        }
                    }
                }
            }
            .edgesIgnoringSafeArea(.bottom)
            .padding(.vertical)
            .padding(.horizontal, self.itemHorizontalSpacing)
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .font(.title)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button(action: self.clearSelectedNote) {
                        Text("Clear")
                    }
                }
                
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: { self.dismiss() }) {
                        Text("Done")
                    }
                }
            }
            .navigationTitle("Select a Note")
            .navigationBarTitleDisplayMode(.inline)
            .onChange(of: self.selectedSemitone) { _ in
                self.updateSelectedNote()
            }
            .onChange(of: self.selectedOctave) { _ in
                self.updateSelectedNote()
            }
            .onAppear {
                print("Opening NotePicker with selection: \(self.selection?.name ?? "nil")")
            }
        }
    }
    
    init(selection note: Binding<Note?>) {
        self._selection = note
        
        self._selectedSemitone = .init(initialValue: note.wrappedValue?.semitone)
        self._selectedOctave = .init(initialValue: note.wrappedValue?.octave)
    }
    
    private func clearSelectedNote() {
        self.selection = nil
        
        self.selectedOctave = nil
        self.selectedSemitone = nil
        
        self.dismiss()
    }
    
    private func updateSelectedNote() {
        guard let selectedSemitone = selectedSemitone, let selectedOctave = selectedOctave else {
            self.selection = nil
            return
        }
        
        let selection: Note = .init(selectedSemitone, octave: selectedOctave.rawValue)
        
        self.selection = selection
    }
}

// MARK: - Supporting Types

private struct NotePickerItem<Content>: View where Content: View {
    private let isSelected: Bool
    private let action: () -> Void
    private let content: () -> Content
    
    private var backgroundColor: Color {
        if self.isSelected {
            return .theme.closestTunerBackgroundColor
        } else {
            return .theme.cellBackgroundColor
        }
    }
    
    var body: some View {
        Button(action: self.action) {
            content()
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .background(self.backgroundColor)
                .cornerRadius(10)
        }
    }
    
    init(
        isSelected: Bool = false,
        action: @escaping () -> Void,
        @ViewBuilder _ content: @escaping () -> Content
    ) {
        self.isSelected = isSelected
        self.action = action
        self.content = content
    }
}

private struct SemitoneItem: View {
    var semitone: Semitone
    @Binding var selection: Semitone?
    
    private var isSelected: Bool {
        self.semitone == self.selection
    }
    
    var body: some View {
        NotePickerItem(
            isSelected: self.isSelected,
            action: { self.selection = self.semitone }
        ) {
            Text(self.semitone.name(for: .both))
        }
        .aspectRatio(1, contentMode: .fit)
    }
}

private struct OctaveItem: View {
    var octave: Octave
    @Binding var selection: Octave?
    
    private var isSelected: Bool {
        self.octave == self.selection
    }
    
    var body: some View {
        NotePickerItem(
            isSelected: self.isSelected,
            action: { self.selection = self.octave }
        ) {
            VStack {
            Text("\(self.octave.rawValue)")
                
                if let name = self.octave.name {
                    Text(name)
                        .font(.caption)
                }
            }
        }
        .aspectRatio(1, contentMode: .fit)
    }
}

// MARK: - Previews

struct NotePicker_Previews: PreviewProvider {
    @State private var isPresenting = false

    static var previews: some View {
        NotePicker(selection: .constant(nil))
            .previewMatrix()
        
        NotePicker(selection: .constant(nil))
            .previewInModal()
    }
}
