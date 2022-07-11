// Copyright © 2022 Brian Drelling. All rights reserved.

import KippleUI
import MusicKit
import SwiftUI

struct NotePicker: View {
    @Environment(\.dismiss) private var dismiss

    @Binding var selection: Note?

    var body: some View {
        NavigationView {
            VStack {
                Spacer()
                Text("Wow!")
                Spacer()
                Button("Press to dismiss") {
                    self.dismiss()
                }
                Spacer()
            }
            .background(
                Color.purple
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
            )
            .font(.title)
            .padding()
            .background(.black)
            .navigationTitle("Select a Note")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

// MARK: - Previews

struct NotePicker_Previews: PreviewProvider {
    @State private var isPresenting = false

    static var previews: some View {
        NotePicker(selection: .constant(nil))
//            .previewInModal()
            .previewMatrix()
    }
}
