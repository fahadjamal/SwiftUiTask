//
//  ContentView.swift
//  FirstTutorial

import SwiftUI
import Combine

struct LoginView: View {
    @State var isComicActive: Bool = false
    @State var isRegActive: Bool = false
    
    @StateObject var vm = LoginViewModal()
    
    var body: some View {
        NavigationView {
            VStack {
                Spacer()
                    .frame(height: 40)
                
                Image("Login_Logo")
                    .scaledToFit()
                    .padding(.bottom, 20.0)
                
                Spacer()
                
                VStack {
                    Group {
                        VStack (alignment: .center,
                                content: {
                            InPutTextView(inputString: $vm.email,
                                          lblTitle: "Email",
                                          placeHolder: "Enter Email ID")
                            
                            Spacer()
                                .frame(height: 30)
                            
                            InPutTextView(inputString: $vm.password,
                                          lblTitle: "Password",
                                          placeHolder: "Enter Password")
                        })
                        
                        HStack(alignment: .bottom) {
                            Spacer()
                            Button(action: {
                                //action
                                print("forget Button Tapped")
                            }) {
                                Text("Forgot password?")
                                    .font(.system(.subheadline,
                                                  design: .rounded))
                                    .foregroundColor(.black)
                            }
                        }
                        .padding(.top, 10)
                        .padding(.bottom, 10)
                        
                        NavigationLink(destination: ComicListView(), isActive: $isComicActive) {
                            Button(action: {
                                vm.signIn()
                                isComicActive = true
                            }) {
                                HStack {
                                        Text("Sign In")
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
                    }
                }.centerInParentView()
                
                Spacer()
                
                Group {
                    Spacer()
                    HStack(alignment: .center, spacing: 3) {
                        Text("New user?")
                            .font(.system(.subheadline,
                                          design: .rounded))
                            .foregroundColor(.black)
                        
                        NavigationLink(destination: RegistrationView(), isActive: $isRegActive) {
                            Button(action: {
                                //action
                                print("forget Button Tapped")
                                isRegActive = true
                            }) {
                                Text("Sign up")
                                    .font(.system(.subheadline,
                                                  design: .rounded))
                                    .foregroundColor(Color("MainColor"))
                            }
                        }
                        
                        Text("Here")
                            .font(.system(.subheadline,
                                          design: .rounded))
                            .foregroundColor(.black)
                    }
                    
                    Spacer()
                        .frame(height: 15)
                    
                    HStack(alignment: .center, spacing: 3) {
                        Text("By creating an account, you agree to our Terms of Service and Privacy Policy")
                            .frame(width: 300)
                            .font(.system(.caption,
                                          design: .rounded))
                            .foregroundColor(.black)
                            .multilineTextAlignment(.center)
                    }
                    
                    Spacer()
                        .frame(height: 15)
                    
                    HStack(alignment: .bottom) {
                        Text("Note that this platform may only be accessed by authorized users.")
                            .font(.system(.caption))
                            .foregroundColor(.black)
                            .multilineTextAlignment(.leading)
                    }
                }
            }
            .padding()
            .navigationBarTitle("", displayMode: .inline)
        }
    }
    
    init() {
        let navBarAppearance = UINavigationBarAppearance()
        navBarAppearance.largeTitleTextAttributes = [.foregroundColor: UIColor.black,
                                                     .font: UIFont(name: "ArialRoundedMTBold", size: 35)!]
        navBarAppearance.titleTextAttributes = [.foregroundColor: UIColor.black, .
                                                            font: UIFont(name: "ArialRoundedMTBold", size: 20)!]
        
        navBarAppearance.setBackIndicatorImage(UIImage(systemName: "arrow.backward"), transitionMaskImage: UIImage(systemName: "arrow.backward"))
        
        UINavigationBar.appearance().standardAppearance = navBarAppearance
        UINavigationBar.appearance().scrollEdgeAppearance = navBarAppearance
        UINavigationBar.appearance().compactAppearance = navBarAppearance
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}

struct InPutTextView: View {
    @State private var emailSeparator: Color = .gray
    @Binding var inputString: String
    
    var lblTitle: String
    var placeHolder: String
    
    var body: some View {
        VStack (spacing: 8) {
            Text(lblTitle)
                .padding(.leading, 10)
                .padding(.trailing, 10)
                .foregroundColor(Color("MainColor"))
                .font(.subheadline)
                .frame(maxWidth: .infinity, alignment: .leading)
            
            TextField(placeHolder,
                      text: $inputString)
            .onReceive(Just(inputString), perform: { inputString in
                print(inputString)
                if inputString.count > 0 {
                    emailSeparator = Color("MainColor")
                }
                else {
                    emailSeparator = .gray
                }
            })
            .textFieldStyle(.plain)
            .padding(.leading, 10)
            .padding(.trailing, 10)
            
            Rectangle()
                .frame(height: 2)
                .foregroundColor($emailSeparator.wrappedValue)
                .padding(.leading, 10)
                .padding(.trailing, 10)
        }
    }
}

extension View {
    func centerInParentView() -> some View {
        VStack(alignment: .center) {
            self
        }
        .frame(maxWidth: .infinity)
    }
}
