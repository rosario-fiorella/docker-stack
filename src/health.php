<?php

try {
    $redis = new Redis();
    $redis->connect('redis', 6379);
    $redis->ping();

    showHealth('Redis', 'ok');
} catch (RedisException $e) {
    showHealth('Redis', $e->getMessage());
}

try {
    $pdo = new PDO('mysql:host=db;dbname=', 'user', 'password');
    $pdo->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);

    showHealth('PDO', 'ok');
} catch (PDOException $e) {
    showHealth('PDO', $e->getMessage());
}

try {
    $options = [
        'hostname' => 'solr',
        'port' => 8983,
        'path' => 'solr/collection',
        'wt' => 'xml'
    ];

    $solr_client = new SolrClient($options);
    $solr_client->ping();

    showHealth('SolrClient', 'ok');
} catch (SolrException $e) {
    showHealth('SolrClient', $e->getMessage());
}

/**
 * @param string $service
 * @param string $status
 * 
 * @return void
 */
function showHealth(string $service, string $status): void
{
    $isCLI = php_sapi_name() === 'cli';

    if (!$isCLI) {
        echo sprintf("<p><strong>%s</strong>: %s</p>", $service, $status);
        return;
    }

    $message = sprintf("%s: %s", $service, $status);
    $hr = str_repeat('-', strlen($message));

    echo $hr, PHP_EOL;
    echo $message, PHP_EOL;
    echo $hr, PHP_EOL;
    return;
}