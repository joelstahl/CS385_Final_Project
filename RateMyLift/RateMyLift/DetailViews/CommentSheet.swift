//
//  CommentSheet.swift
//  RateMyLift
//
//  Created by Devyn Myles on 11/25/25.
//

import SwiftUI

struct CommentSheet: View {
    @Environment(\.dismiss) private var dismiss
    
    @Binding var commentText: String
    var onPost: (() -> Void)? = nil     // optional callback
    
    @State private var isEditing: Bool = false
    let maxLength: Int = 250            // change if you want
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 16) {
                // Title
                Text("Add a Comment")
                    .font(.title2.bold())
                    .frame(maxWidth: .infinity, alignment: .leading)
                
                // Comment box
                ZStack(alignment: .topLeading) {
                    // Placeholder
                    if commentText.isEmpty {
                        Text("Write something about this workout…")
                            .foregroundColor(.secondary)
                            .padding(.horizontal, 6)
                            .padding(.vertical, 8)
                    }
                    
                    TextEditor(text: $commentText)
                        .frame(minHeight: 120, maxHeight: 180)
                        .padding(4)
                        .background(Color.gray.opacity(0.1))
                        .clipShape(RoundedRectangle(cornerRadius: 12))
                        .onTapGesture {
                            isEditing = true
                        }
                }
                
                // Character count
                HStack {
                    Spacer()
                    Text("\(commentText.count)/\(maxLength)")
                        .font(.caption)
                        .foregroundColor(commentText.count > maxLength ? .red : .secondary)
                }
                
                Spacer()
                
                // Post button
                Button {
                    // Optional: enforce max length
                    if commentText.count > maxLength {
                        commentText = String(commentText.prefix(maxLength))
                    }
                    
                    onPost?()
                    dismiss()
                } label: {
                    Text("Post Comment")
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.red)
                        .foregroundColor(.white)
                        .clipShape(RoundedRectangle(cornerRadius: 16))
                        .font(.headline)
                }
                .disabled(commentText.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty)
                .opacity(commentText.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty ? 0.5 : 1)
                
            }
            .padding()
            .presentationDetents([.fraction(0.4), .medium])
            .presentationDragIndicator(.visible)
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button("Cancel") {
                        dismiss()
                    }
                }
            }
        }
    }
}


#Preview {
    CommentSheet(commentText: .constant(""))
}
