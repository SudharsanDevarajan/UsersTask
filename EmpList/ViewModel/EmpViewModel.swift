//
//  EmpViewModel.swift
//  EmpList
//
//  Created by htcuser on 03/08/22.
//

import SwiftUI

class EmpViewModel: ObservableObject{
    

    
    @Published var employees = [Employee]()
    
    private let userDataService = UserDataService()
    

    
    func loadData() async{
        if userDataService.savedUsers.isEmpty{
            guard let url = URL(string: "http://www.mocky.io/v2/5d565297300000680030a986") else {return}
            var request = URLRequest(url: url)
            request.setValue("6132", forHTTPHeaderField: "Content-Length")
            request.setValue("application/json; charset=UTF-8", forHTTPHeaderField: "Content-Type")
            
            do{
                let (data,error) = try await URLSession.shared.data(for: request)
                print("Data", data)
                if let decodeResponse = try? JSONDecoder().decode([Employee].self, from: data){
                    DispatchQueue.main.async {
                        for emp in decodeResponse{
                            self.userDataService.addUser(user: emp)
                        }
                        print("Emp saved to coredata")
                        self.fetch()
                    }
                    
                }else{
                    print("Decode Error \(error)")
                }
            }catch{
                print("Error")
            }
            print("Fetch from API")
        }else{
            fetch()
            print("Fetch from coreData")
        }
    }
    
    func fetch(){
        var tempEmp: [Employee] = []
        for item in userDataService.savedUsers{
            let emp = Employee(id: Int(item.id),
                               name: item.name ?? "",
                               username: item.username ?? "",
                               email: item.email ?? "",
                               profileImage: item.imageUrl ?? "",
                               address: Address(street: item.address ?? "",
                                                suite: "",
                                                city: "",
                                                zipcode: "",
                                                geo: Geo(lat: "",
                                                         lng: "")),
                               phone: "",
                               website: item.website ?? "",
                               company: Company(name: item.company ?? "",
                                                catchPhrase: "",
                                                bs: "")
            )
            tempEmp.append(emp)
        }
        self.employees.append(contentsOf: tempEmp)
    }
}
