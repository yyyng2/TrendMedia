//
//  UserShoppingListRepository.swift
//  TrendMedia
//
//  Created by Y on 2022/08/26.
//

import Foundation

import RealmSwift

protocol UserShoppingListRepositoryType{
    func fetch() -> Results<UserShoppingList>
    func fetchSort(_ sort: String) -> Results<UserShoppingList>
    func fetchFilter() -> Results<UserShoppingList>
    func fetchDate(date: Date) -> Results<UserShoppingList>
    func updateFavorite(record: UserShoppingList)
    func deleteRecord(record: UserShoppingList)
    func addRecord(record: UserShoppingList)
}

class UserShoppingListRepository: UserShoppingListRepositoryType{

    func fetchDate(date: Date) -> Results<UserShoppingList> {
        return localRealm.objects(UserShoppingList.self).filter("ShoppingRegisterDate >= %@ AND ShoppingRegisterDate < %@", date, Date(timeInterval: 86400, since: date)) //NSPredicate
    }
    
    func addRecord(record: UserShoppingList) {
        do{
            try localRealm.write {
                localRealm.add(record)
            }
        }catch{
            print(error)
        }
      
    }
    
    //여러 곳에서 생성해도 하나의 Realm에 접근
    let localRealm = try! Realm() // struct
    
    func fetch() -> Results<UserShoppingList> {
        return localRealm.objects(UserShoppingList.self).sorted(byKeyPath: "ShoppingTitle", ascending: true)
    }
    
    func fetchSort(_ sort: String) -> Results<UserShoppingList>{
        return localRealm.objects(UserShoppingList.self).sorted(byKeyPath: sort, ascending: true)
    }
    
    func fetchFilter() -> Results<UserShoppingList>{
        return localRealm.objects(UserShoppingList.self).filter("ShoppingTitle CONTAINS[c] 'a'")
    }
    
    func updateFavorite(record: UserShoppingList) {
        
        do{
            try localRealm.write {
             
                record.ShoppingFavorite = !record.ShoppingFavorite
                
            }
        } catch{
            print(error)
        }
        
    
    }
    
    func updateDoDate(record: UserShoppingList, date: String){
        do{
            try localRealm.write{
                localRealm.create(UserShoppingList.self, value: ["objectId": record.objectId, "ShoppingDoDate": date], update: .modified)
            }
        }catch{
            print(error)
        }
    }
    
    //저장된 이미지 지우기
    func removeImageFromDocument(fileName: String){
        // 앱의 document 경로
        guard let documentDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else { return }
        // 세부 파일 경로, 이미지 저장할 위치
        let fileURL = documentDirectory.appendingPathComponent(fileName)
        
        do {
            try FileManager.default.removeItem(at: fileURL)
        } catch let error{
            print(error)
        }
    }
    
    func deleteRecord(record: UserShoppingList){
        // 셀삭제로 indexPath가 먼저 삭제되면 이미지의 indexPath.row의 id값이 바뀌기 때문에 indexPath가 그대로일때 사진먼저 삭제!
        removeImageFromDocument(fileName: "\(record.objectId).jpg")
        do{
            try localRealm.write{
                localRealm.delete(record)
            }
        } catch {
            print(error)
        }
       
     
    }
    
}
