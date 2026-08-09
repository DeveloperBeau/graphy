<script>
  import SquareTrend from './SquareTrend.svelte';
  import SquareDetail from './SquareDetail.svelte';
  import CipherBadge from './CipherBadge.svelte';

  export let rows = [];

  function summarizeSquare(input) {
    return Array.isArray(input) ? input.length : 0;
  }
</script>

<div class="square-panel">
  <SquareTrend />
  <SquareDetail />
  <CipherBadge />
  <p>{summarizeSquare(rows)}</p>
</div>

<style>
  .square-panel {
    display: flex;
    flex-direction: column;
    gap: 0.5rem;
  }
</style>
