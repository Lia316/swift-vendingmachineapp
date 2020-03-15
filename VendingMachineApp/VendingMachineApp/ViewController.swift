//
//  ViewController.swift
//  VendingMachineApp
//
//  Created by kimdo2297 on 2020/03/04.
//  Copyright © 2020 Jason. All rights reserved.
//

import UIKit

final class ViewController: UIViewController {
    
    @IBOutlet var beverageNumberLabels: [BeverageNumberLabel]!
    @IBAction func plusBeverageButtonTapped(_ sender: PlusBeverageButton) {
        if let beverage = sender.beverage() {
            vendingMachine.addToStock(beverage: beverage)
        }
    }
    
    @IBOutlet weak var balanceLabel: BalanceLabel!
    
    @IBAction func plusBalanceButtonTapped(_ sender: PlusBalanceButton) {
        if let money = sender.money() {
            vendingMachine.receive(insertedMoney: money)
        }
    }

    private var vendingMachine = VendingMachine()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        NotificationCenter.default.addObserver(forName: Notification.Name.beveragesChanged,
                                               object: vendingMachine,
                                               queue: nil) { [weak self] _ in
                                                self?.changeLabelNumber() }
    }
    
    private func changeLabelNumber() {
        let stockByKind = vendingMachine.stockByKind()
        beverageNumberLabels.forEach {
            if let beverage = $0.beverage(),
            let beverageNumber = stockByKind[beverage.kind] {
                $0.update(number: beverageNumber)
            }
        }
    }
    
}
