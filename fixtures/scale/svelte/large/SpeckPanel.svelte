<script>
  import SpeckTrend from './SpeckTrend.svelte';
  import SpeckDetail from './SpeckDetail.svelte';
  import CipherBadge from './CipherBadge.svelte';

  export let rows = [];

  function summarizeSpeck(input) {
    return Array.isArray(input) ? input.length : 0;
  }
</script>

<div class="speck-panel">
  <SpeckTrend />
  <SpeckDetail />
  <CipherBadge />
  <p>{summarizeSpeck(rows)}</p>
</div>

<style>
  .speck-panel {
    display: flex;
    flex-direction: column;
    gap: 0.5rem;
  }
</style>
