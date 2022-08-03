//
//  EmpDetailView.swift
//  EmpList
//
//  Created by htcuser on 03/08/22.
//

import SwiftUI
import Kingfisher

struct EmpDetailView: View {
    
    var empDetail: Employee
    
    var body: some View {
        ScrollView(.vertical, showsIndicators: true) {
            VStack(alignment: .leading){
                
                if let image = empDetail.profileImage{
                    KFImage(URL(string: image))
                        .resizable()
                        .scaledToFill()
                        .frame(width: 150, height: 150)
                        .clipShape(Circle())
                }else{
                    Circle()
                        .frame(width: 150, height: 150)
                        .foregroundColor(.gray)
                }
                
                
                Text(empDetail.name)
                    .font(.largeTitle)
                
                Text("@\(empDetail.username)")
                    .font(.title2)
                    .foregroundColor(.gray)
                
                Divider()
                
                
                HStack{
                    VStack(alignment: .leading,spacing: 22){
                        HStack{
                            Image(systemName: "envelope")
                                .foregroundColor(.gray)
                            Text("\(empDetail.email)")
                                .font(.headline)
                        }
                        
                        HStack{
                            Image(systemName: "phone")
                                .foregroundColor(.gray)
                            Text("\(empDetail.phone ?? "Not given")")
                                .font(.headline)
                        }
                        
                        HStack{
                            Image(systemName: "map")
                                .foregroundColor(.gray)
                            Text("\(empDetail.address.city) , \(empDetail.address.street), \(empDetail.address.zipcode)")
                                .font(.headline)
                        }
                        
                        HStack{
                            Image(systemName: "list.bullet.rectangle.portrait")
                                .foregroundColor(.gray)
                            Text("\(empDetail.company?.name ?? "Not given")")
                                .font(.headline)
                        }
                        
                        HStack{
                            Image(systemName: "globe")
                                .foregroundColor(.gray)
                            Text("\(empDetail.website ?? "Not given")")
                                .font(.headline)
                        }
                    }
                    
                    Spacer()
                    
                }
                .padding(.top,12)
                
            }
            .padding()
            .navigationBarTitleDisplayMode(.inline)
            .navigationTitle("Details")
        }
        
    }
}

struct EmpDetailView_Previews: PreviewProvider {
    static var previews: some View {
        EmpDetailView(empDetail: Employee.testEmployee)
    }
}
