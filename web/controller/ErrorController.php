<?php

use Phalcon\Http\Response;

class ErrorController extends AController
{
    public function indexAction()
    {

        $params = $this->dispatcher->getParams();
        $respon = new Respon();
        if ($params) {
            if ($this->config->debug and isset($params['debug'])) {
                $respon->setPesan("1", $params['deskripsi']);
                $respon->setDebug($params['debug']);
            } else {
                $respon->setPesan("1", $params['deskripsi']);
            }

            At::logInsert($params['deskripsi'],null,"ERROR");

        } else {
            $respon->setPesan("0", "ok");
        }
        $response = new Response();
        $response->setJsonContent($respon);
        return $response;

    }

}