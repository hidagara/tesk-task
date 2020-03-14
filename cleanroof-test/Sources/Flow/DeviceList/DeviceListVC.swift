//
//  DeviceListViewController.swift
//  cleanroof-test
//
//  Created by Roman Guseynov on 11.03.2020.
//  Copyright © 2020 Roman Guseynov. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class DeviceListVC: UIViewController {
  // MARK: Outlets
  @IBOutlet private weak var tableView: UITableView!
  
  // MARK: Properties
  var viewModel: DeviceListVM!
  private let disposeBag = DisposeBag()
  var addButton: UIBarButtonItem!
  
  // MARK: Lifecycle
  
  override func viewDidLoad() {
    super.viewDidLoad()
    self.setupUI()
    self.setupBindings()
  }
  
  private func setupUI() {
    self.setupTableView()
    self.setupAddButton()
  }
  
  private func setupBindings() {
    
    tableView.rx.modelSelected(Device.self).asDriver().drive(onNext: {
      model in
      self.viewModel.removeSubject.onNext(model)
    }).disposed(by: disposeBag)
    
     viewModel.devicesChanged
         .drive(
           tableView.rx.items(
             cellIdentifier: DeviceListTableViewCell.reuseIdentifier,
             cellType: DeviceListTableViewCell.self)) { model, target, cell in
               cell.configure(with: DeviceListCellModel(deviceName: target.name,
                                                      deviceModel: target.model, deviceOS: target.os))
       }.disposed(by: disposeBag)
  }
  
  private func setupTableView() {
    self.tableView.register (
      UINib(nibName: "DeviceListTableViewCell", bundle: nil),
      forCellReuseIdentifier: DeviceListTableViewCell.reuseIdentifier
    )
  }
  
  private func setupAddButton() {
    self.addButton = UIBarButtonItem (
      barButtonSystemItem: UIBarButtonItem.SystemItem.add,
      target: self,
      action: #selector(addButtonTapped(_:))
    )
    self.navigationItem.rightBarButtonItem = self.addButton
  }
  
  @objc func addButtonTapped(_ sender: UIBarButtonItem) {
    viewModel.addSubject.onNext(())
  }
}
