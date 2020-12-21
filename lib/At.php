<?php

use Phalcon\Mvc\Model\Query\Builder;
use Phalcon\Http\Request;

class At
{

    static function tokenGetInfo($token)
    {
        $b = new Builder();
        $b
            ->columns([
                'CrUser.user_id',
                'CrUser.username',
                'CrUser.user',
                'CrUser.peran_id',
            ])
            ->from("CrToken")
            ->join('CrUser', 'CrUser.user_id=CrToken.user_id')
            ->where('CrToken.token=:a:', ['a' => $token]);
        $rtoken = $b->getQuery()->getSingleResult();
        if ($rtoken) {
            return $rtoken;
        } else {
            return false;
        }
    }

    static function tokenRemoveAllbyUserId($user_id)
    {
        //non aktifkan semua token dia yang lain
        $sql = "
                update cr_token
                set token_aktif=0
                where
                user_id = '$user_id'
            ";
        $di = \Phalcon\DI::getDefault();
        $db = $di->get('db');
        $db->execute($sql);
    }

    static function hakIsAllowed($peran_id, $kontroler, $aksi)
    {

        $di = Phalcon\DI::getDefault();
        $app_id = $di->get('config')->app_id;

        $b = new Builder();
        $b
            /*->columns([
                'CrHak.xxx',
            ])*/
            ->from("CrHak")
            ->join('CrResource', 'CrResource.resource_id=CrHak.resource_id')
            ->where('CrHak.app_id=:a:',['a'=>$app_id])
            ->andWhere('CrHak.peran_id=:b:', ['b' => $peran_id])
            ->andWhere('CrHak.hak_aktif=1')
            ->andWhere('CrResource.app_id=CrHak.app_id')
            ->andWhere('CrResource.resource_aktif=1')
            ->andWhere('(CrResource.kontroler=\'all\' or CrResource.kontroler=:c:)',['c'=>$kontroler])
            ->andWhere('(CrResource.aksi=\'all\' or CrResource.aksi=:d:)',['d'=>$aksi])
        ;
        $r = $b->getQuery()->getSingleResult();

        if ($r) {
            return true;
        }

        return false;
    }

    static function logInsert($aktivitas, $i_user = null, $kat = null)
    {

        $di = Phalcon\DI::getDefault();
        $app_id = $di->get('config')->app_id;

        $la = new CrLogAkses();
        $la->app_id = $app_id;
        $la->aktivitas = $aktivitas;
        if ($i_user) {
            $la->i_user = $i_user;
        }
        if ($kat) {
            $la->kat = $kat;
        }
        $la->save();
    }

}