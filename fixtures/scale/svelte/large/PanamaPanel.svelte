<script>
  import PanamaTrend from './PanamaTrend.svelte';
  import PanamaDetail from './PanamaDetail.svelte';
  import CipherBadge from './CipherBadge.svelte';

  export let rows = [];

  function summarizePanama(input) {
    return Array.isArray(input) ? input.length : 0;
  }
</script>

<div class="panama-panel">
  <PanamaTrend />
  <PanamaDetail />
  <CipherBadge />
  <p>{summarizePanama(rows)}</p>
</div>

<style>
  .panama-panel {
    display: flex;
    flex-direction: column;
    gap: 0.5rem;
  }
</style>
