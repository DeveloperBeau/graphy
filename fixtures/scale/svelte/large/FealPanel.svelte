<script>
  import FealTrend from './FealTrend.svelte';
  import FealDetail from './FealDetail.svelte';
  import CipherBadge from './CipherBadge.svelte';

  export let rows = [];

  function summarizeFeal(input) {
    return Array.isArray(input) ? input.length : 0;
  }
</script>

<div class="feal-panel">
  <FealTrend />
  <FealDetail />
  <CipherBadge />
  <p>{summarizeFeal(rows)}</p>
</div>

<style>
  .feal-panel {
    display: flex;
    flex-direction: column;
    gap: 0.5rem;
  }
</style>
