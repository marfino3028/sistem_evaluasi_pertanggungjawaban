<?php
return new Phalcon\Config([
    'db' => [
        'adapter' => 'Mysql',
        'host' => 'enforcer...',
        'username' => '',
        'password' => '',
        'dbname' => 'atgo',
        'charset' => 'utf8',
        'port' => '',
    ],
    'app_id' => 'atgo-api',
    'version' => '0.1',
    'printNewLine' => true,
    'debug' => true,
    'peran_id_publik' => 'publik',
    'username_publik' => 'publik',
]);
