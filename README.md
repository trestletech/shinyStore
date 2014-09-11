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

Security
--------

TODO

Information leakage, manipulation of stored data.

For further reading on the security implications of "Web Storage", look at:

 - https://blog.whitehatsec.com/web-storage-security/
 - https://www.owasp.org/index.php/HTML5_Security_Cheat_Sheet#Local_Storage

Getting Started
---------------

#### 01-persist ([Live Demo](https://trestletech.shinyapps.io/ss-01-psersist/))

```
library(shiny)
runApp(system.file("examples/01-persist", package="shinyStore"))
```

A simple example to demonstrate the usage of the `shinyStore` package.


#### 02-encrypted ([Live Demo](https://trestletech.shinyapps.io/ss-01-encrypted/))

```
library(shiny)
runApp(system.file("examples/01-encrypted", package="shinyStore"))
```

An example demonstrating the use of encrypted storage to secure the data you're 
writing to the user's browser. See the <a href ="#security">security section</a>
for more details.

Known Bugs
-----------

shinyStore has been tested to be compatible with IE8 and greater, and recent versions of Chrome, Firefox, and Safari.

See the [Issues page](https://github.com/trestletech/shinyTree/issues) for information on outstanding issues. 

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
