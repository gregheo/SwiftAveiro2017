//
//  MasterViewController.swift
//  Debugging
//

import UIKit

class MasterViewController: UITableViewController {
  lazy var dateFormatter: DateFormatter = {
    let df = DateFormatter()
    df.dateStyle = .long
    df.timeStyle = .long
    return df
  }()

  var detailViewController: DetailViewController? = nil
  var dates = TableViewModel<Date>()

  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view, typically from a nib.
    navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Reverse", style: .plain, target: self, action: #selector(reverseItems))

    let addButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(insertNewObject(_:)))
    navigationItem.rightBarButtonItem = addButton
    if let split = splitViewController {
      let controllers = split.viewControllers
      detailViewController = (controllers[controllers.count-1] as! UINavigationController).topViewController as? DetailViewController
    }
  }

  override func viewWillAppear(_ animated: Bool) {
    clearsSelectionOnViewWillAppear = splitViewController!.isCollapsed
    super.viewWillAppear(animated)
  }

  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }

  func insertNewObject(_ sender: Any) {
    dates.add(Date())
    let indexPath = IndexPath(row: 0, section: 0)
    tableView.insertRows(at: [indexPath], with: .automatic)
  }

  // MARK: - Segues

  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    if segue.identifier == "showDetail" {
      if let indexPath = tableView.indexPathForSelectedRow, let date = dates.item(at: indexPath.row) {
        let controller = (segue.destination as! UINavigationController).topViewController as! DetailViewController
        controller.detailItem = date
        controller.dateFormatHelper = dateFormatHelperForDate(date: date)
        controller.navigationItem.leftBarButtonItem = splitViewController?.displayModeButtonItem
        controller.navigationItem.leftItemsSupplementBackButton = true
      }
    }
  }

  // MARK: - Table View

  override func numberOfSections(in tableView: UITableView) -> Int {
    return 1
  }

  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return dates.items.count
  }

  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> DateTableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! DateTableViewCell

    if let date = dates.item(at: indexPath.row) {
      cell.dateFormatHelper = dateFormatHelperForDate(date: date)
      cell.refresh()
    } else {
      cell.textLabel?.text = "???"
    }

    return cell
  }

  override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
    // Return false if you do not want the specified item to be editable.
    return false
  }

  override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
    if editingStyle == .delete {
      dates.remove(at: indexPath.row)
      tableView.deleteRows(at: [indexPath], with: .fade)
    }
  }

  func reverseItems() {
      self.dates.reverse()
      self.tableView.reloadData()
  }

  private func dateFormatHelperForDate(date: Date) -> DateFormatHelper {
    let formatHelper = DateFormatHelper(date: date, dateFormatter: dateFormatter)
    formatHelper.formatForCell = { cell in
      cell.textLabel?.text = self.dateFormatter.string(from: date)
    }

    return formatHelper
  }
}
