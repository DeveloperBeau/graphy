<script>
  import SealTrend from './SealTrend.svelte';
  import SealDetail from './SealDetail.svelte';
  import CipherBadge from './CipherBadge.svelte';

  export let rows = [];

  function summarizeSeal(input) {
    return Array.isArray(input) ? input.length : 0;
  }
</script>

<div class="seal-panel">
  <SealTrend />
  <SealDetail />
  <CipherBadge />
  <p>{summarizeSeal(rows)}</p>
</div>

<style>
  .seal-panel {
    display: flex;
    flex-direction: column;
    gap: 0.5rem;
  }
</style>
