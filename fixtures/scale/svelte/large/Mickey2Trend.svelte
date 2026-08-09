<script>
  import TrendSparkline from './TrendSparkline.svelte';

  export let rows = [];

  function trendForMickey2(input) {
    return Array.isArray(input) ? input.length : 0;
  }
</script>

<div class="mickey2-trend">
  <TrendSparkline />
  <p>{trendForMickey2(rows)}</p>
</div>

<style>
  .mickey2-trend {
    display: flex;
    flex-direction: column;
    gap: 0.5rem;
  }
</style>
