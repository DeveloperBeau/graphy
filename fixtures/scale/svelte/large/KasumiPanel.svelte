<script>
  import KasumiTrend from './KasumiTrend.svelte';
  import KasumiDetail from './KasumiDetail.svelte';
  import CipherBadge from './CipherBadge.svelte';

  export let rows = [];

  function summarizeKasumi(input) {
    return Array.isArray(input) ? input.length : 0;
  }
</script>

<div class="kasumi-panel">
  <KasumiTrend />
  <KasumiDetail />
  <CipherBadge />
  <p>{summarizeKasumi(rows)}</p>
</div>

<style>
  .kasumi-panel {
    display: flex;
    flex-direction: column;
    gap: 0.5rem;
  }
</style>
