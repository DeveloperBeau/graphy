<script>
  import SosemanukTrend from './SosemanukTrend.svelte';
  import SosemanukDetail from './SosemanukDetail.svelte';
  import CipherBadge from './CipherBadge.svelte';

  export let rows = [];

  function summarizeSosemanuk(input) {
    return Array.isArray(input) ? input.length : 0;
  }
</script>

<div class="sosemanuk-panel">
  <SosemanukTrend />
  <SosemanukDetail />
  <CipherBadge />
  <p>{summarizeSosemanuk(rows)}</p>
</div>

<style>
  .sosemanuk-panel {
    display: flex;
    flex-direction: column;
    gap: 0.5rem;
  }
</style>
