<script>
  import Mickey2Trend from './Mickey2Trend.svelte';
  import Mickey2Detail from './Mickey2Detail.svelte';
  import CipherBadge from './CipherBadge.svelte';

  export let rows = [];

  function summarizeMickey2(input) {
    return Array.isArray(input) ? input.length : 0;
  }
</script>

<div class="mickey2-panel">
  <Mickey2Trend />
  <Mickey2Detail />
  <CipherBadge />
  <p>{summarizeMickey2(rows)}</p>
</div>

<style>
  .mickey2-panel {
    display: flex;
    flex-direction: column;
    gap: 0.5rem;
  }
</style>
