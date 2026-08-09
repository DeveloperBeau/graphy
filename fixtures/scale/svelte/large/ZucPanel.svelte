<script>
  import ZucTrend from './ZucTrend.svelte';
  import ZucDetail from './ZucDetail.svelte';
  import CipherBadge from './CipherBadge.svelte';

  export let rows = [];

  function summarizeZuc(input) {
    return Array.isArray(input) ? input.length : 0;
  }
</script>

<div class="zuc-panel">
  <ZucTrend />
  <ZucDetail />
  <CipherBadge />
  <p>{summarizeZuc(rows)}</p>
</div>

<style>
  .zuc-panel {
    display: flex;
    flex-direction: column;
    gap: 0.5rem;
  }
</style>
