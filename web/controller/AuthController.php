<?php

use Phalcon\Mvc\Model\Query\Builder;
use Phalcon\Http\Response;

class AuthController extends AController
{

    public function logoutAction()
    {

        $telo = $this->request->getJsonRawBody();
        $ruser = At::tokenGetInfo($telo->token);
        if ($ruser) {

            At::tokenRemoveAllbyUserId($ruser->user_id);

            At::logInsert("LOGOUT BERHASIL", $ruser->username,"TERIMA");

            $respon = new Respon();
            $respon->setPesan(0, "User $ruser->username berhasil logout");
            $response = new Response();
            $response->setJsonContent($respon);
            return $response;

        }

    }

    public function cekAction() {

        //input
        $telo = $this->request->getJsonRawBody();
        $token = $telo->token;

        //ambil info2 user kasihkan ke api
        $userinfo = At::tokenGetInfo($token);

        $respon = new Respon();
        $respon->setPesan(0, "info user $userinfo->username");
        $r = [
            'token' => $token,
            'username' => $userinfo->username,
            'user' => $userinfo->user,
        ];
        $respon->setData($r);
        $response = new Response();
        $response->setJsonContent($respon);
        return $response;

    }

    public function indexAction()
    {

        //At::logInsert("calling auth index");

        $telo = $this->request->getJsonRawBody();

        //tolak kalo gak ngirim
        if (!isset($telo->username) and !(isset($telo->password))) {
            $this->dispatcher->forward([
                'controller' => 'error',
                'action' => 'index',
                'params' => [
                    'deskripsi' => 'username dan password tidak dikirim'
                ]
            ]);
            return false;
        }

        //blokir kalo ada karakter aneh di user
        $cucian = $this->filter->sanitize($telo->username, 'alnum');
        if ($cucian != $telo->username) {
            $this->dispatcher->forward([
                'controller' => 'error',
                'action' => 'index',
                'params' => [
                    'deskripsi' => 'karakter ilegal di username'
                ]
            ]);
            return false;
        }

        $username = $telo->username;
        $password = $telo->password;

        $b = new Builder();
        $b
            ->columns([
                'user_id',
                'username',
                'peran_id',
            ])
            ->from("CrUser")
            ->where('username=:a:', ['a' => $username])
            ->andWhere('kunci=md5(:y:)', ['y' => $password])
            ->andWhere('user_aktif=1')
        ;
        $user = $b->getQuery()->getSingleResult();

        if ($user) {

            //non aktifkan semua token dia yang lain
            At::tokenRemoveAllbyUserId($user->user_id);

            //generate token
            $random = new Phalcon\Security\Random();
            $token = $random->uuid();

            //simpan token
            $rn = new CrToken();
            $rn->token = $token;
            $rn->app_id = $this->config->app_id;
            $rn->user_id = $user->user_id;
            $rn->token_aktif = 1;
            if (!$rn->save()) {
                $this->dispatcher->forward([
                    'controller' => 'error',
                    'action' => 'index',
                    'params' => [
                        'deskripsi' => 'gagal save token',
                        'debug' => atMsgtoString($rn->getMessages())
                    ]
                ]);
            }

            //logging login berhasil
            At::logInsert("LOGIN BERHASIL", $username,"TERIMA");

            //ambil info2 user kasihkan ke api
            $userinfo = At::tokenGetInfo($token);

            //respon json
            $respon = new Respon();
            $respon->setPesan(0, "User $username berhasil login");
            $r = [
                'token' => $token,
                'username' => $userinfo->username,
                'user' => $userinfo->user,
            ];
            $respon->setData($r);
            $response = new Response();
            $response->setJsonContent($respon);
            return $response;

        }

        //loggin login gagal
        At::logInsert("LOGIN GAGAL", $username,"TOLAK");

        $this->dispatcher->forward([
            'controller' => 'error',
            'action' => 'index',
            'params' => [
                'deskripsi' => 'username dan password salah'
            ]
        ]);
        return false;


    }
}