# Copyright (C) 2019 Konstantin Kuchinin
# MIT License - Look at COPYING.md for details.
#
# EasyMail is a simple wrapper for the sendmail command. The mechanism is very similar to what the mail() function in PHP does:
# It's puts the generated RFC822 message to the standard input of the sendmail command.
#
# Usage:
# ```
# import easymail
#
# discard mail("youremail@protonmail.com", "NIM Subject", "Hi, It's EasyMail test message!")
# ```
# That's All! Compile and run on your Linux distro.
# The full proc definition please see at https://github.com/coocheenin/easymail

import osproc
import times
import re
import strutils
import sequtils

const
  originator* = "From: no-reply@" & staticExec("hostname")

var
  extraHeaders* = newSeq[string]()


proc mail*(to: string, subject: string, message: string, ext: seq[string] = @[originator], emulate: bool = false): bool =
  ## Generates headers and puts the generated RFC822 message to the standard input of the sendmail command.
  ##
  ## `to` Recipient of the email: just email without brackets or display name with email enlosed in "<" and ">" 
  ## `subject` The short string identifying the topic of the message. Must contain only US-ASCII characters.
  ## TODO: Adding utf-8 support for a subject field body in the near future
  ## `message` Multiline string (CRLF splitted), the body of the message itself.
  ## `ext` Sequence of extra headers. This is optional parameter. The default value contains auto-generated "From" header field
  ## `emulate` Passing "true" value turns "emulate mode". Only generated headers and body will be printed. Also is an optional parameter.
  result = emulate
  let crlf = "\r\n"
  let now = format(now(), "ddd, d MMM yyyy HH:mm:ss zzz").replacef(re"(\+[0-9]{2}):([0-9]{2})", "$1$2")
  var f = filterIt(ext, find(it, "From:") >= 0)
  if len(f) < 1:
    f = @[originator]
  var options = ""
  for h in ext:
    if find(h, "From:") == -1 : options &= h & crlf
  let email = f[0] & crlf & "To: " & to & crlf & "Subject: " & subject & crlf & options & "Date: " & now & crlf & crlf & message
  if (emulate == true and email.startsWith("From:")) :
    echo email
    result = true
  else :
    let process = startProcess("echo -e \"" & email & "\" | /usr/sbin/sendmail -t", options = {poUsePath, poEvalCommand, poParentStreams})
    let exit = process.waitForExit()
    if exit == 0: result = true