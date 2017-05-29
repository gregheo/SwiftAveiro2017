//
//  DateFormatHelper.swift
//  Debugging
//

import UIKit

class DateFormatHelper {
  var date: Date
  var dateFormatter: DateFormatter

  init(date: Date, dateFormatter: DateFormatter) {
    self.date = date
    self.dateFormatter = dateFormatter
  }

  var formatForCell: ((UITableViewCell) -> Void)?
  var formatForLabel: ((UILabel) -> Void)?
}
