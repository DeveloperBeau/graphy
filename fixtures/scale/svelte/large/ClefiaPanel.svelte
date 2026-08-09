<script>
  import ClefiaTrend from './ClefiaTrend.svelte';
  import ClefiaDetail from './ClefiaDetail.svelte';
  import CipherBadge from './CipherBadge.svelte';

  export let rows = [];

  function summarizeClefia(input) {
    return Array.isArray(input) ? input.length : 0;
  }
</script>

<div class="clefia-panel">
  <ClefiaTrend />
  <ClefiaDetail />
  <CipherBadge />
  <p>{summarizeClefia(rows)}</p>
</div>

<style>
  .clefia-panel {
    display: flex;
    flex-direction: column;
    gap: 0.5rem;
  }
</style>
