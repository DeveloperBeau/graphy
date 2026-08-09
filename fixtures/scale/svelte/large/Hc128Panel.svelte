<script>
  import Hc128Trend from './Hc128Trend.svelte';
  import Hc128Detail from './Hc128Detail.svelte';
  import CipherBadge from './CipherBadge.svelte';

  export let rows = [];

  function summarizeHc128(input) {
    return Array.isArray(input) ? input.length : 0;
  }
</script>

<div class="hc128-panel">
  <Hc128Trend />
  <Hc128Detail />
  <CipherBadge />
  <p>{summarizeHc128(rows)}</p>
</div>

<style>
  .hc128-panel {
    display: flex;
    flex-direction: column;
    gap: 0.5rem;
  }
</style>
