//
//  DeleteAppointment.swift
//  eSTEstudio
//
//  Created by Bogdan Grec on 13/07/2020.
//  Copyright © 2020 bgrec. All rights reserved.
//

/*import Foundation

 class DeleteAppointment {

 private func loginAuth(username: String, password: String) -> String {
 let loginData = String(format: "%@:%@", username, password).data(using: String.Encoding.utf8)!
 let base64LoginData = loginData.base64EncodedString()
 return base64LoginData
 }

 private func urlComponent(queryParams: QueryParams) -> URLComponents {
 var urlComponents = queryParams.urlComponents
 urlComponents.scheme = queryParams.scheme
 urlComponents.host = queryParams.host
 urlComponents.path = queryParams.path
 urlComponents.queryItems = queryParams.queryItems
 return urlComponents
 }

 private func loadData(old: Bool) {

 let urlComponents = urlComponent(queryParams: QueryParams(old: old))

 guard let url = urlComponents.url
 else {
 fetchItemsCompletionBlock?(false, nil)
 return
 }
 var request = URLRequest(url: url)
 request.httpMethod = "GET"
 request.setValue("Basic \(loginAuth(username: username, password: password))", forHTTPHeaderField: "Authorization")

 //let config = URLSessionConfiguration.default
 //config.waitsForConnectivity = true

 let session = URLSession.shared

 let task = session.dataTask(with: request) { [weak self] (data, _, error) in
 guard let strongSelf = self else { return }
 guard let jsonData = data, error == nil else {
 DispatchQueue.main.async {
 strongSelf.fetchItemsCompletionBlock?(false, nil)
 }
 return
 }
 if strongSelf.parse(jsonData) {
 if let appointments = strongSelf.fetchFromStorage() {
 let newAppointments = AppointmentCoreDataManager.initViewModels(appointments)
 //strongSelf.items?.append(contentsOf: newAppointmentsPage)
 strongSelf.items = newAppointments
 }
 DispatchQueue.main.async {
 strongSelf.fetchItemsCompletionBlock?(true, nil)
 }
 } else {
 DispatchQueue.main.async {
 strongSelf.fetchItemsCompletionBlock?(false, NSError.createError(0, description: "JSON parsing error"))
 }
 }
 }
 task.resume()
 }
 }

 */

