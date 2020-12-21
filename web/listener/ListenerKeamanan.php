<?php

class ListenerKeamanan extends Phalcon\Di\Injectable
{

    public function beforeExecuteRoute(Phalcon\Events\Event $event, Phalcon\Mvc\Dispatcher $dispatcher)
    {

        //controller action yang gak perlu token dan cek hak akses
        $kontroler = $dispatcher->getControllerName();
        $aksi = $dispatcher->getActionName();
        $skip_check = [
            'error-index',
            'index-index',
            'auth-index',
            //'test-index',
        ];
        if (in_array($kontroler . "-" . $aksi, $skip_check)) {
            return true;
        }

        $telo = $this->request->getJsonRawBody();

        //tolak kalo gak ngirim token
        if (!isset($telo->token)) {
            $this->dispatcher->forward([
                'controller' => 'error',
                'action' => 'index',
                'params' => [
                    'deskripsi' => 'token tidak dikirim'
                ]
            ]);
            return false;
        }
        $token = $telo->token;

        $rtoken = At::tokenGetInfo($token);
        if (!$rtoken) {
            $this->dispatcher->forward([
                'controller' => 'error',
                'action' => 'index',
                'params' => [
                    'deskripsi' => 'token invalid'
                ]
            ]);
            return false;
        }

        $peran_id = $rtoken->peran_id;
        if (!At::hakIsAllowed($peran_id, $kontroler, $aksi)) {

            $pesan = 'akses ke resource ini ditolak';

            //ini gak perlu log insert soale di controller error uwis dilog
            At::logInsert($pesan,null,'TOLAK');

            $this->dispatcher->forward(
                array(
                    'controller' => 'error',
                    'action' => 'index',
                    'params' => [
                        'deskripsi' => $pesan
                    ]
                )
            );
            return false;
        }

        //logging all action, gak perlu juga
        At::logInsert("username $rtoken->username token $rtoken->token group $rtoken->peran_id akses ke $kontroler - $aksi",null,"TERIMA");

    }


}