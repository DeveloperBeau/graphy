<script>
  import NoekeonTrend from './NoekeonTrend.svelte';
  import NoekeonDetail from './NoekeonDetail.svelte';
  import CipherBadge from './CipherBadge.svelte';

  export let rows = [];

  function summarizeNoekeon(input) {
    return Array.isArray(input) ? input.length : 0;
  }
</script>

<div class="noekeon-panel">
  <NoekeonTrend />
  <NoekeonDetail />
  <CipherBadge />
  <p>{summarizeNoekeon(rows)}</p>
</div>

<style>
  .noekeon-panel {
    display: flex;
    flex-direction: column;
    gap: 0.5rem;
  }
</style>
