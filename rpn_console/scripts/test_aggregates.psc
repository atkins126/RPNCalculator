@silent
"INPUT:    " print @source("data.rpn") statusln clear
"SORTED:   " print @source("data.rpn") sort statusln clear

"Sum:      " print @source("data.rpn") all sum      println clear
"Product:  " print @source("data.rpn") all product  println clear
"Avg:      " print @source("data.rpn") all avg      println clear
"Min:      " print @source("data.rpn") all min      println clear
"Max:      " print @source("data.rpn") all max      println clear
"Count:    " print @source("data.rpn")     count    println clear
"Median:   " print @source("data.rpn") all median   println clear
"Variance: " print @source("data.rpn") all variance println clear
"Stddev:   " print @source("data.rpn") all stddev   println clear
