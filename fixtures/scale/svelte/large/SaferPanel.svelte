<script>
  import SaferTrend from './SaferTrend.svelte';
  import SaferDetail from './SaferDetail.svelte';
  import CipherBadge from './CipherBadge.svelte';

  export let rows = [];

  function summarizeSafer(input) {
    return Array.isArray(input) ? input.length : 0;
  }
</script>

<div class="safer-panel">
  <SaferTrend />
  <SaferDetail />
  <CipherBadge />
  <p>{summarizeSafer(rows)}</p>
</div>

<style>
  .safer-panel {
    display: flex;
    flex-direction: column;
    gap: 0.5rem;
  }
</style>
