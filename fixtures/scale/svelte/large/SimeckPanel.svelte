<script>
  import SimeckTrend from './SimeckTrend.svelte';
  import SimeckDetail from './SimeckDetail.svelte';
  import CipherBadge from './CipherBadge.svelte';

  export let rows = [];

  function summarizeSimeck(input) {
    return Array.isArray(input) ? input.length : 0;
  }
</script>

<div class="simeck-panel">
  <SimeckTrend />
  <SimeckDetail />
  <CipherBadge />
  <p>{summarizeSimeck(rows)}</p>
</div>

<style>
  .simeck-panel {
    display: flex;
    flex-direction: column;
    gap: 0.5rem;
  }
</style>
