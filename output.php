<?php
$name = array("5.js","17.js","28.js","39.js","74.js","80.js","9.js");
$dir = "http://serveradress.net/";
$text = array("Name","Status","System","Release","Architektur","Temperatur","Laufzeit");
for($k=0;$k < count($name); $k++){
    $data = file($dir . $name[$k]);
    echo substr($data[0], 0, -1);
    echo " ist ";
    echo $data[1];
    echo "<br />";
    for($i=2;$i < count($data); $i++){
        echo $text[$i];
        echo ": ";
        echo $data[$i];
        echo "<br />";
    }
    echo "<hr>";
}
?>
