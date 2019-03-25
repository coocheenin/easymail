# Package

version       = "0.1.0"
author        = "Konstantin Kuchinin"
description   = "wrapper for the sendmail command"
license       = "MIT"
srcDir        = "src"


# Dependencies

requires "nim >= 0.19.0"

task test, "Runs the EasyMail test...":
  exec "nim c -r tests/t"