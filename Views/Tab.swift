//
//  TabView.swift
//  LostDogs
//
//  Created by AMStudent on 12/6/21.
//

import SwiftUI

struct Tab: View {
    @State var users = Users()
    var body: some View {
        TabView {
            CitiesView()
                .tabItem {
                    Text("Cities")
                }
            List(users.sortedPeople) { person in
            PersonRow(
                person: person,
                image: $users.uiImages[person]
            )
            }
                .tabItem {
                    Text("Missing dogs")
                }
            InfoView()
                .tabItem {
                    Text("Information")
                }
        }
    }
}
struct InfoView: View {
    var body: some View {
        
        List {
            Link(destination: URL (string: "https://www.missinganimalresponse.com/")!) {
                Text("Missing Animal Response")
            }
            
            Link(destination: URL (string: "https://lostdogsofamerica.org/")!) {
                Text("Lost Dogs of America")

        }
            
            Link(destination: URL (string: "https://petfbi.org/#/")!) {
                Text("Helping Lost Pets")
            }
            
            Link(destination: URL (string: "https://www.foundanimals.org/")!) {
                Text("Michelson Found Animals Foundation")
            }
            
            Link(destination: URL (string: "https://www.cityoftulsa.org/government/departments/working-in-neighborhoods/animal-welfare/")!) {
                Text("Animal Welfare - City of Tulsa")
            }
            
            Link(destination: URL (string: "https://www.lostmydoggie.com/missing-pets.cfm?petkindid=1&alerttypeid=1&zipcode=74137&radius=50")!) {
                Text("LostMyDoggie")
            }
            
            Link(destination: URL (string: "https://tulsaspca.org/")!) {
                Text("Tulsa SPCA")
            }
            
        }
    }
}

struct CitiesView: View {
    @State var searchingFor = ""
    let cities = ["Tulsa", "Bixby", "Glenpool", "Jenks", "Broken Arrow", "Owasso", "Sand Springs"]
    
    var body: some View {
        NavigationView {
            List {
                ForEach(results, id: \.self) { city in
                    NavigationLink(destination: Text(city)) {
                        Text(city)
                    }
                }
            }
            .searchable(text: $searchingFor)
            .navigationTitle("Dogs in local Area")
        }
    }
    
    var results: [String] {
        if searchingFor.isEmpty {
            return cities
        } else {
            return cities.filter { $0.contains(searchingFor) }
        }
    }
}



struct PersonRow: View {
    @ObservedObject var person: Person
    @Binding var image: UIImage?

    var body: some View {
        
        NavigationLink(
            destination: DetailView(person: person, image: $image)
        ) {
            HStack {
                Person.Image(
                    uiImage: image,
                    title: person.name,
                    size: 80,
                    cornerRadius: 12
                )
            
                VStack(alignment: .leading) {
                    NameAndUsernameStack(
                        person: person,
                        nameFont: .title2,
                        usernameFont: .title3
                    )
                    
                    if !person.bio.isEmpty {
                    Spacer()
                    Text(person.bio)
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                  }
                }
                .lineLimit(1)
                    
                Spacer()
                
            
           }
            .padding(.vertical, 8)
        }
    }
}
//struct TabView_Previews: PreviewProvider {
//    static var previews: some View {
//        TabView()
//    }
//}
