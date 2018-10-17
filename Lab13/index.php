<?php
    session_start();
    
    require_once("util.php");
    
    if (isset($_POST["email"])) {
        $_POST["usuario"] = limpia_variable($_POST["usuario"]);
    }
    
    if (isset($_POST["password"])) {
        $_POST["password"] = limpia_variable($_POST["password"]);
    }
    
    if (isset($_SESSION['email'])) {
        
        include ("../partials/_header.html");
        include("Lab13_A01209924.html");
    }else if ($_POST["email"] == "marco.ag1996@gmail.com" && $_POST["password"] == "123") {
        $_SESSION["email"] = $_POST["email"];
        include ("../partials/_header.html");
        include("Lab13_A01209924.html");
    } else if ($_POST["email"] == "" && $_POST["password"] == "" 
                && isset($_POST["email"])  && isset($_POST["password"]) ) {
        $error = "Ingresa tu usuario y contraseña";
        include ("../partials/_header.html");
        include("_login.html");
    } else if(isset($_POST["email"]) || isset($_POST["password"]) ) {
        sleep(3);
        $error = "Usuario y/o password incorrectos";
        include ("../partials/_header.html");
        include("_login.html");
    } else {
        include ("../partials/_header.html");
        include("_login.html");
    }
    
    include ("../partials/_footer.html");
?>