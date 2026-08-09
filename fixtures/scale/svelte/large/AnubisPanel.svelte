<script>
  import AnubisTrend from './AnubisTrend.svelte';
  import AnubisDetail from './AnubisDetail.svelte';
  import CipherBadge from './CipherBadge.svelte';

  export let rows = [];

  function summarizeAnubis(input) {
    return Array.isArray(input) ? input.length : 0;
  }
</script>

<div class="anubis-panel">
  <AnubisTrend />
  <AnubisDetail />
  <CipherBadge />
  <p>{summarizeAnubis(rows)}</p>
</div>

<style>
  .anubis-panel {
    display: flex;
    flex-direction: column;
    gap: 0.5rem;
  }
</style>
