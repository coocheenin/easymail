# Copyright (C) 2019 Konstantin Kuchinin
# MIT License - Look at COPYING.md for details.

import unittest, easymail, strutils, re

suite "easymail check":

  test "OS Compatibility. Only Linux is supported now.":
    check system.hostOS == "linux"

  test "Emulate mode. Only generated headers and body are printed.":
    check mail("youremail@protonmail.com", "NIM Subject", "Hi, Here EasyMail test message!", extraHeaders, true)
#[
  test "Regex Originator's Email Validation (autogenerated)":
    check originator.match(re"\\b[a-zA-Z0-9!#$%&\'*+/=?^_`{|}~\\-]+(?:\\. &[a-zA-Z0-9!#$%&\'*+/=?^_`{|}~-]+)*@(?:[a-zA-Z0-9](?:[a-zA-Z0-9-]*[a-zA-Z0-9])?\\.)+(?:[a-zA-Z]{2}|com|org|net|gov|mil|biz|info|mobi|name|aero|jobs|museum)\\b")
]#