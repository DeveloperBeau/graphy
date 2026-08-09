<?php

require_once __DIR__ . '/src/Autoload.php';

use CipherLab\Cli\ArgParser;
use CipherLab\Engine\Harness;
use CipherLab\Engine\ProgressReporter;
use CipherLab\Registry\FamilyCatalog;
use CipherLab\Report\SummaryReport;
use CipherLab\Report\SuiteReport;
use CipherLab\Store\ResultRecord;
use CipherLab\Store\SessionState;

$config = ArgParser::parse(array_slice($argv, 1));
$session = new SessionState();
$reporter = new ProgressReporter(count(FamilyCatalog::all()));
$outcomes = (new Harness())->runAll($reporter);

$records = array_map(
    fn ($d) => new ResultRecord($d->family(), $d->suite(), true),
    FamilyCatalog::all()
);
if ($config->persist) {
    $session->resultsStore()->persist($records);
}
echo (new SummaryReport())->build($outcomes, $session->previousSessions()) . "\n";
echo (new SuiteReport())->build($outcomes) . "\n";
