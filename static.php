<?php

/*
 * fungsi fungsi statis yang tidak ada koneksi database masukkan sini
 * jangan ada sesi dan lain-lain, buat sedinamic mungkin
 */
function atSubstrwords($text, $maxchar, $end = '...')
{
    if (strlen($text) > $maxchar || $text == '') {
        $words = preg_split('/\s/', $text);
        $output = '';
        $i = 0;
        while (1) {
            $length = strlen($output) + strlen($words[$i]);
            if ($length > $maxchar) {
                break;
            } else {
                $output .= " " . $words[$i];
                ++$i;
            }
        }
        $output .= $end;
    } else {
        $output = $text;
    }
    return $output;
}

function atMsgtoString($msgs)
{
    $telo = '';
    foreach ($msgs as $message) {
        $telo = $telo . " $message";
    }
    return $telo;
}