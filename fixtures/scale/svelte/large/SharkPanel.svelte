<script>
  import SharkTrend from './SharkTrend.svelte';
  import SharkDetail from './SharkDetail.svelte';
  import CipherBadge from './CipherBadge.svelte';

  export let rows = [];

  function summarizeShark(input) {
    return Array.isArray(input) ? input.length : 0;
  }
</script>

<div class="shark-panel">
  <SharkTrend />
  <SharkDetail />
  <CipherBadge />
  <p>{summarizeShark(rows)}</p>
</div>

<style>
  .shark-panel {
    display: flex;
    flex-direction: column;
    gap: 0.5rem;
  }
</style>
