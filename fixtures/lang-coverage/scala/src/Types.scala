// feature: trait, case class, class
package com.example

import scala.collection.mutable

trait Greet {
  def hi: String
}

case class State(name: String, active: Boolean)

class BaseService {
  val maxRetries: Int = 3
}
