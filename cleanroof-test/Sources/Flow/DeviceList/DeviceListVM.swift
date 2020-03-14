//
//  DeviceListVM.swift
//  cleanroof-test
//
//  Created by Roman Guseynov on 12.03.2020.
//  Copyright © 2020 Roman Guseynov. All rights reserved.
//

import RxSwift
import RxCocoa
import FirebaseAuth
import FirebaseDatabase

class DeviceListVM {
  
  // MARK: Reactive Properties
  let addSubject: PublishSubject<Void> = PublishSubject()
  let removeSubject: PublishSubject<Device> = PublishSubject()
  private(set) var devicesChanged: Driver<DeviceList>!
  private let disposeBag = DisposeBag()
  
  // MARK: Properties
  private var ref: DatabaseReference!
  
  init() {
    ref = Database.database().reference()
    setupBindings()
  }
  
  private func setupBindings() {
    
    devicesChanged =
      ref
        .rx_observeEvent(event: .value).map({ value in
          return DeviceList(snapshot: value) ?? DeviceList(elements: [])
        })
      .asDriver(onErrorDriveWith: .empty())
    
    addSubject.subscribe(onNext: {
      device in
      let device = Device(uuid: UUID.init().uuidString,
                          name: UIDevice.current.name,
                          model: UIDevice.current.model,
                          os: UIDevice.current.systemVersion)
      let devicesRef = self.ref?.child("devices").child(device.uuid)
      devicesRef?.setValue(device.toAnyObject())
    }
    ).disposed(by: disposeBag)
    
    removeSubject.subscribe(onNext: { value in
      let listRef = self.ref?.child("devices").child(value.uuid)
      listRef?.removeValue()
      }
    ).disposed(by: disposeBag)
  }
}
