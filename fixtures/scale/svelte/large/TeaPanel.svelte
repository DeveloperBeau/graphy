<script>
  import TeaTrend from './TeaTrend.svelte';
  import TeaDetail from './TeaDetail.svelte';
  import CipherBadge from './CipherBadge.svelte';

  export let rows = [];

  function summarizeTea(input) {
    return Array.isArray(input) ? input.length : 0;
  }
</script>

<div class="tea-panel">
  <TeaTrend />
  <TeaDetail />
  <CipherBadge />
  <p>{summarizeTea(rows)}</p>
</div>

<style>
  .tea-panel {
    display: flex;
    flex-direction: column;
    gap: 0.5rem;
  }
</style>
