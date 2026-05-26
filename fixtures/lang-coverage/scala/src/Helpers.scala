// feature: object singleton, top-level def, import wildcard
package com.example

import scala.collection._

object Helpers {
  def formatName(name: String): String = s"hi, $name"

  def unrelatedHelper(): Int = 7
}
