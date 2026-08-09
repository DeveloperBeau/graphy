<script>
  import SkipjackTrend from './SkipjackTrend.svelte';
  import SkipjackDetail from './SkipjackDetail.svelte';
  import CipherBadge from './CipherBadge.svelte';

  export let rows = [];

  function summarizeSkipjack(input) {
    return Array.isArray(input) ? input.length : 0;
  }
</script>

<div class="skipjack-panel">
  <SkipjackTrend />
  <SkipjackDetail />
  <CipherBadge />
  <p>{summarizeSkipjack(rows)}</p>
</div>

<style>
  .skipjack-panel {
    display: flex;
    flex-direction: column;
    gap: 0.5rem;
  }
</style>
