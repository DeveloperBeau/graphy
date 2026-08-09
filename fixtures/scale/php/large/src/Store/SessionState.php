<?php

namespace CipherLab\Store;

class SessionState
{
    private ResultsStore $store;

    public function __construct()
    {
        $this->store = new ResultsStore();
    }

    public function previousSessions(): int
    {
        $runs = $this->store->priorRuns();
        $families = array_unique(array_map(fn (ResultRecord $r) => $r->family, $runs));
        return count($families) === 0 ? 0 : intdiv(count($runs), count($families));
    }

    public function resultsStore(): ResultsStore
    {
        return $this->store;
    }
}
