//
//  CreateUserView.swift
//  RateMyLift
//
//  Created by Joel Stahl on 11/25/25.
//

import SwiftUI
import PhotosUI
import SwiftData

struct CreateUserView: View {
    @Environment(\.modelContext) private var modelContext
    @Environment(\.dismiss) private var dismiss
    @Query private var users: [User]
    //@State var user: User
    @State var username: String = ""
    @State var selectedPhoto: PhotosPickerItem?
    @State var selectedPhotoData: Data?
    //@State var posts : [Posts] = []
    //@State var workouts: [Workouts] = []
    //@State var friends: [User] = []
    //@State var isActive: Bool = true
    
    
    
    
    var body: some View {
        NavigationStack{
            Form{
                Section(header: Text("Username")){
                    TextField("Username", text: $username)
                }
                Section(header: Text("Add A Picture For Your Profile")){
                    PhotosPicker(selection: $selectedPhoto, matching: .images, photoLibrary: .shared()) {
                        Label("Select a Profile Picture", systemImage: "photo.fill")
                    }
                    .buttonStyle(.plain)
                    .tint(.white)
                    .foregroundStyle(.red)
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
                Section(header: Text("User Profile")){
                    HStack{
                        Circle()
                            .fill(.gray.opacity(0.4))
                            .frame(width: 36, height: 36)
                            .overlay(Image(systemName: "person.fill"))
                        Text(username)
                    }
                }
                Section{
                    Button("Confirm and Create Profile") {
                    createUser()
                    }
                    .buttonStyle(.borderedProminent)
                    .tint(.red)
                    .foregroundStyle(.white)
                }
            }
            .navigationBarTitle("Create User")
        }
    }
    
    private func createUser() {
            // only one active user at a time
            for u in users {
                u.active = false
            }

            let newUser = User(
                userName: username,
                profilePicture: selectedPhotoData,
                posts: [],
                friendsList: [],
                workouts: [],
                active: true
            )
            modelContext.insert(newUser)

            do {
                try modelContext.save()
                dismiss()
            } catch {
                print("Failed to save user: \(error)")
            }
        }
    }
    //on save create user save to model context
#Preview {
    CreateUserView()
}
