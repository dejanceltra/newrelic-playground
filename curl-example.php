<?php
// Convert all errors to exceptions, to avoid any incorrect operation.
ini_set('display_errors', 1);
ini_set('display_startup_errors', 1);
error_reporting(E_ALL);

function req($url) {
    $curl = curl_init($url);

    curl_setopt($curl, CURLOPT_HEADER, true);
    curl_setopt($curl, CURLOPT_RETURNTRANSFER, true);
    curl_setopt($curl, CURLOPT_FOLLOWLOCATION, true);

    return $curl;
}


$multi = curl_multi_init();

curl_multi_add_handle($multi, req('https://google.com'));
curl_multi_add_handle($multi, req('https://bing.com'));

$active = null;
do {
    curl_multi_exec($multi, $active);
} while ($active);
