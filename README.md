shinyStore
==========

The `shinyStore` package enables Shiny application developers to take advantage of HTML5 Local Storage to store persistent, synchronized data in the user's browser.

Installation
------------

You can install the latest development version of the code using the devtools R package.

```
# Install devtools, if you haven't already.
install.packages("devtools")

library(devtools)
install_github("trestletech/shinyStore")
```

Getting Started
---------------

#### 01-persist ([Live Demo](https://trestletech.shinyapps.io/ss-01-persist/))

```
library(shiny)
runApp(system.file("examples/01-persist", package="shinyStore"))
```

A simple example to demonstrate the usage of the `shinyStore` package.


#### 02-encrypted ([Live Demo](https://trestletech.shinyapps.io/ss-02-encrypted/))

```
library(shiny)
runApp(system.file("examples/02-encrypted", package="shinyStore"))
```

An example demonstrating the use of encrypted storage to secure the data you're 
writing to the user's browser. See the <a href ="#security">security section</a>
for more details.

Security
--------

Executive summary: 

> Unless using the encrypted storage option available when using Shiny Server Pro, you should assume that any data written into local storage will be accessible by other applications, and that any information read from local storage may have been modified by other applications. Thus, shinyStore is inappropriate for storing session IDs or other personal or confidential information that you don't want leaked or overwritten by others.

Because many Shiny applications share an "origin" with other applications, and because local storage lacks the "HTTP-Only" and "Secure" flags present in cookies, they are less secure and can't be considered as a replacement for Cookies. This makes local storage in Shiny more appropriate for user settings or other fields that aren't problematic if visible to other applications. 

Before writing data into shinyStore, ask yourself the question: "Would it be problematic if this data were leaked to other Shiny applications on this server?" And before reading data from Shiny store, consider that the data may have been modified by another actor since you wrote it.

For further reading on the security implications of "Web Storage", look at:

 - https://blog.whitehatsec.com/web-storage-security/
 - https://www.owasp.org/index.php/HTML5_Security_Cheat_Sheet#Local_Storage

### Encryption

shinyStore also has the capacity to encrypt and decrypt the values you're writing into storage, if you configure it with the public/private keys you want to use. See the `02-encrypted` example included in this package. The initial implementation is fairly limited, based on the `PKI` package which uses RSA encryption to encrypt very small payloads. From their documentation:

> Note that the payload should be very small since it must fit into the key size including padding. For example, 1024-bit key can only encrypt 87 bytes, while 2048-bit key can encrypt 215 bytes.

If we continue to assume that data in shinyStore is subject to information leakage, then  merely encrypting the data only protects us a little; the data can't be read as plain-text, but it could still be copied and presented to the application from another browser, presumably showing all the sensitive information you were trying to encrypt in the app. To protect against this, we want to bind the encryption to a strong, secure source of identity, such as what's available in Shiny Server Pro via the authentication feature. For this reason, we emit a warning if you try to use encryption outside of Shiny Server Pro or when there's not a logged-in user at the moment. If you're actually concerned about security, you should enable encryption in shinyStore and ensure that your application is configured to require authentication -- even if you're not restricting access to a subset of users. Merely enforcing that users must be logged in will allow shinyStore to associate the encrypted message with the given user to help mitigate information leakage.

We'll later consider alternative implementations that would be able to handle larger sizes. (Please do get in touch if you're aware of a good symmetric-key encryption package in R).

Known Bugs
-----------

shinyStore has been tested to be compatible with IE8 and greater, and recent versions of Chrome, Firefox, and Safari.

See the [Issues page](https://github.com/trestletech/shinyStore/issues) for information on outstanding issues. 

License
-------

The development of this project was generously sponsored by the [Institut de 
Radioprotection et de Sûreté Nucléaire](http://www.irsn.fr/EN/Pages/home.aspx) 
and performed by [Jeff Allen](http://trestletech.com). The code is
licensed under The MIT License (MIT).

Copyright (c) 2014 Institut de Radioprotection et de Sûreté Nucléaire

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in
all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
THE SOFTWARE.
