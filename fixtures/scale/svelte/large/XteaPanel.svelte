<script>
  import XteaTrend from './XteaTrend.svelte';
  import XteaDetail from './XteaDetail.svelte';
  import CipherBadge from './CipherBadge.svelte';

  export let rows = [];

  function summarizeXtea(input) {
    return Array.isArray(input) ? input.length : 0;
  }
</script>

<div class="xtea-panel">
  <XteaTrend />
  <XteaDetail />
  <CipherBadge />
  <p>{summarizeXtea(rows)}</p>
</div>

<style>
  .xtea-panel {
    display: flex;
    flex-direction: column;
    gap: 0.5rem;
  }
</style>
