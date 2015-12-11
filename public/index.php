<?php

/**
 * Display a basic hello world page
 */

?>

<!DOCTYPE html>
<html>
<head>
    <title>Welcome to Vertex</title>

    <link rel="stylesheet"
        href="//cdnjs.cloudflare.com/ajax/libs/foundation/5.4.5/css/foundation.min.css">
    <link href='http://fonts.googleapis.com/css?family=Ek+Mukta:400,800'
        rel='stylesheet' type='text/css'>
    <link rel="stylesheet" href="css/style.css">
</head>
<body>
    <div class="text-center pad-50-top">
        <div class="logo"></div>
        <h1>You have arrived</h1>
    </div>
    <div class="text-center">
        <?php echo HHVM_VERSION; ?>
    </div>
</body>
</html>
