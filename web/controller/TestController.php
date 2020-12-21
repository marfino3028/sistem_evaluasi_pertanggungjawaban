<?php

use Phalcon\Http\Response;

class TestController extends AController
{
    public function indexAction()
    {

        At::logInsert("tereksekusi");

        $respon = new Respon();
        $respon->setPesan(0, "ini test request");
        $r = [
            'abc' => 'susu',
            'def' => 'botol',
        ];
        $respon->setData($r);
        $response = new Response();
        $response->setJsonContent($respon);
        return $response;

    }
}