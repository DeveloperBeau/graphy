<script>
  import XxteaTrend from './XxteaTrend.svelte';
  import XxteaDetail from './XxteaDetail.svelte';
  import CipherBadge from './CipherBadge.svelte';

  export let rows = [];

  function summarizeXxtea(input) {
    return Array.isArray(input) ? input.length : 0;
  }
</script>

<div class="xxtea-panel">
  <XxteaTrend />
  <XxteaDetail />
  <CipherBadge />
  <p>{summarizeXxtea(rows)}</p>
</div>

<style>
  .xxtea-panel {
    display: flex;
    flex-direction: column;
    gap: 0.5rem;
  }
</style>
