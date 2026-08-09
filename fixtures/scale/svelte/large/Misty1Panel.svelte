<script>
  import Misty1Trend from './Misty1Trend.svelte';
  import Misty1Detail from './Misty1Detail.svelte';
  import CipherBadge from './CipherBadge.svelte';

  export let rows = [];

  function summarizeMisty1(input) {
    return Array.isArray(input) ? input.length : 0;
  }
</script>

<div class="misty1-panel">
  <Misty1Trend />
  <Misty1Detail />
  <CipherBadge />
  <p>{summarizeMisty1(rows)}</p>
</div>

<style>
  .misty1-panel {
    display: flex;
    flex-direction: column;
    gap: 0.5rem;
  }
</style>
