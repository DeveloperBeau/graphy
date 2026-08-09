<script>
  import Shacal2Trend from './Shacal2Trend.svelte';
  import Shacal2Detail from './Shacal2Detail.svelte';
  import CipherBadge from './CipherBadge.svelte';

  export let rows = [];

  function summarizeShacal2(input) {
    return Array.isArray(input) ? input.length : 0;
  }
</script>

<div class="shacal2-panel">
  <Shacal2Trend />
  <Shacal2Detail />
  <CipherBadge />
  <p>{summarizeShacal2(rows)}</p>
</div>

<style>
  .shacal2-panel {
    display: flex;
    flex-direction: column;
    gap: 0.5rem;
  }
</style>
