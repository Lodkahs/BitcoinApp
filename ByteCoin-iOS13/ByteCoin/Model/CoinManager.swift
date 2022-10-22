//
//  CoinManager.swift
//  ByteCoin
//
//  Created by Angela Yu on 11/09/2019.
//  Copyright © 2019 The App Brewery. All rights reserved.
//

import Foundation

protocol BitcoinManagerDelegate {
    func didUpdateBitcoinPrice(price: String, currency: String)
    func didFailWithError(error: Error)
}

struct CoinManager {
    
    var delegate: BitcoinManagerDelegate?
    
    let baseURL = "https://rest.coinapi.io/v1/exchangerate/BTC"
    let apiKey = "9C1F683B-2C1E-433C-8A9F-A2622B446523" //token
    
    
    
    let currencyArray = ["AUD", "BRL","CAD","CNY","EUR","GBP","HKD","IDR","ILS","INR","JPY","MXN","NOK","NZD","PLN","RON","RUB","SEK","SGD","USD","ZAR"]
    
    func getCoinPrice(for currency: String) {
        
        let bitcoinUrl = ("\(baseURL)/\(currency)?apikey=\(apiKey)")
        
        if let url = URL(string: bitcoinUrl) {
            
            let session = URLSession(configuration: .default)
            
            let task = session.dataTask(with: url) { (data, response, error) in
                if error != nil {
                    self.delegate?.didFailWithError(error: error!)
                    return
                }
                
                if let safeData = data {
                    if let coin = self.parseJSON(safeData) {
                        let priceOne = String(format: "%.2f", coin)
                        self.delegate?.didUpdateBitcoinPrice(price: priceOne, currency: currency)
                    }
                }
            }
            task.resume()
        }
    }
    
    /*func performRequest(with bitcoinUrl: String, currency: String) {
        
    }*/
    
    func parseJSON(_ data: Data) -> Double? {
        let decoder = JSONDecoder()
        
        do {
            let coinData = try decoder.decode(BitcoinData.self, from: data)
            let price = coinData.rate
            print("price is \(price)")
            return price
        } catch {
            self.delegate?.didFailWithError(error: error)
            print("error in JSON")
            return nil
        }
    
}

}
