//
//  DetailViewController.swift
//  Debugging
//

import UIKit

class DetailViewController: UIViewController {
  @IBOutlet var detailDescriptionLabel: UILabel?

  var detailItem: Date?
  var dateFormatHelper: DateFormatHelper?

  func configureView() {
    self.dateFormatHelper?.formatForLabel?(detailDescriptionLabel!)
  }

  override func viewDidLoad() {
    super.viewDidLoad()

    dateFormatHelper?.formatForLabel = { label in
      label.text = self.detailItem?.description
    }

    // Do any additional setup after loading the view, typically from a nib.
    configureView()
  }

  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }

}

