<?php

/**
 * Display a basic hello world page
 */

?>

<!DOCTYPE html>
<html>
<head>
    <title>Welcome to Vertex</title>

    <link rel="stylesheet" href="//cdnjs.cloudflare.com/ajax/libs/foundation/5.4.5/css/foundation.min.css">

    <style>
        .pad-50-top {
            padding-top: 50px;
        }
    </style>
</head>
<body>
    <div class="text-center pad-50-top">
        <img src="https://raw.githubusercontent.com/eduard44/vertex/master/logo.png">
        <p>Welcome to Vertex</p>
    </div>
    <div class="text-center">
        <?php phpinfo(); ?>
    </div>
</body>
</html>