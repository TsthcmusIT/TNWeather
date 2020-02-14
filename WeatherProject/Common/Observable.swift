//
//  Observable.swift
//  WeatherProject
//
//  Created by Thanh Nguyen on 2/11/20.
//  Copyright © 2020 Thanh Nguyen. All rights reserved.
//

import Foundation


class Observable<T> {
  typealias Observer = (T) -> Void
  var observer: Observer?

  func observe(_ observer: Observer?) {
    self.observer = observer
    observer?(value)
  }

  var value: T {
    didSet {
      observer?(value)
    }
  }

  init(_ value: T) {
    self.value = value
  }
}
