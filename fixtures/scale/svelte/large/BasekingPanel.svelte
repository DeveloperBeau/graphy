<script>
  import BasekingTrend from './BasekingTrend.svelte';
  import BasekingDetail from './BasekingDetail.svelte';
  import CipherBadge from './CipherBadge.svelte';

  export let rows = [];

  function summarizeBaseking(input) {
    return Array.isArray(input) ? input.length : 0;
  }
</script>

<div class="baseking-panel">
  <BasekingTrend />
  <BasekingDetail />
  <CipherBadge />
  <p>{summarizeBaseking(rows)}</p>
</div>

<style>
  .baseking-panel {
    display: flex;
    flex-direction: column;
    gap: 0.5rem;
  }
</style>
