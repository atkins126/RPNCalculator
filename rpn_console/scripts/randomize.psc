@silent
10 times { 20 rand } 
all toArray >tab

"RANDOMIZE" println
"Before" println
"Array:  " print $tab println
"Length: " print $tab length println

0 >i
$tab length times {
	$tab $i 50 rand 25 - setAt
	$i ++ >i
}

"After" println
"Array:  " print $tab println
"Length: " print $tab length println