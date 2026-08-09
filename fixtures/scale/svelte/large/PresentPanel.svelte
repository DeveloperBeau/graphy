<script>
  import PresentTrend from './PresentTrend.svelte';
  import PresentDetail from './PresentDetail.svelte';
  import CipherBadge from './CipherBadge.svelte';

  export let rows = [];

  function summarizePresent(input) {
    return Array.isArray(input) ? input.length : 0;
  }
</script>

<div class="present-panel">
  <PresentTrend />
  <PresentDetail />
  <CipherBadge />
  <p>{summarizePresent(rows)}</p>
</div>

<style>
  .present-panel {
    display: flex;
    flex-direction: column;
    gap: 0.5rem;
  }
</style>
