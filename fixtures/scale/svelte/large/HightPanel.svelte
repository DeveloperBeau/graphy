<script>
  import HightTrend from './HightTrend.svelte';
  import HightDetail from './HightDetail.svelte';
  import CipherBadge from './CipherBadge.svelte';

  export let rows = [];

  function summarizeHight(input) {
    return Array.isArray(input) ? input.length : 0;
  }
</script>

<div class="hight-panel">
  <HightTrend />
  <HightDetail />
  <CipherBadge />
  <p>{summarizeHight(rows)}</p>
</div>

<style>
  .hight-panel {
    display: flex;
    flex-direction: column;
    gap: 0.5rem;
  }
</style>
