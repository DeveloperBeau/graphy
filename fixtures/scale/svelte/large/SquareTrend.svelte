<script>
  import TrendSparkline from './TrendSparkline.svelte';

  export let rows = [];

  function trendForSquare(input) {
    return Array.isArray(input) ? input.length : 0;
  }
</script>

<div class="square-trend">
  <TrendSparkline />
  <p>{trendForSquare(rows)}</p>
</div>

<style>
  .square-trend {
    display: flex;
    flex-direction: column;
    gap: 0.5rem;
  }
</style>
