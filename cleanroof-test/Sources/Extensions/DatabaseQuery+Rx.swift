//
//  DatabaseQuery+Rx.swift
//  cleanroof-test
//
//  Created by Roman Guseynov on 13.03.2020.
//  Copyright © 2020 Roman Guseynov. All rights reserved.
//

import RxSwift
import FirebaseDatabase

extension DatabaseQuery {
  
  func rx_observeSingleEvent(of event: DataEventType) -> Observable<DataSnapshot> {
    return Observable.create({ (observer) -> Disposable in
      self.observeSingleEvent(of: event, with: { (snapshot) in
        observer.onNext(snapshot)
        observer.onCompleted()
      }, withCancel: { (error) in
        observer.onError(error)
      })
      return Disposables.create()
    })
  }
  
  func rx_observeEvent(event: DataEventType) -> Observable<DataSnapshot> {
    return Observable.create({ (observer) -> Disposable in
      let handle = self.observe(event, with: { (snapshot) in
        observer.onNext(snapshot)
      }, withCancel: { (error) in
        observer.onError(error)
      })
      return Disposables.create {
        self.removeObserver(withHandle: handle)
      }
    })
  }
}
