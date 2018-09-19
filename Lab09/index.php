<?php
    $test1 = array(90, 80, 100, 75, 100);
    $test2 = array(100, 100, 100, 90, 90);
    
    function print_array($array)
    {
        echo $array[0];
        for ($i = 1; $i < sizeof($array); $i++)
        {
            echo ", $array[$i]";
        }
    }

    function average ($array) {
        $average = 0;
        for ($i = 0; $i < sizeof($array); $i++){
            $average = $average + $array[$i];
        }
        echo "el promedio es: $average";
    }

    function mediana($array) {
        sort($array);
        if (sizeof($array) % 2 == 0) {
            return ($array[sizeof($array)/2-1] + $array[sizeof($array)/2])/2;
        } else {
            return $array[(sizeof($array)-1)/2];
        }
    }
    $num = 9;
    $title = "LAB - $num";
    include("../partials/_header.html");
    include("Lab09_A01209924.html");
    include("../partials/_footer.html");
?>