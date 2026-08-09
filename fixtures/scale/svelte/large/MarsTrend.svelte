<script>
  import TrendSparkline from './TrendSparkline.svelte';

  export let rows = [];

  function trendForMars(input) {
    return Array.isArray(input) ? input.length : 0;
  }
</script>

<div class="mars-trend">
  <TrendSparkline />
  <p>{trendForMars(rows)}</p>
</div>

<style>
  .mars-trend {
    display: flex;
    flex-direction: column;
    gap: 0.5rem;
  }
</style>
