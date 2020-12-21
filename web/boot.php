<?php
try {

    if (!file_exists(__DIR__ . '/../konfigurasi.php')) {
        echo "file konfigurasi belum ada";
        die;
    }

    date_default_timezone_set('Asia/Jakarta');

    if (PHP_OS == 'WINNT') {
        setlocale(LC_TIME, 'ID');
    } else {
        setlocale(LC_TIME, 'id_ID.utf8');
    }

    define('APP_TYPE', 'WEB');

    require __DIR__ . '/../vendor/autoload.php';
    require __DIR__ . '/../static.php';

    $loader = new Phalcon\Loader;
    $loader->registerDirs(array(
        '../kelas/',
        '../lib/',
        '../model/',
        '../web/controller/',
        '../web/listener/',
    ))->register();

    $di = new Phalcon\Di\FactoryDefault;

    $x = include '../konfigurasi.php';
    $di->setShared('config', $x);

    $router = new Phalcon\Mvc\Router();
    //$router->setDefaultController('index');
    $di->set('router', $router);

    //HARUSE INI GAK PERLU TAPI KOK GAK ISO DIMATIKAN
    $view = new Phalcon\Mvc\View;
    //$view->setViewsDir('../web/view/');
    //$view->setMainView('../../web/view/'.'index_layout_2_ltr_default_seed_sidebar_main');
    $di->set('view', $view);

    /*$url = new Phalcon\Url;
    $url->setBaseUri($x->baseurl);
    $di->set('url', $url);*/

    $dbparam = [
        'host' => $x->db->host,
        'username' => $x->db->username,
        'password' => $x->db->password,
        'dbname' => $x->db->dbname,
        'charset' => $x->db->charset,
        'port' => $x->db->port,
    ];
    $pdo = new Phalcon\Db\Adapter\Pdo\Mysql($dbparam);
    $di->setShared('db', $pdo);

    //WARNING, DONT USE SESSION FOR API//
    /*$di->setShared('session', function () use ($x) {
        if (@$x->unique_id) {
            $unique_id = $x->unique_id;
        } else {
            $unique_id = 'u467tyghj';
        }
        $session = new Phalcon\Session\Manager();
        $stream = new Phalcon\Session\Adapter\Stream([
            'savePath' => sys_get_temp_dir(),
            'uniqueId' => $unique_id,
        ]);
        $session->setAdapter($stream);
        $session->start();

        return $session;
    });*/

    $di->set('dispatcher', function () {
        $eventsManager = new Phalcon\Events\Manager;
        $eventsManager->attach('dispatch:beforeExecuteRoute', new ListenerKeamanan());
        $eventsManager->attach('dispatch:beforeException', new ListenerKerusakan());
        $dispatcher = new Phalcon\Mvc\Dispatcher;
        $dispatcher->setEventsManager($eventsManager);
        return $dispatcher;
    });

    $application = new Phalcon\Mvc\Application($di);
    $uri = $_GET['_url'] ?? '';
    $application->handle($uri)->send();

} catch (\Exception $e) {
    echo "Exception: ", $e->getMessage();
}