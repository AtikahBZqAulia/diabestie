//
//  UserDefaults.swift
//  Diabestie
//
//  Created by Dhiky Aldwiansyah on 08/04/21.
//

import Foundation


extension UserDefaultManager {
    
    func setDefaultLogin(){
        saveDefaultBool(key: UserDefaultManager.IS_USER_LOGGED_IN, value: true)
    }
    
    func getDefaultLogin() -> Bool {
        return getDefaultBool(key: UserDefaultManager.IS_USER_LOGGED_IN)
    }
    
}


class UserDefaultManager {

    static let sharedManager = UserDefaultManager()
    
    static let IS_USER_LOGGED_IN = "is_user_logged_in"

    func saveDefault(key:String, value:String){
        UserDefaults.standard.set(value, forKey: key)
        UserDefaults.standard.synchronize()
    }
    
    func saveDefaultBool(key:String, value:Bool){
        UserDefaults.standard.set(value, forKey: key)
        UserDefaults.standard.synchronize()
    }
    
    func getDefaultString(key:String) -> String{
        return UserDefaults.standard.object(forKey: key) == nil ? "" : UserDefaults.standard.object(forKey: key) as! String
    }
    
    func getDefaultBool(key:String) -> Bool{

        return (UserDefaults.standard.object(forKey: key) != nil)
    }
    
    func removeDefaultKey(key: String){
        UserDefaults.standard.removeObject(forKey: key)
        UserDefaults.standard.synchronize()
    }
    
    func clearAllData(){
        let defaults = UserDefaults.standard
        let dictionary = defaults.dictionaryRepresentation()
        dictionary.keys.forEach { key in
            print("DATA CLEAR \(key)")
            defaults.removeObject(forKey: key)
        }
    }

}
