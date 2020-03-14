//
//  DeviceListTableViewCell.swift
//  cleanroof-test
//
//  Created by Roman Guseynov on 13.03.2020.
//  Copyright © 2020 Roman Guseynov. All rights reserved.
//

import UIKit

class DeviceListTableViewCell: UITableViewCell {
  
  static let reuseIdentifier = "DeviceListTableViewCell"

  // MARK: Outlets
  @IBOutlet weak private var deviceNameLabel: UILabel!
  @IBOutlet weak private var deviceOsLabel: UILabel!
  @IBOutlet weak private var deviceModeLabel: UILabel!
  
  func configure(with deviceInfo: DeviceListCellModel) {
    self.deviceNameLabel.text = deviceInfo.deviceName
    self.deviceOsLabel.text = deviceInfo.deviceOS
    self.deviceModeLabel.text = deviceInfo.deviceModel
  }
}
