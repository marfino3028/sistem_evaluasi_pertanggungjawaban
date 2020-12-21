<?php

define('BASE_PATH', dirname(__DIR__));
define('APP_PATH', BASE_PATH . '/console');
define('APP_TYPE', 'CONSOLE');

if (!file_exists(BASE_PATH . '/konfigurasi.php')) {
    echo "file konfigurasi belum ada";
    die;
}

use Phalcon\Cli\Console as ConsoleApp;
use Phalcon\Di\FactoryDefault\Cli as CliDi;

date_default_timezone_set("Asia/Jakarta");

require BASE_PATH . '/vendor/autoload.php';
require BASE_PATH . '/static.php';

$di = new CliDi();

$di->setShared('config', function () {
    return include BASE_PATH . '/konfigurasi.php';
});

$di->setShared('db', function () {
    $config = $this->getConfig();
    $class = 'Phalcon\Db\Adapter\Pdo\\' . $config->db->adapter;
    $params = [
        'host' => $config->db->host,
        'username' => $config->db->username,
        'password' => $config->db->password,
        'dbname' => $config->db->dbname,
        'charset' => $config->db->charset,
        'port' => $config->db->port,
    ];
    if ($config->db->adapter == 'Postgresql') {
        unset($params['charset']);
    }
    $connection = new $class($params);
    return $connection;
});

$loader = new \Phalcon\Loader();
$loader->registerDirs([
    APP_PATH . '/task',
    BASE_PATH . '/model',
    BASE_PATH . '/lib',
]);
$loader->register();

$console = new ConsoleApp($di);

$arguments = [];

foreach ($argv as $k => $arg) {
    if ($k == 1) {
        $arguments['task'] = $arg;
    } elseif ($k == 2) {
        $arguments['action'] = $arg;
    } elseif ($k >= 3) {
        $arguments['params'][] = $arg;
    }
}

try {

    $console->handle($arguments);

    $config = $di->getConfig();
    if (isset($config["printNewLine"]) && $config["printNewLine"]) {
        echo PHP_EOL;
    }

} catch (Exception $e) {
    echo $e->getMessage() . PHP_EOL;
    echo $e->getTraceAsString() . PHP_EOL;
    exit(255);
}
