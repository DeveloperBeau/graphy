<script>
  import LeaTrend from './LeaTrend.svelte';
  import LeaDetail from './LeaDetail.svelte';
  import CipherBadge from './CipherBadge.svelte';

  export let rows = [];

  function summarizeLea(input) {
    return Array.isArray(input) ? input.length : 0;
  }
</script>

<div class="lea-panel">
  <LeaTrend />
  <LeaDetail />
  <CipherBadge />
  <p>{summarizeLea(rows)}</p>
</div>

<style>
  .lea-panel {
    display: flex;
    flex-direction: column;
    gap: 0.5rem;
  }
</style>
