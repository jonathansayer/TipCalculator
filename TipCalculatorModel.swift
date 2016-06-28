import UIKit
import Foundation

class TipCalculatorModel {
  
  var total: Double
  var taxPct: Double
  var subtotal: Double {
    get {
      return total / (taxPct + 1)
    }
  }
  
  init(total: Double, taxPct: Double) {
    self.total = total
    self.taxPct = taxPct
  }
  
  func calcTipWithTipPct(tipPct:Double) -> (tipAmt:Double, total:Double) {
    let tipAmt = subtotal * tipPct
    let finalTotal = total + tipAmt
    return (tipAmt, finalTotal)
  }
  
  func returnPossibleTips() -> [Int: (tipAmt:Double, total:Double)] {
    
    let possibleTipsInferred = [0.15, 0.18, 0.20]
    
    var retval = [Int: (tipAmt:Double, total:Double)]()
    for possibleTip in possibleTipsInferred {
      let intPct = Int(possibleTip*100)
      retval[intPct] = calcTipWithTipPct(possibleTip)
    }
    return retval
    
  }
}


class TestDataSource : NSObject, UITableViewDataSource {
  
  let tipCalc = TipCalculatorModel(total: 33.25, taxPct: 0.06)
  var possibleTips = Dictionary<Int, (tipAmt:Double, total:Double)>()
  var sortedKeys:[Int] = []
  
  override init() {
    possibleTips = tipCalc.returnPossibleTips()
    sortedKeys = Array(possibleTips.keys).sort()
    super.init()
  }
  
  func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
    return sortedKeys.count
  }
  
  func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
    
    let cell = UITableViewCell(style: UITableViewCellStyle.Value2, reuseIdentifier: nil)
    
    
    let tipPct = sortedKeys[indexPath.row]
    
    let tipAmt = possibleTips[tipPct]!.tipAmt
    let total = possibleTips[tipPct]!.total
    
    cell.textLabel?.text = "\(tipPct)%:"
    cell.detailTextLabel?.text = String(format:"Tip: $%0.2f, Total: $%0.2f", tipAmt, total)
    return cell
  }
}