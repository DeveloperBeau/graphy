<script>
  import ThreefishTrend from './ThreefishTrend.svelte';
  import ThreefishDetail from './ThreefishDetail.svelte';
  import CipherBadge from './CipherBadge.svelte';

  export let rows = [];

  function summarizeThreefish(input) {
    return Array.isArray(input) ? input.length : 0;
  }
</script>

<div class="threefish-panel">
  <ThreefishTrend />
  <ThreefishDetail />
  <CipherBadge />
  <p>{summarizeThreefish(rows)}</p>
</div>

<style>
  .threefish-panel {
    display: flex;
    flex-direction: column;
    gap: 0.5rem;
  }
</style>
