//
//  UserDataService.swift
//  EmpList
//
//  Created by htcuser on 03/08/22.
//

import Foundation
import CoreData

class UserDataService{
    private let container: NSPersistentContainer
    private let containerName: String = "UserModel"
    private let entityName: String = "User"
    
    @Published var savedUsers: [User] = []
    
    init() {
        self.container = NSPersistentContainer(name: containerName)
        container.loadPersistentStores { _, error in
            if error != nil{
                print("Error loading container")
            }
            self.getUsers()
        }
    }
    
    private func getUsers(){
        let request = NSFetchRequest<User>(entityName: entityName)
        do{
            savedUsers = try container.viewContext.fetch(request)
        }catch{
            print("Error fetching users")
        }
    }
    
    
    func addUser(user: Employee){
        let entity = User(context: container.viewContext)
        entity.id = Int32(user.id)
        entity.imageUrl = user.profileImage
        entity.name = user.name
        entity.username = user.username
        entity.email = user.email
        entity.address = "\(user.address.city), \(user.address.street), \(user.address.zipcode)"
        entity.company = user.company?.name ?? ""
        entity.website = user.website
        applyChanges()
    }
    
    func deleteAllData(){
        // Create Fetch Request
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "User")

        // Create Batch Delete Request
        let batchDeleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)

        do {
            try container.viewContext.execute(batchDeleteRequest)

        } catch {
            print("Deleted")
        }
    }
    
    
    private func save(){
        do{
            try container.viewContext.save()
        }catch{
            print("Error in saving")
        }
    }
    
    private func applyChanges(){
        save()
        getUsers()
    }
    
}
