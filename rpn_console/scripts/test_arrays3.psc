@use(Array)

1 1 20 seq all toArray >tab

"Stage 1" println
"Array:  " print $tab println
"Length: " print $tab length println

$tab 1488 10 pushAt 
$tab 2137 12 pushAt

"Stage 2" println
"Array:  " print $tab println
"Length: " print $tab length println

$tab 14 getAt println
$tab 14 popAt println

"Stage 3" println
"Array:  " print $tab println
"Length: " print $tab length println