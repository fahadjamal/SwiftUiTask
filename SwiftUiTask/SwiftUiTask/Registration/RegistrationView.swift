//
//  RegistrationView.swift
//  FirstTutorial
//
//  Created by TransData on 20/09/2023.
//

import SwiftUI

struct RegistrationView: View {
    @State var firstName: String = ""
    @State var middleName: String = ""
    @State var lastName: String = ""
    @State var LocationFacility: String = ""
    
    @State var emailID: String = ""
    @State var contactNumber: String = ""
     
    var body: some View {
        VStack (spacing: 30) {
            Group {
                VStack (alignment: .leading, spacing: 30,
                        content: {
                    InPutTextView(inputString: $firstName,
                                  lblTitle: "First Name*",
                                  placeHolder: "First Name")
                    
                    InPutTextView(inputString: $middleName,
                                  lblTitle: "Middle Name",
                                  placeHolder: "Middle Name")
                    
                    InPutTextView(inputString: $lastName,
                                  lblTitle: "Last Name",
                                  placeHolder: "Last Name")
                    
                    InPutTextView(inputString: $emailID,
                                  lblTitle: "Email ID",
                                  placeHolder: "Email ID")
                    
                    InPutTextView(inputString: $contactNumber,
                                  lblTitle: "Contact Number",
                                  placeHolder: "Contact Number")
                })
                                
                Button(action: {
                    print("Submit")
                }) {
                HStack {
                        Text("Submit")
                            .font(.subheadline)
                    }
                    .frame(minWidth: 0,
                           maxWidth: .infinity,
                           minHeight: 0,
                           maxHeight: 20)
                    .padding()
                    .foregroundColor(.white)
                    .background(Color("MainColor"))
                    .cornerRadius(40)
                }
            }
            
            Spacer()
        }
        .navigationBarBackButtonHidden(false) // hide the back button
        .navigationTitle("Sign Up")
        .padding(10)
    }
}

struct RegistrationView_Previews: PreviewProvider {
    static var previews: some View {
        RegistrationView()
    }
}
