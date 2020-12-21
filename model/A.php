<?php

use Phalcon\Mvc\Model;
use Phalcon\Http\Request;

class A extends Model
{

    private function getUsername() {
        //set user id
        if (APP_TYPE == 'WEB') {
            $request = new Request();
            $telo = $request->getJsonRawBody();
            if (isset($telo->token)) {
                $rtoken = At::tokenGetInfo($telo->token);
            }
            if (isset($rtoken)) {
                $username = $rtoken->username;
            } else {
                $username = $this->getDI()->get('config')->username_publik;
            }
        } else {
            $username = 'console';
        }
        return $username;
    }

    function beforeValidationOnCreate()
    {

        //set primary key
        $primary_keys = $this->getModelsMetaData()->getPrimaryKeyAttributes($this);
        $pk = $primary_keys[0];
        if (!@$this->$pk) {
            $random = new Phalcon\Security\Random();
            $this->$pk = $random->uuid();
        }

        //set username
        $username = $this->getUsername();
        if (isset($this->i_user)) {
            $this->u_user = $this->I_USER;
        } else {
            $this->i_user = $username;
            $this->u_user = $username;
        }

        //set ip
        $request = new \Phalcon\Http\Request();
        $ip = $request->getClientAddress();
        $this->i_ip = $ip;
        $this->u_ip = $ip;

        //set time
        $time = date("Y-m-d H:i:s");
        $this->i_datetime = $time;
        $this->u_datetime = $time;

    }

    function beforeValidationOnUpdate()
    {

        //set username
        $username = $this->getUsername();
        $this->u_user = $username;

        //set ip
        $request = new \Phalcon\Http\Request();
        $this->u_ip = $request->getClientAddress();

        //set time
        $this->u_datetime = date("Y-m-d H:i:s");
    }
}