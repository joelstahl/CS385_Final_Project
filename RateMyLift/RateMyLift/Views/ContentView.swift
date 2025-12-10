//
//  ContentView.swift
//  RateMyLift
//
//  Created by Joel Stahl on 11/16/25.
//
// DOCUMENTATION:
// TUTORIAL VIDEOS:
//  Healthkit video: https://www.google.com/search?q=healthkit+swift+examples&rlz=1C5OZZY_enUS1175US1175&oq=healthkit+swift+examples&gs_lcrp=EgZjaHJvbWUyBggAEEUYOTIICAEQABgWGB4yCggCEAAYgAQYogQyBwgDEAAY7wUyCggEEAAYgAQYogQyBwgFEAAY7wUyBwgGEAAY7wXSAQgzOTc0ajBqN6gCALACAA&sourceid=chrome&ie=UTF-8#fpstate=ive&vld=cid:931c14ef,vid:ORJ9rvqoR9s,st:0
//  Instagram feed video: https://www.google.com/search?q=instagram+style+post+and+feed+in+swift&sca_esv=0848d8a94e784f53&rlz=1C5OZZY_enUS1175US1175&sxsrf=AE3TifNwnHWbJBNYSNMktA9m-EfVmBTMjQ%3A1763960771086&ei=w-cjaZWIBaGZkPIP6MWWUA&ved=0ahUKEwjV9aH5gYqRAxWhDEQIHeiiBQoQ4dUDCBE&uact=5&oq=instagram+style+post+and+feed+in+swift&gs_lp=Egxnd3Mtd2l6LXNlcnAiJmluc3RhZ3JhbSBzdHlsZSBwb3N0IGFuZCBmZWVkIGluIHN3aWZ0MgUQIRigATIFECEYoAEyBRAhGKABMgUQIRigATIFECEYnwUyBRAhGJ8FMgUQIRifBTIFECEYnwVIjxNQ2gRYjBJwAXgBkAEAmAFYoAG1BaoBATm4AQPIAQD4AQGYAgqgAucFwgIKEAAYRxjWBBiwA8ICBRAhGKsCmAMAiAYBkAYIkgcCMTCgB51AsgcBObgH3wXCBwUxLjQuNcgHGg&sclient=gws-wiz-serp#fpstate=ive&vld=cid:6b84f223,vid:jANfmTbiDLc,st:0
//  Instagram style profile video: https://www.google.com/search?q=instragram+profile+in+swift+using+lazyvgrod&rlz=1C5OZZY_enUS1175US1175&oq=instragram+profile+in+swift+using+lazyvgrod&gs_lcrp=EgZjaHJvbWUyBggAEEUYOTIJCAEQIRgKGKABMgkIAhAhGAoYoAEyCQgDECEYChigATIJCAQQIRgKGKABMgcIBRAhGI8CMgcIBhAhGI8C0gEJMTE5MzVqMGo3qAIAsAIA&sourceid=chrome&ie=UTF-8#fpstate=ive&vld=cid:b8a4baef,vid:xKn5M5YsQas,st:0
//  Dropdown selector https://www.google.com/search?q=how+to+create+a+dropdown+selector+in+swift&rlz=1C5OZZY_enUS1175US1175&oq=how+to+create+a+dropdown+selector+in+swift&gs_lcrp=EgZjaHJvbWUyBggAEEUYOTIICAEQABgWGB4yCAgCEAAYFhgeMggIAxAAGBYYHjINCAQQABiGAxiABBiKBTIHCAUQABjvBTIHCAYQABjvBTIHCAcQABjvBdIBCDc4OTZqMGo3qAIAsAIA&sourceid=chrome&ie=UTF-8
// ChatGPT Links:
// https://chatgpt.com/share/6939f28e-d538-8007-b625-aee8ce0289e6
// fixing query issues
// https://chatgpt.com/share/6939e7d8-c308-8007-88fd-c625c179b373
// help with error when following tutorial video
// https://chatgpt.com/share/6939f2b7-4c18-8007-9761-5157b068e2af
// advise on querying user and posts for views before build
// https://chatgpt.com/share/6939f2d2-c07c-8007-8b6a-1306155972df
// this helped with an infinite recursion error
// https://chatgpt.com/share/6939f2e7-9860-8007-813a-965bb7a6af60
// this helped by creating the workout session struct to allow for a temporary place to store data before assigning it to the user
// https://chatgpt.com/share/6939f2fd-a82c-8007-9301-f20b4b14f6fa
// helped with changing the healthkit query time from the whole day to a specific start and end
// https://chatgpt.com/share/6939f310-f9dc-8007-af70-a2f8df19e43a
// simple error, just wrapped in VStack
// https://chatgpt.com/share/6939f323-cc2c-8007-8eaa-dd5c88b082de
// changed navigation link to use image as the label
// https://chatgpt.com/share/6939f337-a648-8007-a295-2ec8dcb1131d
// helped by externally wrapping profile view instead of in the view itself
// https://chatgpt.com/share/6939f34b-598c-8007-b748-2f9fed24d78b
// helped create drop down menu
// https://chatgpt.com/share/6939f361-2f54-8007-949e-f4f4e563c64c
// this helped when we changed our model and our app kept crashing. We changed the new struct attributes to be optional
// https://chatgpt.com/share/6939f37a-0888-8007-92a4-07896bb735b6
// this helped with profileView navigation crashing and using "selected post" for passing a post into postDetails view.
//https://chatgpt.com/share/69312809-739c-8002-8815-dde54df3a70c
// this helped to figure out why when actually running the project the view would shift to the left but in the preview window it was running fine
// https://chatgpt.com/share/69312890-f440-8002-b97c-47a5c2aa94ec
// this was used to figure out why a function that was working in a different view would not work in profileFromFeed with how the bool function worked
// https://chatgpt.com/share/69312e21-13fc-8002-9f32-b31cdccf4400
// Used for idea on how the RateWorkout sheet shoud look



import SwiftUI
import SwiftData

struct ContentView: View {
    @Environment(\.modelContext) private var modelContext

    var body: some View {
            TabBar()
        }
        
    }
#Preview {
    ContentView()
        .modelContainer(for: User.self, inMemory: true)
}
