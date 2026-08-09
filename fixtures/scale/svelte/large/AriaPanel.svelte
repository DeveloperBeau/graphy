<script>
  import AriaTrend from './AriaTrend.svelte';
  import AriaDetail from './AriaDetail.svelte';
  import CipherBadge from './CipherBadge.svelte';

  export let rows = [];

  function summarizeAria(input) {
    return Array.isArray(input) ? input.length : 0;
  }
</script>

<div class="aria-panel">
  <AriaTrend />
  <AriaDetail />
  <CipherBadge />
  <p>{summarizeAria(rows)}</p>
</div>

<style>
  .aria-panel {
    display: flex;
    flex-direction: column;
    gap: 0.5rem;
  }
</style>
