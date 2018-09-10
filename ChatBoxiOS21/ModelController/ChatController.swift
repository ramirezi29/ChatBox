//
//  ChatController.swift
//  ChatBoxiOS21
//
//  Created by Ivan Ramirez on 9/10/18.
//  Copyright © 2018 ramcomw. All rights reserved.
//

import Foundation

// HTTP PRotocols
// - 'GET', 'PUT, 'POST', 'PATCH', 'DELETE

// Put is idempotenent. no matter how many times you do it, the results will be the same.

class ChatController {
    
    static let shared = ChatController()
    
    var chats: [Chat] = []
    
    //#3
    let baseURL = URL(string: "https://messageing-app-f734a.firebaseio.com/")
    
    // CREAT
    //this is going to be true or false. it worked or it didnt
    // Escaping means that its going to escape out of our clousure and complete later
    func createChat(with message: String, completion: @escaping (Bool)-> Void) {
        // instance of chat code below
        let chat = Chat(message: message)
        guard let url = baseURL else {
            fatalError("Bad base url")
        }
        
        //----make the request
        //#2
        let builtURL = url.appendingPathComponent(chat.uuid.uuidString).appendingPathExtension("json")
        print("⚒ \(builtURL)")
        var request = URLRequest(url: builtURL)
        ///interview question what are the http Method types   git, post, patch delete
        //Define teh requet
        request.httpMethod = "PUT"
        //Define what you're sending ----
        // need a body to put in it
        // the httpBody wants data
        request.httpBody = chat.jsonData
        
        //#1
        URLSession.shared.dataTask(with: request) { (data, _, error) in
            // line 49 to 63 is just for the developer we do not have to do this
            if let error = error {
                //GOOD info for the developer if there is an error
                print("Error with dataTask: \(error) \(error.localizedDescription)")
                completion(false); return
            }
            // handle the data now
            
            //if it does work do the following code
            // we want all the chats back to display to the user
            
            if let data = data {
                let stringData = String(data: data, encoding: .utf8)
                print(stringData ?? "or do this")
                 completion(false); return
            }
            // if it does work, it will add a chat and complete with true
            self.chats.append(chat)
            // if its true were going to save
            completion(true)
            
            
            }.resume()
    }
    //     This is kindof like our completion closure of (Bool), but it will be true or false not just one
    //    func createChat2(wth message: String) -> Bool {
    //        return true
    //    }
    // Fetch - Read .
    
    // before you write the function, ask your self ** What do I want to complete with?
    
    func fetchChat(completion: @escaping (Bool) -> Void) {
        // URLSessions is the class that hold stuff
        //1) URL Session
        //2)Unwrap your base url
        //3)define your reuqest
        //#3 unwrap our base url
        guard let url = baseURL else {
            fatalError("bad base url")
        }
        //#2
        
        var request = URLRequest(url: url.appendingPathExtension("json"))
        //#4 both lines of code
        request.httpMethod = "GET"
        request.httpMethod = nil
        //#1
        URLSession.shared.dataTask(with: request) { (data, _, error) in
            if let error = error {
                //#5 put in the missing fields and put an error code
                print("Error with Get for Data Task \(error) \(error.localizedDescription)")
                completion(false); return
            }
            guard let dataThtCameBack = data else {completion(false); return }
            // sereilize form json
            do {
                // returns data into a swfit dictionary
                // ⚒ JSONSerialization is a drill. thats drilling down to get all the JSon back
                let chatDictionaries = try JSONSerialization.jsonObject(with: dataThtCameBack, options: .allowFragments) as?
                    [String: [String: String]]
                
                // next step
                //  the identifier is the the key, and the identifier is the value
                let chatsThatCameBack = chatDictionaries?.compactMap{Chat(dictionary: $0.value, identifier: $0.key)}
                self.chats = chatsThatCameBack ?? []
                completion(true)
            } catch let error {
                print("Error with JSONSErialization \(error) \(error.localizedDescription)")
                completion(false); return
            }
            }.resume()
    }
    
}
