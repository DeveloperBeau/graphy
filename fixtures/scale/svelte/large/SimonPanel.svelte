<script>
  import SimonTrend from './SimonTrend.svelte';
  import SimonDetail from './SimonDetail.svelte';
  import CipherBadge from './CipherBadge.svelte';

  export let rows = [];

  function summarizeSimon(input) {
    return Array.isArray(input) ? input.length : 0;
  }
</script>

<div class="simon-panel">
  <SimonTrend />
  <SimonDetail />
  <CipherBadge />
  <p>{summarizeSimon(rows)}</p>
</div>

<style>
  .simon-panel {
    display: flex;
    flex-direction: column;
    gap: 0.5rem;
  }
</style>
