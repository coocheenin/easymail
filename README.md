# EasyMail ![version badge](https://img.shields.io/badge/pre--release-v.0.1.0-green.svg)

EasyMail is a simple wrapper for the sendmail command. It's provides the easiest way for sending emails from your binaries in [Nim](https://nim-lang.org/).
## Installation
Install the package by running:
```
nimble install easymail
```
Feel free to [test the package](https://github.com/coocheenin/easymail#testing) before writing any code.
## Usage

**Note:** Only with Linux server distro compatible.

```nim
# mailme.nim
import easymail

discard mail("youremail@protonmail.com", "NIM Subject", "Hi, It's EasyMail test message!")
```
You are able to add extra headers:

```nim
# mailme.nim
import easymail

extraHeaders.add("Cc: me@mydomain.com")
extraHeaders.add("X-Mailer: EasyMail v0.1.0")

if mail("youremail@protonmail.com", "NIM Subject", "Hi, It's EasyMail test message!", extraHeaders):
  echo "The command completed successfully!"
```
Here is a fifth parameter `emulate`, passing with `true` value will print all generated headers and body **without sending** attempt:

```nim
# mailme.nim
import easymail

discard mail("youremail@protonmail.com", "NIM Subject", "Hi, It's EasyMail test message!", extraHeaders, true)
```
## Testing

Test the package with:

```
  nimble test
```