<script>
  import TrendSparkline from './TrendSparkline.svelte';

  export let rows = [];

  function trendForSafer(input) {
    return Array.isArray(input) ? input.length : 0;
  }
</script>

<div class="safer-trend">
  <TrendSparkline />
  <p>{trendForSafer(rows)}</p>
</div>

<style>
  .safer-trend {
    display: flex;
    flex-direction: column;
    gap: 0.5rem;
  }
</style>
