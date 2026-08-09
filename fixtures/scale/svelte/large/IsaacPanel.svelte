<script>
  import IsaacTrend from './IsaacTrend.svelte';
  import IsaacDetail from './IsaacDetail.svelte';
  import CipherBadge from './CipherBadge.svelte';

  export let rows = [];

  function summarizeIsaac(input) {
    return Array.isArray(input) ? input.length : 0;
  }
</script>

<div class="isaac-panel">
  <IsaacTrend />
  <IsaacDetail />
  <CipherBadge />
  <p>{summarizeIsaac(rows)}</p>
</div>

<style>
  .isaac-panel {
    display: flex;
    flex-direction: column;
    gap: 0.5rem;
  }
</style>
