//
//  RealmDataManager.swift
//  TasCar
//
//  Created by Enrique Republic on 01/08/2019.
//  Copyright © 2019 Enrique Canedo. All rights reserved.
//

import RealmSwift
import RxRealm
import RxSwift

final class RealmDataManager {
    
    static let shared = RealmDataManager()
    
    let realmScheduler = RealmThreadWithRunLoopScheduler(name: "RealmScheduler")
    
    #if REALM
    private let sortDescriptorCar = [SortDescriptor(keyPath: "model", ascending: true), SortDescriptor(keyPath: "type", ascending: true)]
    
    func list<T: Object>(type: T.Type) -> Single<[T]> {
        return Observable.deferred { () -> Observable<[T]> in
            guard let realm = try? Realm(configuration: RealmConfiguration.config) else {
                return Observable.error(RealmDataManagerError.unknown)
            }
            
            return Observable.of(realm.objects(type).sorted(byKeyPath: "name").toArray())
            }
            .subscribeOn(realmScheduler).asSingle()
    }
 
    func listCars(withBrand brand: Brand? = nil, withModel model: String? = nil) -> Single<[CarEntity]> {
        return Observable.deferred { () -> Observable<[CarEntity]> in
            guard let realm = try? Realm(configuration: RealmConfiguration.config) else {
                return Observable.error(RealmDataManagerError.unknown)
            }
            
            let predicate: NSPredicate
            switch (brand, model) {
            case (let brand?, let model?):
                predicate = NSPredicate(format: "brand.idBrand = %d AND model = %@", brand.idBrand, model)
            case (let brand?, _):
                predicate = NSPredicate(format: "brand.idBrand = %d", brand.idBrand)
            case (_, let model?):
                predicate = NSPredicate(format: "model = %@", model)
            default:
                predicate = NSPredicate()
            }
            return Observable.of(realm.objects(CarEntity.self).filter(predicate).sorted(by: self.sortDescriptorCar).toArray())
            }
            .subscribeOn(realmScheduler).asSingle()
    }

    #endif
    
}
