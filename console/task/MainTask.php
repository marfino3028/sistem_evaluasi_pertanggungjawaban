<?php

use Phalcon\Mvc\Model\Query\Builder;

class MainTask extends \Phalcon\Cli\Task
{

    public function mainAction()
    {
        echo "gundam seed\n";

        $config = $this->getDI()->get('config');
        echo $config['version'] . "\n";

        $b = new Builder();
        $b
            ->from("CrApp")
            ->orderBy("app_id");
        $rs = $b->getQuery()->execute();
        foreach ($rs as $r) {
            echo "$r->app_id $r->app \n";
        }
    }

    public function testAction()
    {
        echo "lacus clyne\n";
    }

}
