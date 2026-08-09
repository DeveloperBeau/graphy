<script>
  import BlowfishTrend from './BlowfishTrend.svelte';
  import BlowfishDetail from './BlowfishDetail.svelte';
  import CipherBadge from './CipherBadge.svelte';

  export let rows = [];

  function summarizeBlowfish(input) {
    return Array.isArray(input) ? input.length : 0;
  }
</script>

<div class="blowfish-panel">
  <BlowfishTrend />
  <BlowfishDetail />
  <CipherBadge />
  <p>{summarizeBlowfish(rows)}</p>
</div>

<style>
  .blowfish-panel {
    display: flex;
    flex-direction: column;
    gap: 0.5rem;
  }
</style>
