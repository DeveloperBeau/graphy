<script>
  import TrendSparkline from './TrendSparkline.svelte';

  export let rows = [];

  function trendForThreeway(input) {
    return Array.isArray(input) ? input.length : 0;
  }
</script>

<div class="threeway-trend">
  <TrendSparkline />
  <p>{trendForThreeway(rows)}</p>
</div>

<style>
  .threeway-trend {
    display: flex;
    flex-direction: column;
    gap: 0.5rem;
  }
</style>
