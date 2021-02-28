//
//  SearchView.swift
//  ITWORXTask
//
//  Created by Salwa Hegazy on 2/26/21.
//  Copyright © 2021 SalwaHegazy. All rights reserved.
//

import Foundation

protocol SearchView {
    func startLoading()
    func stopLoading()
    func navigateToEmpty()
}
