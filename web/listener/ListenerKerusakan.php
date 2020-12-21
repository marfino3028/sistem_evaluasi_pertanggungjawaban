<?php

class ListenerKerusakan extends Phalcon\Di\Injectable
{
    public function beforeException(Phalcon\Events\Event $event, Phalcon\Mvc\Dispatcher $dispatcher, Exception $ex)
    {

        $error =
            $ex->getMessage() . PHP_EOL .
            $ex->getTraceAsString() . PHP_EOL .
            implode($this->request->getQuery());

        //log php
        error_log($error);

        //log ke database
        $log = new CrLogError();
        $log->app_id = $this->config->app_id;
        $log->pesan = $ex->getMessage();
        $log->trace = $ex->getTraceAsString();
        $log->query = implode($this->request->getQuery());
        $log->user_agent = $_SERVER['HTTP_USER_AGENT'];
        $log->save();
        $log_error_id = $log->log_error_id;

        //tampilin id error
        $this->flash->error("Kode : $log_error_id");

        switch ($ex->getCode()) {
            case Phalcon\Dispatcher\Exception::EXCEPTION_HANDLER_NOT_FOUND:
                $telo = "Mohon maaf (handler) halaman yang anda buka tidak ada atau telah diapus";
                break;
            case Phalcon\Dispatcher\Exception::EXCEPTION_ACTION_NOT_FOUND:
                $telo = "Mohon maaf (action) halaman yang anda buka tidak ada atau telah dihapus";
                break;
            default:
                $telo = "Mohon maaf telah terjadi kesalahan";
                break;
        }

        //larikan ke kontroller error
        $dispatcher->forward(array(
            'controller' => 'error',
            'action' => 'index',
            'params' => [
                'deskripsi' => $telo,
                'debug' => [
                    'err_message' => $ex->getMessage(),
                    'err_trace' => $ex->getTraceAsString(),
                    'query' => $this->request->getQuery()
                ]
            ]
        ));
        return false;

    }
}