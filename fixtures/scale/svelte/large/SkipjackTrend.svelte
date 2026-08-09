<script>
  import TrendSparkline from './TrendSparkline.svelte';

  export let rows = [];

  function trendForSkipjack(input) {
    return Array.isArray(input) ? input.length : 0;
  }
</script>

<div class="skipjack-trend">
  <TrendSparkline />
  <p>{trendForSkipjack(rows)}</p>
</div>

<style>
  .skipjack-trend {
    display: flex;
    flex-direction: column;
    gap: 0.5rem;
  }
</style>
