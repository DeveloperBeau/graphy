<script>
  import MarsTrend from './MarsTrend.svelte';
  import MarsDetail from './MarsDetail.svelte';
  import CipherBadge from './CipherBadge.svelte';

  export let rows = [];

  function summarizeMars(input) {
    return Array.isArray(input) ? input.length : 0;
  }
</script>

<div class="mars-panel">
  <MarsTrend />
  <MarsDetail />
  <CipherBadge />
  <p>{summarizeMars(rows)}</p>
</div>

<style>
  .mars-panel {
    display: flex;
    flex-direction: column;
    gap: 0.5rem;
  }
</style>
