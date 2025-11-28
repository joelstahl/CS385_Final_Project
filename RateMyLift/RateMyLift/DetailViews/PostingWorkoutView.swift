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
    var workout: Workout
    @State var selectedPhoto: PhotosPickerItem?
    @State var selectedPhotoData: Data?
    @State var caption: String = ""
    
    
    @Environment(\.modelContext) private var modelContext
    @Environment(\.dismiss) private var dismiss
    @Query(filter: #Predicate<User> { $0.active == true })
    private var activeUsers: [User]

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
                    PhotosPicker(selection: $selectedPhoto, matching: .images, photoLibrary: .shared()) {
                        Label("Select a Workout Photo", systemImage: "photo.fill")
                    }
                    .buttonStyle(.borderedProminent)
                    .tint(.red)
                    .foregroundStyle(.white)
                    .onChange(of: selectedPhoto) { newItem in
                        Task {
                            if let data = try? await newItem?.loadTransferable(type: Data.self) {
                                selectedPhotoData = data
                            }
                        }
                    }
                    
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
            Button(action: createPost){
                Text("Post Workout")
            }
            .buttonStyle(.borderedProminent)
            .tint(.red)
            .padding(.horizontal, 150)
        }
    }
    private func createPost() {
            guard let user = activeUsers.first else {
                print("No active user to attach post to")
                return
            }

            let post = Post(
                photo: selectedPhotoData,
                timestamp: Date(),
                caption: caption,
                rating: 7.5,              // or hook up RateWorkout later
                comment: [],
                author: user,
                workout: workout
            )

            modelContext.insert(post)
            user.posts.append(post)

            do {
                try modelContext.save()
                dismiss()
            } catch {
                print("Error saving post: \(error)")
            }
        }
}

#Preview {
    PostingWorkoutView(workout: Workout())
}
