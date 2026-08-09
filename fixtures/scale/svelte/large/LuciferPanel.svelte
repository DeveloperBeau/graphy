<script>
  import LuciferTrend from './LuciferTrend.svelte';
  import LuciferDetail from './LuciferDetail.svelte';
  import CipherBadge from './CipherBadge.svelte';

  export let rows = [];

  function summarizeLucifer(input) {
    return Array.isArray(input) ? input.length : 0;
  }
</script>

<div class="lucifer-panel">
  <LuciferTrend />
  <LuciferDetail />
  <CipherBadge />
  <p>{summarizeLucifer(rows)}</p>
</div>

<style>
  .lucifer-panel {
    display: flex;
    flex-direction: column;
    gap: 0.5rem;
  }
</style>
