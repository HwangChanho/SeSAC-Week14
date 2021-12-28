//
//  LottoViewModel.swift
//  SeSAC-Week14
//
//  Created by AlexHwang on 2021/12/28.
//

import Foundation

class LottoViewModel {
    var lotto1 = Observable(3)
    var lotto2 = Observable(13)
    var lotto3 = Observable(32)
    var lotto4 = Observable(33)
    var lotto5 = Observable(43)
    var lotto6 = Observable(34)
    var lotto7 = Observable(35)
    var lottoMoney = Observable("")
    
    func fetchLottoAPI(_ number: Int) {
        APIService.lotto(number: number) { data, error in
            guard let data = data else {
                return
            }
            
            self.lotto1.value = data.drwtNo1
            self.lotto2.value = data.drwtNo2
            self.lotto3.value = data.drwtNo3
            self.lotto4.value = data.drwtNo4
            self.lotto5.value = data.drwtNo5
            self.lotto6.value = data.drwtNo6
            self.lotto7.value = data.bnusNo
            
            self.lottoMoney.value = self.format(for: data.firstWinamnt)
        }
    }
    
    func format(for number: Int) -> String {
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .decimal
        let result = numberFormatter.string(for: number)!
        return result
    }
}
