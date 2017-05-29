//
//  DateTableViewCell.swift
//  Debugging
//
//  Created by Greg Heo on 5/29/17.
//  Copyright © 2017 Greg Heo. All rights reserved.
//

import UIKit

class DateTableViewCell: UITableViewCell {
  var dateFormatHelper: DateFormatHelper?

  func refresh() {
    self.dateFormatHelper?.formatForCell?(self)
  }
}
