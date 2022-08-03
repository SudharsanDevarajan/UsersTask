//
//  EmpModel.swift
//  EmpList
//
//  Created by htcuser on 03/08/22.
//

import SwiftUI

struct Response: Codable{
    let results: [Employee]
}

struct Employee: Codable,Hashable {
    
    let id: Int
    let name, username, email: String
    let profileImage: String?
    let address: Address
    let phone, website: String?
    let company: Company?

    enum CodingKeys: String, CodingKey {
        case id, name, username, email
        case profileImage = "profile_image"
        case address, phone, website, company
    }
    
    static func == (lhs: Employee, rhs: Employee) -> Bool {
        lhs.id ==  rhs.id
    }
}

// MARK: - Address
struct Address: Codable,Hashable{
    let street, suite, city, zipcode: String
    let geo: Geo
}

// MARK: - Geo
struct Geo: Codable,Hashable {
    let lat, lng: String
}

// MARK: - Company
struct Company: Codable,Hashable {
    let name, catchPhrase, bs: String
}




extension Employee{
    static let testEmployee = Employee(id: 1,
                                       name: "https://randomuser.me/api/portraits/men/1.jpg",
                                       username: "Sudharsan",
                                       email: "Devaraj Sudharsan",
                                       profileImage: "devarajsudharsan@gmail.com",
                                       address: Address(street: "Street",
                                                        suite: "Suite",
                                                        city: "City",
                                                        zipcode: "Zipcode",
                                                        geo: Geo(lat: "lat",
                                                                 lng: "lang")),
                                       phone: "9042595961",
                                       website: "www.google.com",
                                       company: Company(name: "name",
                                                        catchPhrase: "catch",
                                                        bs: "bs")
    )
}
