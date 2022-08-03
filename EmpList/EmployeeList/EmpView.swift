//
//  EmpView.swift
//  EmpList
//
//  Created by htcuser on 03/08/22.
//

import SwiftUI
import Kingfisher

struct EmpView: View {
    
    @StateObject private var viewModel = EmpViewModel()
    
    var body: some View {
        NavigationStack{
            List{
                ForEach(viewModel.employees,id: \.id) { user in
                    NavigationLink(value: user) {
                        HStack{
                            if let image = user.profileImage{
                                KFImage(URL(string: image))
                                    .resizable()
                                    .scaledToFill()
                                    .frame(width: 62, height: 62)
                                    .clipShape(Circle())
                            }else{
                                Circle()
                                    .frame(width: 62, height: 62)
                                    .foregroundColor(.gray)
                            }
                            
                            
                            VStack(alignment: .leading,spacing: 4){
                                Text(user.name)
                                    .font(.title3)
                                    .fontWeight(.medium)
                                    .foregroundColor(.black)
                                Text(user.company?.name ?? "name")
                                    .font(.headline)
                                    .foregroundColor(.gray)
                                
                            }
                        }
                    }
                }
            }
            .listStyle(.plain)
            .navigationTitle("Users")
            .navigationDestination(for: Employee.self) { employee in
                EmpDetailView(empDetail: employee)
            }
        }
        .task {
            await viewModel.loadData()
        }
        
    }
}

struct EmpView_Previews: PreviewProvider {
    static var previews: some View {
        EmpView()
    }
}
