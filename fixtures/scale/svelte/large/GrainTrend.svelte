<script>
  import TrendSparkline from './TrendSparkline.svelte';

  export let rows = [];

  function trendForGrain(input) {
    return Array.isArray(input) ? input.length : 0;
  }
</script>

<div class="grain-trend">
  <TrendSparkline />
  <p>{trendForGrain(rows)}</p>
</div>

<style>
  .grain-trend {
    display: flex;
    flex-direction: column;
    gap: 0.5rem;
  }
</style>
