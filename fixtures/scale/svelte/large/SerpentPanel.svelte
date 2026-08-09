<script>
  import SerpentTrend from './SerpentTrend.svelte';
  import SerpentDetail from './SerpentDetail.svelte';
  import CipherBadge from './CipherBadge.svelte';

  export let rows = [];

  function summarizeSerpent(input) {
    return Array.isArray(input) ? input.length : 0;
  }
</script>

<div class="serpent-panel">
  <SerpentTrend />
  <SerpentDetail />
  <CipherBadge />
  <p>{summarizeSerpent(rows)}</p>
</div>

<style>
  .serpent-panel {
    display: flex;
    flex-direction: column;
    gap: 0.5rem;
  }
</style>
