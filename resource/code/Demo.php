<?php

/*
 * What php team is that is 'one thing, a team, work together'
 */

class Demo
{
    const CONFIGURATION = [
        'ini'     => '.ini',
        'json'    => '.json',
        'yaml'    => '.yaml',
    ];

    public function printer(array $configuration = self::CONFIGURATION): bool
    {
        print_r($configuration);

        return true;
    }
}
