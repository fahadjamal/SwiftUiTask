//
//  ComicListView.swift
//  FirstTutorial
//
//  Created by TransData on 26/09/2023.
//

import SwiftUI

struct ComicListView: View {
    @StateObject var vm: ComicListViewModal = ComicListViewModal()
    @State var data: [Comic] = []
    
    var body: some View {
        ZStack(alignment:.top){
            VStack{
                VStack(spacing:0){
                    ScrollView{
                        LazyVStack{
                            ForEach(data, id: \.self) { item in
                                TaskViewRow(item: item)
                                    .background(RoundedRectangle(cornerRadius: 8).stroke(Color.gray).shadow(color:Color.black.opacity(0.25), radius: 3))
                                    .padding(.vertical, 7)
                                
                            }
                        }
                    }
                }
                .frame(maxWidth: .infinity)
                .padding(.horizontal, 10)
                .redacted(reason: vm.isLoading ? .placeholder: [])
                Spacer()
            }
        }
        .onAppear{
            self.getTasksList()
        }
    }
}

struct ComicListView_Previews: PreviewProvider {
    static var previews: some View {
        ComicListView()
    }
}

extension ComicListView {
    func getTasksList(){
        Task {
            DispatchQueue.main.async {
                vm.isLoading = true
            }
            vm.loadMarvelList() { result in
                DispatchQueue.main.async {
                    vm.isLoading = false
                }
                switch result {
                case .success(_):
                    print("getTasksList success")
                    if let comicsResponse = vm.comicsResponse,
                        let comicsResponseData = comicsResponse.data,
                        let comicList = comicsResponseData.results {
                        self.data = comicList
                    }
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
        }
    }
}

struct TaskViewRow:View{
    @State var item: Comic?
    var body: some View {
        VStack(spacing:0){
            VStack(spacing:3) {
                VStack{
                    Text("Name:")
                        .font(.system(.largeTitle, design: .rounded))
                    Text(item?.title ?? "")
                        .font(.system(.title3, design: .rounded))
                    Spacer()
                    
                }
                .padding(.top,10)
                .padding(.vertical, 10)
                
                VStack{
                    Text("Description:")
                        .font(.system(.largeTitle, design: .rounded))
                    Text(item?.description ?? "")
                        .font(.system(.title3, design: .rounded))
                    Spacer()
                }
                .padding(.vertical, 10)
            }
        }
    }
}
