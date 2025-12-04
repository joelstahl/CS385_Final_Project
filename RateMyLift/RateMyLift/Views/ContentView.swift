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
// https://chatgpt.com/c/691b817e-b844-8333-a528-1340dfbb9b99
// fixing query issues
// https://chatgpt.com/c/69220db3-30f4-832c-85cd-637b77871f69
// help with error when following tutorial video
// https://chatgpt.com/c/6922041d-39ec-8326-b710-1a6fc0d8ecd3
// advise on querying user and posts for views before build
// https://chatgpt.com/c/69249cac-78fc-8320-9da9-1ed296742c8e
// this helped with an infinite recursion error
// https://chatgpt.com/c/6923a38d-f538-8328-a91c-17cc98d4f323
// this helped by creating the workout session struct to allow for a temporary place to store data before assigning it to the user
// https://chatgpt.com/c/69239637-d4a0-8330-a160-1e1681b0e0c9
// helped with changing the healthkit query time from the whole day to a specific start and end
// https://chatgpt.com/c/692492e8-1544-8322-8968-f8af05fbabb4
// simple error, just wrapped in VStack
// https://chatgpt.com/c/6924e6c1-1110-8326-9d3b-887d4d96fe73
// changed navigation link to use image as the label
// https://chatgpt.com/c/6924e99c-d64c-8327-bcfc-a9c766c3f5de
// helped by externally wrapping profile view instead of in the view itself
// https://chatgpt.com/c/6925f00a-59ac-8328-aaa3-ef3a030f1d92
// helped create drop down menu
// https://chatgpt.com/c/69311261-ace0-8333-ab65-310c15bfae60
// this helped when we changed our model and our app kept crashing. We changed the new struct attributes to be optional
// https://chatgpt.com/c/6930fe3b-c61c-832d-811f-732c32c2121b
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
