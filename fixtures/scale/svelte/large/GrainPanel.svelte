<script>
  import GrainTrend from './GrainTrend.svelte';
  import GrainDetail from './GrainDetail.svelte';
  import CipherBadge from './CipherBadge.svelte';

  export let rows = [];

  function summarizeGrain(input) {
    return Array.isArray(input) ? input.length : 0;
  }
</script>

<div class="grain-panel">
  <GrainTrend />
  <GrainDetail />
  <CipherBadge />
  <p>{summarizeGrain(rows)}</p>
</div>

<style>
  .grain-panel {
    display: flex;
    flex-direction: column;
    gap: 0.5rem;
  }
</style>
