<script>
  import KuznyechikTrend from './KuznyechikTrend.svelte';
  import KuznyechikDetail from './KuznyechikDetail.svelte';
  import CipherBadge from './CipherBadge.svelte';

  export let rows = [];

  function summarizeKuznyechik(input) {
    return Array.isArray(input) ? input.length : 0;
  }
</script>

<div class="kuznyechik-panel">
  <KuznyechikTrend />
  <KuznyechikDetail />
  <CipherBadge />
  <p>{summarizeKuznyechik(rows)}</p>
</div>

<style>
  .kuznyechik-panel {
    display: flex;
    flex-direction: column;
    gap: 0.5rem;
  }
</style>
