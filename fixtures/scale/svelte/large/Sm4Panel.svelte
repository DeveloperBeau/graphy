<script>
  import Sm4Trend from './Sm4Trend.svelte';
  import Sm4Detail from './Sm4Detail.svelte';
  import CipherBadge from './CipherBadge.svelte';

  export let rows = [];

  function summarizeSm4(input) {
    return Array.isArray(input) ? input.length : 0;
  }
</script>

<div class="sm4-panel">
  <Sm4Trend />
  <Sm4Detail />
  <CipherBadge />
  <p>{summarizeSm4(rows)}</p>
</div>

<style>
  .sm4-panel {
    display: flex;
    flex-direction: column;
    gap: 0.5rem;
  }
</style>
