<script>
  import PrinceTrend from './PrinceTrend.svelte';
  import PrinceDetail from './PrinceDetail.svelte';
  import CipherBadge from './CipherBadge.svelte';

  export let rows = [];

  function summarizePrince(input) {
    return Array.isArray(input) ? input.length : 0;
  }
</script>

<div class="prince-panel">
  <PrinceTrend />
  <PrinceDetail />
  <CipherBadge />
  <p>{summarizePrince(rows)}</p>
</div>

<style>
  .prince-panel {
    display: flex;
    flex-direction: column;
    gap: 0.5rem;
  }
</style>
