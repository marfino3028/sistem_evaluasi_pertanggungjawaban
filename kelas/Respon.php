<?php

class Respon
{

    //public $data;
    public $pesan;
    //public $debug;

    function setPesan($kode, $deskripsi)
    {
        $pesan = new Pesan();
        $pesan->kode = $kode;
        $pesan->deskripsi = $deskripsi;
        $this->pesan = $pesan;
    }

    function setDebug($debok) {
        $this->debug = $debok;
    }

    function setData($datax)
    {
        $this->data = $datax;
    }
}