<script>
  import Hc256Trend from './Hc256Trend.svelte';
  import Hc256Detail from './Hc256Detail.svelte';
  import CipherBadge from './CipherBadge.svelte';

  export let rows = [];

  function summarizeHc256(input) {
    return Array.isArray(input) ? input.length : 0;
  }
</script>

<div class="hc256-panel">
  <Hc256Trend />
  <Hc256Detail />
  <CipherBadge />
  <p>{summarizeHc256(rows)}</p>
</div>

<style>
  .hc256-panel {
    display: flex;
    flex-direction: column;
    gap: 0.5rem;
  }
</style>
