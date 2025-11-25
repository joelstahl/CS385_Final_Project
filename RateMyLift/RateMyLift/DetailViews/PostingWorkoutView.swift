//
//  PostWorkoutView.swift
//  RateMyLift
//
//  Created by Joel Stahl on 11/24/25.
//

import SwiftUI
import PhotosUI
import SwiftData

struct PostingWorkoutView: View {
    @State var workout: Workout
    @State var selectedPhoto: PhotosPickerItem?
    @State var selectedPhotoData: Data?
    @State var caption: String = ""
    
    
    @Environment(\.modelContext) private var modelContext
    @Environment(\.dismiss) private var dismiss

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(workout.name)
                .font(.title)
                .bold()
                .padding()
            
            Text("Start: \(workout.start, format: Date.FormatStyle(date: .numeric))").padding(.horizontal, 8)
            Text("End: \(workout.end ?? Date(), format: Date.FormatStyle(date: .numeric))").padding(.horizontal, 8)
            
            
            Text(String(format: "%.1f", workout.avgHeartRate) + " BPM (Average)").padding(.horizontal, 8)
            Text(String(format: "%.1f", workout.totalcalories) + " Total Calories Burned").padding(.horizontal, 8)
            
            Text("Exercises:")
                .font(.headline)
                .padding(.top, 8)
                .padding(.horizontal, 8)
            
            ForEach(workout.exercises) { exercise in
                VStack(alignment: .leading) {
                    Text(exercise.name)
                        .font(.subheadline)
                    
                    ForEach(exercise.sets) { aset in
                        HStack {
                            Text("Reps: \(aset.reps)")
                            Text("Weight: \(aset.weight)")
                        }
                        .font(.caption)
                    }
                }
                .padding(.vertical, 4)
                .padding(.horizontal, 8)
            }
            Form{
                Section(header: Text("Add a Photo of the lift")){
                    PhotosPicker(selection: $selectedPhoto, matching: .images, photoLibrary: .shared()){
                        Label("Select a Workout Photo", systemImage: "photo.fill")
                    }
                    .buttonStyle(.borderedProminent)
                    .tint(.red)
                    .foregroundStyle(.white)
                    
                    if let imageData = selectedPhotoData,
                       let uiImage = UIImage(data: imageData) {
                        Image(uiImage: uiImage)
                            .resizable()
                            .scaledToFit()
                    }
                    
                    if selectedPhotoData != nil {
                        Button (role: .destructive){
                            withAnimation{
                                selectedPhoto = nil
                                selectedPhotoData = nil
                            }
                        }label: {
                            Label("Remove Image", systemImage: "xmark.circle").foregroundStyle(.red)
                        }
                    }
                }
                Section(header: Text("Add a caption for your post")){
                    TextEditor(text: $caption)
                        .frame(minHeight: 80)
                        .lineLimit(3)
                }
                
            }
            .padding()
            Button(action: {}){
                Text("Post Workout")
            }
            .buttonStyle(.borderedProminent)
            .tint(.red)
            .padding(.horizontal, 150)
        }
    }
}

#Preview {
    PostingWorkoutView(workout: Workout())
}
