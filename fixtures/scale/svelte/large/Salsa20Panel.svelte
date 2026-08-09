<script>
  import Salsa20Trend from './Salsa20Trend.svelte';
  import Salsa20Detail from './Salsa20Detail.svelte';
  import CipherBadge from './CipherBadge.svelte';

  export let rows = [];

  function summarizeSalsa20(input) {
    return Array.isArray(input) ? input.length : 0;
  }
</script>

<div class="salsa20-panel">
  <Salsa20Trend />
  <Salsa20Detail />
  <CipherBadge />
  <p>{summarizeSalsa20(rows)}</p>
</div>

<style>
  .salsa20-panel {
    display: flex;
    flex-direction: column;
    gap: 0.5rem;
  }
</style>
