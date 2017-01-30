<?php

// Author: Arda Basoglu
// Email: arda@directiq.com

// In case you get "Fatal error: Class 'SoapClient' not found..." error
// go to your php.ini file and find the line that starts with ;extension=php_soap.dll
// and enable this line by removing ";" 
// Finally restart your web server

// http://api.directiq.com/v2.asmx?wsdl
$client = new SoapClient("http://api.directiq.com/v2.asmx?wsdl");
// Use your own api key here. This is just an example.
$apiKey = "d7a04479-3f0s-44ff-8aaf-2c626df1c4a1";

$params = array(
  "apiKey" => $apiKey,
  "email" => "email@domain.com",
  "firstname" => "Name",
  "lastname" =>  "Surname",
  "list_id" => "0121335"
);

// http://api.directiq.com/v2.asmx?op=AddContact
$response = $client->__soapCall("AddContact", array($params));

var_dump($response);

?>
