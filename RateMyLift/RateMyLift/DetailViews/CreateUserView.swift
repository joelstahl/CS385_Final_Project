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
    @State var username: String = ""
    @State var name: String = ""
    @State var bio: String = ""
    @State var selectedPhoto: PhotosPickerItem?
    @State var selectedPhotoData: Data?
    
    var body: some View {
        NavigationStack{
            Form{
                Section(header: Text("Username")){
                    TextField("Username", text: $username)
                }
                Section(header: Text("Name")){
                    TextField("Your Name", text: $name)
                }
                Section(header: Text("Bio")){
                    TextField("A little about yourself", text: $bio)
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
                        if let data = selectedPhotoData,
                           let uiImage = UIImage(data: data) {
                            Image(uiImage: uiImage)
                                .resizable()
                                .scaledToFill()
                                .frame(width:36, height: 36)
                                .clipShape(Circle())
                        } else {
                            Circle()
                                .frame(width:36, height: 36)
                                .overlay(
                                    Image(systemName: "photo")
                                        .font(.caption)
                                        .foregroundStyle(.gray)
                                )
                        }
                        VStack(alignment: .leading){
                            HStack{
                                Text("Username: ").bold()
                                Text(username)
                            }
                            HStack{
                                Text("Name: ").bold()
                                Text(name)
                            }
                            HStack{
                                Text("Bio: ").bold()
                                Text(bio)
                            }
                        }
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
                name: name,
                bio: bio,
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
