<script>
  import GostTrend from './GostTrend.svelte';
  import GostDetail from './GostDetail.svelte';
  import CipherBadge from './CipherBadge.svelte';

  export let rows = [];

  function summarizeGost(input) {
    return Array.isArray(input) ? input.length : 0;
  }
</script>

<div class="gost-panel">
  <GostTrend />
  <GostDetail />
  <CipherBadge />
  <p>{summarizeGost(rows)}</p>
</div>

<style>
  .gost-panel {
    display: flex;
    flex-direction: column;
    gap: 0.5rem;
  }
</style>
