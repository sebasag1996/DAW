<?php
    echo $_POST["email"];
    function check() {
        if(isSet($_POST['email'] == '12345') && $_POST['password'] == '12345') { 
            echo "correctas";   
        } else { 
            echo "Email i/o Password incorrectas ;) intentalo de nuevo";
        }
        
    }
    include ("../partials/_header.html");
    require_once("util.php");
    include("_login.html");
    include ("../Lab11/Lab11_A01209924.html");
    include ("../partials/_footer.html");
?>