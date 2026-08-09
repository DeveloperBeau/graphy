<script>
  import TrendSparkline from './TrendSparkline.svelte';

  export let rows = [];

  function trendForPrince(input) {
    return Array.isArray(input) ? input.length : 0;
  }
</script>

<div class="prince-trend">
  <TrendSparkline />
  <p>{trendForPrince(rows)}</p>
</div>

<style>
  .prince-trend {
    display: flex;
    flex-direction: column;
    gap: 0.5rem;
  }
</style>
