<script>
  import KleinTrend from './KleinTrend.svelte';
  import KleinDetail from './KleinDetail.svelte';
  import CipherBadge from './CipherBadge.svelte';

  export let rows = [];

  function summarizeKlein(input) {
    return Array.isArray(input) ? input.length : 0;
  }
</script>

<div class="klein-panel">
  <KleinTrend />
  <KleinDetail />
  <CipherBadge />
  <p>{summarizeKlein(rows)}</p>
</div>

<style>
  .klein-panel {
    display: flex;
    flex-direction: column;
    gap: 0.5rem;
  }
</style>
