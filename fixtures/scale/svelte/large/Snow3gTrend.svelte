<script>
  import TrendSparkline from './TrendSparkline.svelte';

  export let rows = [];

  function trendForSnow3g(input) {
    return Array.isArray(input) ? input.length : 0;
  }
</script>

<div class="snow3g-trend">
  <TrendSparkline />
  <p>{trendForSnow3g(rows)}</p>
</div>

<style>
  .snow3g-trend {
    display: flex;
    flex-direction: column;
    gap: 0.5rem;
  }
</style>
