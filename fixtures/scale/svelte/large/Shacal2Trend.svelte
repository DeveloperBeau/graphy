<script>
  import TrendSparkline from './TrendSparkline.svelte';

  export let rows = [];

  function trendForShacal2(input) {
    return Array.isArray(input) ? input.length : 0;
  }
</script>

<div class="shacal2-trend">
  <TrendSparkline />
  <p>{trendForShacal2(rows)}</p>
</div>

<style>
  .shacal2-trend {
    display: flex;
    flex-direction: column;
    gap: 0.5rem;
  }
</style>
