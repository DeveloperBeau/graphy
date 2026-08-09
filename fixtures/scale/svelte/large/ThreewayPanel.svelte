<script>
  import ThreewayTrend from './ThreewayTrend.svelte';
  import ThreewayDetail from './ThreewayDetail.svelte';
  import CipherBadge from './CipherBadge.svelte';

  export let rows = [];

  function summarizeThreeway(input) {
    return Array.isArray(input) ? input.length : 0;
  }
</script>

<div class="threeway-panel">
  <ThreewayTrend />
  <ThreewayDetail />
  <CipherBadge />
  <p>{summarizeThreeway(rows)}</p>
</div>

<style>
  .threeway-panel {
    display: flex;
    flex-direction: column;
    gap: 0.5rem;
  }
</style>
