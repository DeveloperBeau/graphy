<script>
  import SeedTrend from './SeedTrend.svelte';
  import SeedDetail from './SeedDetail.svelte';
  import CipherBadge from './CipherBadge.svelte';

  export let rows = [];

  function summarizeSeed(input) {
    return Array.isArray(input) ? input.length : 0;
  }
</script>

<div class="seed-panel">
  <SeedTrend />
  <SeedDetail />
  <CipherBadge />
  <p>{summarizeSeed(rows)}</p>
</div>

<style>
  .seed-panel {
    display: flex;
    flex-direction: column;
    gap: 0.5rem;
  }
</style>
