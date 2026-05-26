// feature: class, object, import styles, def, call edges
package com.example

import scala.collection.mutable.Map
import scala.collection.{List => CList}
import scala.math._

object ServiceFactory {
  def create(name: String): Service = new Service(name)
}

class Service(name: String) {
  def run(): String = {
    val greeting = Helpers.formatName(name)
    greeting
  }

  def describe(): String = s"Service($name)"
}

def topLevelHelper(): Int = 42
