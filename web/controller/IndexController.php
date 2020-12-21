<?php

use Phalcon\Http\Response;

class IndexController extends AController
{
    public function indexAction()
    {
        $x = 'ATGO API';
        $response = new Response();
        $response->setJsonContent($x);
        return $response;
    }
}