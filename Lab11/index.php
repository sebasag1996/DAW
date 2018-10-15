<?php
    include ("../partials/_header.html");
    require_once("util.php");
    if (isset($_POST["email"])) {
        $_POST["usuario"] = limpia_variable($_POST["usuario"]);
    }
    
    if (isset($_POST["password"])) {
        $_POST["password"] = limpia_variable($_POST["password"]);
    }
 
    if ($_POST["email"] == "marco.ag1996@gmail.com" && $_POST["password"] == "123") {
        $error = "Ingresa tu usuario y contraseña";
        include("Lab11_A01209924.html");
    } else if ($_POST["email"] == "" && $_POST["password"] == "" 
                && isset($_POST["email"])  && isset($_POST["password"]) ) {
        $error = "Ingresa tu usuario y contraseña";
        include("_login.html");
    } else if(isset($_POST["email"]) || isset($_POST["password"]) ) {
        sleep(3);
        $error = "Usuario y/o password incorrectos";
        include("_login.html");
    } else {
        include("_login.html");
    }

    include ("../Lab11/Lab11_A01209924.html");
    include ("../partials/_footer.html");
?>